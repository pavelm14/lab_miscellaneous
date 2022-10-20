#######################################################
# SETUP -- libraries/BioGeoBEARS updates
#######################################################
# Load necessary packages
library(ape)
library(BioGeoBEARS)

#######################################################
# SETUP: YOUR WORKING DIRECTORY
#######################################################
# default here is your home directory ("~")
#####CHANGE THIS ACCORDINGLY #####
wd = np("C:/Users/pavel/Documents/GACR2022_AForest/outreach/tutorials/biogeography")
setwd(wd)

#######################################################
# SETUP: YOUR TREE FILE AND GEOGRAPHY FILE
#######################################################
#######################################################
trfn = np(paste(addslash(wd), "./example.tre", sep=""))
tr = read.tree(trfn)

#######################################################
# Geography file
######################################################
geogfn = np(paste(addslash(wd), "./distribution.phy", sep=""))
tipranges = getranges_from_LagrangePHYLIP(lgdata_fn=geogfn)

###########################################
# Get the relative branches lenght per time bin
###########################################
load("./MASTER_ana_events_tables.RData")	
load("./MASTER_clado_events_tables.RData")	
load("./MASTER_counts_list.RData")	

# Find the highest time bin across all trees
max.bin = NULL
	nodes = max(clado_events_tables[[1]]$time_bp)
	max.bin = c(max.bin, ceiling(nodes))

	summary.br.ls = NULL
	# The number of tips in the phylogeny
	ntips = length(tr$tip.label)
	
	# Remove the first "ntips" values of node ages from the phylogeny. This will result in only internal node ages
	nodes = sort(clado_events_tables[[1]]$time_bp)[(ntips+1):length(clado_events_tables[[1]]$time_bp)]
	
	nbinx = 0
	nbiny = 0
	for (k in seq(from=1, to=max(max.bin), by=1))
		{
		every = 1 #Size of the bin
		nbiny = (nbinx + every)
		bin = nodes[which(nodes > nbinx & nodes < nbiny)]
		bins.before = nodes[which(nodes > nbiny)]
		
		# The total length of all branches within each time bin, following Antonelli et al. 2018 PNAS
		# Sum of all absolute branch lengths in the time bin
		br.ls = sum(bin) + length(bins.before) + 1
		
		# Sum of all relative branch lengths with respect to bin size
		br.ls.bin = br.ls - (length(bin)*nbinx)
		
		# Summary branch lengths per bin
		summary.br.ls[[k]] = c() # Make sure this is empyty! Previously for some strange reasons, previous steps filled it with random numbers
		summary.br.ls[[k]] = c(nbinx, nbiny, length(bin), br.ls.bin)
		
		nbinx = nbinx + every
		}

# The structure of summary.br.ls is Bin Number: [Bin Start: Bin End: Number of nodes in Bin: Sum of Branch Lengths]
# For example summary.br.ls[[2]][4] will give you the Sum of Branch Lengths for the Bin 2 (1 to 2 Mya)

###########################################
# Get the absolute numbers of dispersal events per time bin
###########################################
areas = getareas_from_tipranges_object(tipranges)

# Combination of pairwise areas (dispersal between single areas)
pairwise.dispersal = combn(areas, 2) 

	summary.event.names = c()
	summary.event.names = c("bin0", "bin1")
	for (i in 1:ncol(pairwise.dispersal))
		{
		events = paste(pairwise.dispersal[,i][1], "->", pairwise.dispersal[,i][2], sep="")
		summary.event.names = append(summary.event.names, events)
		events = paste(pairwise.dispersal[,i][2], "->", pairwise.dispersal[,i][1], sep="")
		summary.event.names = append(summary.event.names, events)
		}

	summary.event.ls = NULL
	rates.disp.t = NULL
	
	nbinx = 0
	nbiny = 0
	for (k in seq(from=1, to=max(max.bin), by=1))
		{
		every = 1 #Size of bin
		nbiny = (nbinx + every)
		bin = nodes[which(nodes > nbinx & nodes < nbiny)]

		# Summary branch lengths per bin
		summary.event.ls[[k]] = c() # Make sure this is empyty! Previously for some strange reasons, previous steps filled it with random numbers		
		summary.event.ls[[k]] = c(nbinx, nbiny)

		for (i in 1:ncol(pairwise.dispersal))
			{
			disp.event = NULL
			for (m in 1:length(ana_events_tables))
				{
				events = which(ana_events_tables[[m]]$ana_dispersal_from == pairwise.dispersal[,i][1] & ana_events_tables[[m]]$dispersal_to == pairwise.dispersal[,i][2])
				if (length(events) > 0)
					{
					for (j in 1:length(events))
						{
						disp.event = c(disp.event, ana_events_tables[[m]]$abs_event_time[[events[[j]]]])
						}
					}
				}
			# The absolute number of dispersal events within each time bin, following Antonelli et al. 2018 PNAS
			# Sum of all absolute dispersal events in the time bin
			disp.bin = length(disp.event[which(disp.event > nbinx & disp.event < nbiny)]) / length(ana_events_tables)
			# Get the relative dispersal by branch lenghts inn the time bin
			disp.bin = disp.bin / summary.br.ls[[k]][4]
			summary.event.ls[[k]] = append(summary.event.ls[[k]], disp.bin)

			# Now the dispersal events in the opposite direction
			disp.event = NULL
			for (m in 1:length(ana_events_tables))
				{
				events = which(ana_events_tables[[m]]$ana_dispersal_from == pairwise.dispersal[,i][2] & ana_events_tables[[m]]$dispersal_to == pairwise.dispersal[,i][1])
				if (length(events) > 0)
					{
					for (j in 1:length(events))
						{
						disp.event = c(disp.event, ana_events_tables[[m]]$abs_event_time[[events[[j]]]])
						}
					}
				}
			disp.bin = length(disp.event[which(disp.event > nbinx & disp.event < nbiny)]) / length(ana_events_tables)
			disp.bin = disp.bin / summary.br.ls[[k]][4]
			summary.event.ls[[k]] = append(summary.event.ls[[k]], disp.bin)
			}

		names(summary.event.ls[[k]]) = summary.event.names
		rates.disp.t = rbind(rates.disp.t, summary.event.ls[[k]])

		nbinx = nbinx + every
		}

colnames(rates.disp.t) = summary.event.names

# The structure of summary.event.ls is Bin Number: [Bin Start: Bin End: Number of nodes in Bin: pairwise dispersal between all areas]
# For example summary.event.ls[[2]][4] will give you the Absolute Number of Dispersal Events for the Bin 2 (1 to 2 Mya)

########
# Let's now plot a dispersal through time plot
# In this example, we explore dispersal between the areas "A" and "B"
# Replace accordingly the area letters that you are interested in
areas

# Total dispersal between areas "A" and "B" in both directions
plot(x = ((rates.disp.t[,"bin1"] + rates.disp.t[,"bin0"]) / 2), y = (rates.disp.t[,"A->B"] + rates.disp.t[,"B->A"]), col = "purple", pch = 19, type = "o", lwd = 2, xlab = "Time (Mya)", ylab = "Relative dispersal")
# Dispersal from "A" to "B"
lines(x = ((rates.disp.t[,"bin1"] + rates.disp.t[,"bin0"]) / 2), y = rates.disp.t[,"A->B"], col = "red", pch = 19, type = "b")
# Dispersal from "B" to "A"
lines(x = ((rates.disp.t[,"bin1"] + rates.disp.t[,"bin0"]) / 2), y = rates.disp.t[,"B->A"], col = "blue", pch = 19, type = "b")

legend(x=3/4*nrow(rates.disp.t), y=max((rates.disp.t[,"A->B"] + rates.disp.t[,"B->A"])), legend=c("A <=> B", "A -> B", "B -> A"), col=c("purple", "red", "blue"), lty=1:1)

########
# QGRAPH. Look at here http://sachaepskamp.com/qgraph/examples#UNWEIGHTED_DIRECTED_GRAPHS
# Here we will visualize the dispersal counts between areas
########
library(qgraph)

events = count_ana_clado_events(clado_events_tables, ana_events_tables, areanames = areas, actual_names = areas, timeperiod = c(0,nrow(rates.disp.t)))

qgraph(events$all_dispersals_counts_fromto_means, edge.labels = TRUE, cut = 2)
title(paste("Total dispersal counts 0 -", nrow(rates.disp.t), "Mya"))

# Not let's plot dispersal through time across different periods
# In this example, we divide the entire evolutionary history in two periods
# and plot dispersal rates between areas in each time period
events.1 = count_ana_clado_events(clado_events_tables, ana_events_tables, areanames = areas, actual_names = areas, timeperiod = c(0,nrow(rates.disp.t)/2))
events.2 = count_ana_clado_events(clado_events_tables, ana_events_tables, areanames = areas, actual_names = areas, timeperiod = c(nrow(rates.disp.t)/2,nrow(rates.disp.t)))

par(mfrow=c(2,2))
qgraph(events.1$all_dispersals_counts_fromto_means, edge.labels = TRUE, cut = 2)
title(paste("Dispersal counts 0 -", nrow(rates.disp.t)/2, "Mya"))
qgraph(events.2$all_dispersals_counts_fromto_means, edge.labels = TRUE, cut = 2)
title(paste("Dispersal counts", nrow(rates.disp.t)/2, "-", nrow(rates.disp.t), "Mya"))

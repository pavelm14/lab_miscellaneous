#######################################################
# SETUP -- libraries/BioGeoBEARS updates
#######################################################
# Load necessary packages
library(BioGeoBEARS)

#######################################################
# SETUP: YOUR WORKING DIRECTORY
#######################################################
# default here is your home directory ("~")
#####CHANGE THIS ACCORDINGLY #####
wd = np("C:/Users/pavel/Documents/GACR2022_AForest/outreach/tutorials/biogeography")
setwd(wd)

#######################################################
# Stochastic mapping using the DEC model
#######################################################
clado_events_tables = NULL
ana_events_tables = NULL
counts_list = NULL
lnum = 0

#######################################################
# Get the inputs for Biogeographical Stochastic Mapping
#######################################################

	runslow = FALSE #This is very important! Above we just ran the DEC analysis on a single tree. Here we just want to load those results!!!
	resfn = "./exampleDEC.Rdata"
	if (runslow)
		{
		res = bears_optim_run(BioGeoBEARS_run_object)
		res    
		save(res, file=resfn)
		} else {
				# Loads to "res"
				load(resfn)
		}

	BSM_inputs_fn = paste0(wd, "BSM_inputs_file.Rdata")
	runInputsSlow = TRUE
	if (runInputsSlow)
		{
		stochastic_mapping_inputs_list = get_inputs_for_stochastic_mapping(res=res)
    save(stochastic_mapping_inputs_list, file=BSM_inputs_fn)
    } else {
    # Loads to "stochastic_mapping_inputs_list"
    load(BSM_inputs_fn)
    } # END if (runInputsSlow)
	
	# Check inputs (doesn't work the same on unconstr)
	names(stochastic_mapping_inputs_list)
	stochastic_mapping_inputs_list$phy2
	stochastic_mapping_inputs_list$COO_weights_columnar
	stochastic_mapping_inputs_list$unconstr
	set.seed(seed=as.numeric(Sys.time()))

	runBSMslow = TRUE
	if (runBSMslow == TRUE)
		{
		# Saves to: RES_clado_events_tables.Rdata
		# Saves to: RES_ana_events_tables.Rdata
		BSM_output = runBSM(res, stochastic_mapping_inputs_list=stochastic_mapping_inputs_list, maxnum_maps_to_try=15, nummaps_goal=10, maxtries_per_branch=4000, save_after_every_try=TRUE, savedir=getwd(), seedval=12345, wait_before_save=0.01)

		RES_clado_events_tables = BSM_output$RES_clado_events_tables
		RES_ana_events_tables = BSM_output$RES_ana_events_tables
		} else {
		# Load previously saved...

		# Loads to: RES_clado_events_tables
		load(file="RES_clado_events_tables.Rdata")
		# Loads to: RES_ana_events_tables
		load(file="RES_ana_events_tables.Rdata")
		BSM_output = NULL
		BSM_output$RES_clado_events_tables = RES_clado_events_tables
		BSM_output$RES_ana_events_tables = RES_ana_events_tables
		} # END if (runBSMslow == TRUE)

	# Extract BSM output
	clado_events_tables = BSM_output$RES_clado_events_tables
	ana_events_tables = BSM_output$RES_ana_events_tables

	#######################################################
	# Summarize stochastic map tables
	#######################################################
	#######################################################
	# Get the area names
	######################################################
	geogfn = np(paste(addslash(wd), "./distribution.phy", sep=""))
	tipranges = getranges_from_LagrangePHYLIP(lgdata_fn=geogfn)

	areanames = names(tipranges@df)
	actual_names = areanames
	actual_names
	
	# Simulate the source areas
	BSMs_w_sourceAreas = NULL
	BSMs_w_sourceAreas = simulate_source_areas_ana_clado(res, clado_events_tables, ana_events_tables, areanames)
	clado_events_tables = BSMs_w_sourceAreas$clado_events_tables
	ana_events_tables = BSMs_w_sourceAreas$ana_events_tables
	
	# Count all anagenetic and cladogenetic events
	counts_list = count_ana_clado_events(clado_events_tables, ana_events_tables, areanames, actual_names)

save(ana_events_tables, file = "MASTER_ana_events_tables.RData")	
save(clado_events_tables, file = "MASTER_clado_events_tables.RData")	
save(counts_list, file = "MASTER_counts_list.RData")	

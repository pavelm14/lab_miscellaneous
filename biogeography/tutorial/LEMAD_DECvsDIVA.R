#######################################################
# SETUP -- libraries updates
#######################################################
# Load necessary packages
library(ape)
library(DDD)
library(lemad)

#######################################################
# SETUP: YOUR WORKING DIRECTORY
#######################################################
# default here is your home directory ("~")
#####CHANGE THIS ACCORDINGLY #####
setwd("C:/Users/pavel/Documents/GACR2022_AForest/outreach/tutorials/biogeography")

#######################################################
# SETUP: YOUR TREE FILE AND GEOGRAPHY FILE
#######################################################
#######################################################
tr = read.tree("example.tre")

#######################################################
# Geography file - 
# Make sure it matches both order and names with the tree file
######################################################
distribution = read.csv("distribution.csv")
rownames(distribution) <- distribution$species
geiger:::name.check(tr, distribution, data.names=NULL)

## [1] "OK"

distribution$region <- toupper(distribution$region)
distribution <- distribution[order(match(distribution$species, tr$tip.label)),]

(distribution$species) == (tr$tip.label)

## It should all be "TRUE"

#######################################################
# LEMAD variables - DEC analysis
######################################################
phylotree_recons <- tr
species_presence <- distribution$region

## In case distribution coding is unsorted (e.g., BAC instead of ABC):
#for(ik in 1:length(species_presence)){
#  string_to_sort <- species_presence[ik]
#  species_presence[ik] <- paste(sort(unlist(strsplit(string_to_sort, ""))), collapse = "")
#}

## Specify the areas in the analysis, matching the distribution.csv file
all_areas <- c("A","B","C", "D")

## In case you know the proportion of missing species in certain (not necessarily all) areas:
#missing_spp_areas <- list()
#missing_spp_areas[[1]] <- c("A","C","AB")
#missing_spp_areas[[2]] <- c(0.8,0.57,0.83)

## If all species in all areas were sampled:
missing_spp_areas <- list()
missing_spp_areas[1] <- list(NULL)
missing_spp_areas[2] <- list(NULL)

## Number of max areas; it can be the same input as in BioGeoBEARS
num_max_multiregion <- 2

## Lineage extinction rate, freely estimated or fixed and then compared via model likelihoods:
lineage_extinction <- "free"
#lineage_extinction <- 0.001

## If preferred, initial values of Lineage speciation rate (both in-situ and vicariance) can be set:
initial_lambda <- NULL
#initial_lambda <- c(0.01,0.01)

## If preferred, initial values of biogeographical dispersal/extirpation can be set:
initial_disperextirpation <- NULL
#initial_disperextirpation <- 0.002

## Setting the DEC model; If FALSE, the DIVA model is activated:
DEC_events <- TRUE
#DEC_events <- FALSE

## If preferred, root conditioning can be applied (e.g., assumption that the root lineage occupied area A):
condition_on_origin <- NULL
#condition_on_origin <- A

## Running the LEMAD with DEC events activated:
output_vig <- lemad_analysis(
 phylotree_recons,
 species_presence,
 areas = all_areas,
 num_max_multiregion,
 condition_on_origin,
 DEC_events,
 missing_spp_areas = missing_spp_areas,
 lineage_extinction = lineage_extinction,
 initial_lambda = initial_lambda,
 initial_disperextirpation = initial_disperextirpation,
 run_parallel = FALSE,
 use_fortran_code = TRUE)

save(output_vig, file = "LEMAD_DEC.Rdata")
#load("LEMAD_DEC.Rdata")

## Plotting the areas with max. probabilities on each node:
DF = output_vig$ancestral_states
plot(tr)
nodelabels(text = colnames(DF)[max.col(DF,ties.method="first")], node = as.numeric(rownames(DF)))

#######################################################
# LEMAD variables - DIVA analysis
######################################################
## Setting the DIVA model:
DEC_events <- FALSE

## Running the LEMAD with DIVA events activated:
output_vig_DIVA <- lemad_analysis(
 phylotree_recons,
 species_presence,
 areas = all_areas,
 num_max_multiregion,
 condition_on_origin,
 DEC_events,
 missing_spp_areas = missing_spp_areas,
 lineage_extinction = lineage_extinction,
 initial_lambda = initial_lambda,
 initial_disperextirpation = initial_disperextirpation,
 run_parallel = FALSE,
 use_fortran_code = TRUE)

save(output_vig, file = "LEMAD_DIVA.Rdata")
#load("LEMAD_DIVA.Rdata")

## Plotting the areas with max. probabilities on each node:
DF = output_vig$ancestral_states
plot(tr)
nodelabels(text = colnames(DF)[max.col(DF,ties.method="first")], node = as.numeric(rownames(DF)))

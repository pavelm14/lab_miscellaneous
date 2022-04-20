################################# BioGeoBEARS ########################################
# The following script has been modified from http://phylo.wikidot.com/biogeobears#script
# There you can find more functionalities and model-based testing of biogeographical models

############################## Pre-installation #####################################
# Check that all the needed packages are installed
# If any is not, it will install locally in our R packages directory

chooseCRANmirror(ind = 29)
if(!require(ape))install.packages('ape', lib="/storage/praha1/home/pavelmatos/software/R/packages")
if(!require(geiger))install.packages('geiger', lib="/storage/praha1/home/pavelmatos/software/R/packages")

if(!require(GenSA))install.packages('GenSA', lib="/storage/praha1/home/pavelmatos/software/R/packages")
if(!require(FD))install.packages('FD', lib="/storage/praha1/home/pavelmatos/software/R/packages")
if(!require(snow))install.packages('snow', lib="/storage/praha1/home/pavelmatos/software/R/packages")
if(!require(parallel))install.packages('parallel', lib="/storage/praha1/home/pavelmatos/software/R/packages")

if(!require(rexpokit))install.packages('rexpokit', lib="/storage/praha1/home/pavelmatos/software/R/packages")
if(!require(cladoRcpp))install.packages('cladoRcpp', lib="/storage/praha1/home/pavelmatos/software/R/packages")

# With these packages installed, all of the BioGeoBEARS updates can be installed from GitHub
if(!require(devtools))install.packages('devtools', lib="/storage/praha1/home/pavelmatos/software/R/packages")
library(devtools, lib.loc="/storage/praha1/home/pavelmatos/software/R/packages")

if(!require(phytools))devtools::install_github("liamrevell/phytools", lib="/storage/praha1/home/pavelmatos/software/R/packages")

if(!require(BioGeoBEARS))devtools::install_github(repo="nmatzke/BioGeoBEARS", INSTALL_opts="--byte-compile", lib="/storage/praha1/home/pavelmatos/software/R/packages")


#######################################################
# SETUP -- libraries/BioGeoBEARS updates
#######################################################

# Loading here does not need to call the 'lib.loc' because we already added our local directory to the PATH
# Load necessary packages for handling phylogenies
library(ape)
library(geiger)
library(phytools)

# Load the package (after installation, see above).
library(GenSA)    # GenSA is better than optimx (although somewhat slower)
library(FD)       # for FD::maxent() (make sure this is up-to-date)
library(snow)     # (if you want to use multicore functionality; some systems/R versions prefer library(parallel), try either)
library(parallel)

# 5. Finally, run library() on these packages:
library(rexpokit)
library(cladoRcpp)
library(BioGeoBEARS)

#######################################################
# SETUP: YOUR WORKING DIRECTORY
#######################################################
# IMPORTANT!!!
# Do change your MetaCentrum username in this path
wd = "/storage/praha1/home/pavelmatos/lab_miscellaneous/Rpackages/"
setwd(wd)

#######################################################
# SETUP: YOUR TREE FILE AND GEOGRAPHY FILE
#######################################################
# Phylogeny file:
trfn = np(paste(addslash(wd), "tree.tre", sep=""))

# Read tree file in newick format
tr = read.tree(trfn)

#######################################################
# Geography file:
geogfn = np(paste(addslash(wd), "distribution.txt", sep=""))

# Look at your geographic range data:
tipranges = getranges_from_LagrangePHYLIP(lgdata_fn=geogfn)

# Set the maximum number of areas any species may occupy; this cannot be larger 
# than the number of areas you set up, but it can be smaller.
max_range_size = max(rowSums(dfnums_to_numeric(tipranges@df)))

#######################################################
# Run DEC
#######################################################
# Intitialize a default model (DEC model)
BioGeoBEARS_run_object = define_BioGeoBEARS_run()

# Give BioGeoBEARS the location of the phylogeny Newick file
BioGeoBEARS_run_object$trfn = trfn

# Give BioGeoBEARS the location of the geography text file
BioGeoBEARS_run_object$geogfn = geogfn

# Input the maximum range size
BioGeoBEARS_run_object$max_range_size = max_range_size

BioGeoBEARS_run_object$min_branchlength = 0.000001    # Min to treat tip as a direct ancestor (no speciation event)
BioGeoBEARS_run_object$include_null_range = TRUE      # set to FALSE for e.g. DEC* model, DEC*+J, etc.

# Speed options and multicore processing if desired
BioGeoBEARS_run_object$on_NaN_error = -1e50    # returns very low lnL if parameters produce NaN error (underflow check)
BioGeoBEARS_run_object$speedup = TRUE          # shorcuts to speed ML search; use FALSE if worried (e.g. >3 params)
BioGeoBEARS_run_object$use_optimx = TRUE       # if FALSE, use optim() instead of optimx()
BioGeoBEARS_run_object$num_cores_to_use = 2

BioGeoBEARS_run_object$force_sparse = FALSE    # force_sparse=TRUE causes pathology & isn't much faster at this scale
BioGeoBEARS_run_object = readfiles_BioGeoBEARS_run(BioGeoBEARS_run_object)

# Good default settings to get ancestral states
BioGeoBEARS_run_object$return_condlikes_table = TRUE
BioGeoBEARS_run_object$calc_TTL_loglike_from_condlikes_table = TRUE
BioGeoBEARS_run_object$calc_ancprobs = TRUE    # get ancestral states from optim run

# Run this to check inputs. Read the error messages if you get them!
check_BioGeoBEARS_run(BioGeoBEARS_run_object)

# For a slow analysis, run once with TRUE, then set runslow=FALSE to just 
# load the saved result.
runslow = TRUE
resfn = "biogeography.Rdata"
if (runslow)
{
  res = bears_optim_run(BioGeoBEARS_run_object)
  res    
  
  save(res, file=resfn)
  resDEC = res
} else {
  # Loads to "res"
  load(resfn)
  resDEC = res
}

#######################################################
# PDF plot
#######################################################
pdffn = "biogeography_DEC.pdf"
pdf(pdffn, width=6, height=4)

#######################################################
# Plot ancestral states - DEC
#######################################################
analysis_titletxt ="BioGeoBEARS unconstrained DEC"

# Setup
results_object = resDEC
scriptdir = np(system.file("extdata/a_scripts", package="BioGeoBEARS"))

# States
res6 = plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="text", label.offset=0.45, tipcex=0.7, statecex=0.7, splitcex=0.6, titlecex=0.8, plotsplits=TRUE, cornercoords_loc=scriptdir, include_null_range=TRUE, tr=tr, tipranges=tipranges)

# Pie chart
plot_BioGeoBEARS_results(results_object, analysis_titletxt, addl_params=list("j"), plotwhat="pie", label.offset=0.45, tipcex=0.7, statecex=0.7, splitcex=0.6, titlecex=0.8, plotsplits=TRUE, cornercoords_loc=scriptdir, include_null_range=TRUE, tr=tr, tipranges=tipranges)

dev.off()  # Turn off PDF
cmdstr = paste("open ", pdffn, sep="")
system(cmdstr) # Plot it

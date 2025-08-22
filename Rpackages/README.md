# Installing R packages

Several R packages designed for evolutionary studies are already installed in the MetaCentrum. However, you might want to use R packages that are not there yet. In those cases, you need to install them locally at your home directory in MetaCentrum.

In this tutorial, we will work using the Metacentrum's frontend 'praha1' (address: tarkil.grid.cesnet.cz), which has OS Debian 12. More information about frontends at https://docs.metacentrum.cz/en/docs/computing/infrastructure/frontends

First, you need to create a working directory as the default to install and load R packages from.

```bash
##in the MobaXterm terminal, log in to the MetaCentrum
##remember to replace the 'username' with yours!
ssh -x username@tarkil.grid.cesnet.cz

#create a subdirectory where to store R packages
mkdir -p software/R/packages
```

By the time of writing this tutorial (August 2024), the latest R version installed in Metacentrum was `R-4.4.0-gcc`.

```bash
module add r/4.4.0-gcc-10.2.1-ssuwpvb
##if you want to use the latest available R version in MetaCentrum, use `module avail` to see the list of modules/programs

##to open the R console
R
```

Once in the R console, you will be able to install and load packages from a local directory.

```R
##let's install `devtools` to easily install other R packages from GitHub
##remember to install the package at your local library collection
install.packages("devtools", lib="/storage/praha1/home/pavelmatos/software/R/packages")

#you need to select the CRAN mirror.
#type 28 (Czech Republic), and enter

#let's load the locally installed `devtools`
library(devtools, lib.loc="/storage/praha1/home/pavelmatos/software/R/packages")

##to install packages from GitHub, we will use the devtools' function `install_github`. In this case, we will install the R package BioGeoBEARS
devtools::install_github(repo="nmatzke/BioGeoBEARS", INSTALL_opts="--byte-compile", lib="/storage/praha1/home/pavelmatos/software/R/packages")

#it will ask you to update packages
#type 3 (None), and enter

##to quit R
q()
```

# Running R scripts at the MetaCentrum
## Historical biogeography using BioGeoBEARS

You need to copy to your working directory in MetaCentrum, the following files:
* `tree.tre` (a 5-species time-calibrated phylogeny in newick format),
* `distribution.txt` (the geography file for the 5 species in the phylogeny),
* `script.r` (the instructions for running the DEC biogeographical model - modified from http://phylo.wikidot.com/biogeobears#script), and
* `qsub.sh` (the instructions for running the R script in MetaCentrum).

Note that you need to slightly modify the `script.r` and `qsub.sh` files to indicate your username at the MetaCentrum

```bash
##to copy the four files to your MetaCentrum
##in the MobaXterm terminal, log in to the MetaCentrum, if you are not there yet
ssh -x pavelmatos@tarkil.grid.cesnet.cz

#clone this repository to your working space
git clone https://github.com/pavelm14/lab_miscellaneous.git

#the four files should be already there
#go to your working directory
cd lab_miscellaneous/Rpackages

#submit your job (R script) to the MetaCentrum
qsub qsub.sh
```

### References

#### R package `BioGeoBEARS`
- GitHub repository: https://github.com/nmatzke/BioGeoBEARS

- Matzke (2018) BioGeoBEARS: BioGeography with Bayesian (and likelihood) Evolutionary Analysis with R Scripts. version 1.1.1, published on GitHub on November 6, 2018. DOI: [http://dx.doi.org/10.5281/zenodo.1478250](http://dx.doi.org/10.5281/zenodo.1478250)

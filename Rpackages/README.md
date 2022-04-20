# Installing R packages

Several R packages designed for evolutionary studies are already installed in the MetaCentrum. However, you might want to use R packages that are not there yet. In those cases, you need to install them locally at your home directory in MetaCentrum.

First, you need to set a directory as default to install and load R packages from.

```bash
##in the MobaXterm terminal, log in to the MetaCentrum
##remember to replace my username 'pavelmatos' with yours!
ssh -x pavelmatos@tarkil.grid.cesnet.cz

#create a subdirectory where to store r packages
mkdir -p software/R/packages
```

By the time of writing this tutorial (April 2022), the latest R version installed in MetaCentrum was `R-4.0.0-gcc`. You can of course install your own R version locally at your home directory.

```bash
module add R-4.0.0-gcc
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
#type 29 (Czech republic), and enter

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

You need to copy to your working directory in MetaCentrum, the files following files: i) `tree.tre` (a 5-species time-calibrated phylogeny in newick format) ii) `distribution.txt` (the geography file for the 5 species in the phylogeny), iii) `script.r` (the instructions for running the DEC biogeographical model - modified from http://phylo.wikidot.com/biogeobears#script), and iv) `qsub.sh` (the instructions for running the R script in MetaCentrum).

Note that you need to slightly modify the `script.r` and `qsub.sh` files to indicate your username at the MetaCentrum

```bash
##in the MobaXterm terminal, log in to the MetaCentrum
ssh -x pavelmatos@tarkil.grid.cesnet.cz

pavelmatos@nympha:~$
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

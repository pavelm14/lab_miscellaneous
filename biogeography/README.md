# Historical biogeography inference

This is a tutorial to estimate ancestral distributional areas and macroevolutionary dispersal through time between areas.

We use model-based inferences using the R package BioGeoBEARS ([Matzke, 2013](https://doi.org/10.21425/F5FBG19694)). For more information about the functionalities, please visit the program's wiki: http://phylo.wikidot.com/biogeobears

For people aiming to run the analyses using the Czech computer cluster [Metacentrum](https://metavo.metacentrum.cz/en/index.html), you can follow our tutorial ([click here](https://github.com/pavelm14/lab_miscellaneous/tree/main/Rpackages)) describing the process of installing R packages and running R scripts there.

## Input files

- A time-calibrated molecular phylogeny in Newick format
- A distributional matrix containing the extant areas occupied by each species in the study phylogeny

## Running a biogeographical model in BioGeoBEARS

First, install the R package BioGeoBEARS and its dependencies in R (> 3.3.2) following the wiki's description at: http://phylo.wikidot.com/biogeobears#toc3

Second, we will infer historical biogeography parameters using the DEC model ([Ree et al. 2015](https://doi.org/10.1111/j.0014-3820.2005.tb00940.x); [Ree & Smith 2018](https://doi.org/10.1080/10635150701883881)) in a maximum-likelihood framework. You can use our modified script based from: http://phylo.wikidot.com/biogeobears#toc29. Find our script here.

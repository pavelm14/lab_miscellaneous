# Historical biogeography inference

This is a tutorial to estimate ancestral distributional areas and macroevolutionary dispersal through time between areas.

We use model-based inferences using the R package BioGeoBEARS ([Matzke, 2013](https://doi.org/10.21425/F5FBG19694)). For more information about the functionalities, please visit the program's wiki: http://phylo.wikidot.com/biogeobears

For people aiming to run the analyses using the Czech computer cluster [Metacentrum](https://metavo.metacentrum.cz/en/index.html), you can follow our tutorial ([click here](https://github.com/pavelm14/lab_miscellaneous/tree/main/Rpackages)) describing the process of installing R packages and running R scripts there.

## Input files

- A time-calibrated molecular phylogeny in Newick format
- A distributional matrix containing the extant areas occupied by each species in the study phylogeny

## Running a biogeographical model in BioGeoBEARS

First, install the R package BioGeoBEARS and its dependencies in R (> 3.3.2) following the description at: https://github.com/nmatzke/BioGeoBEARS. You will also need the R packages [ape](https://doi.org/10.1093/bioinformatics/btg412) (handling phylogenies) and [qgraph](https://doi.org/10.18637/jss.v048.i04) (plotting dispersal counts between areas) installed.

Second, we will infer historical biogeography parameters using the DEC model ([Ree et al. 2015](https://doi.org/10.1111/j.0014-3820.2005.tb00940.x); [Ree & Smith 2018](https://doi.org/10.1080/10635150701883881)) in a maximum-likelihood framework. We will compare this model with another one introducing a new parameter so-called "J" (founder- or jump-dispersal; sensu [Matzke, 2014](http://dx.doi.org/10.1093/sysbio/syu056))

You can use our modified script ([click here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/DECvsDEC_J.R)) based on: http://phylo.wikidot.com/biogeobears#toc29. You can also use our example phylogeny and distribution files ([here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/))

## Counting dispersal events

Biogeographical stochastic mapping is used to simulated histories along the input phylogeny and based on a biogeographical model. The simulated histories are useful for estimating probabilities of events, which has been argued to be a better way to count dispersal ([Dupin et al., 2016](http://dx.doi.org/10.1111/jbi.12898)).

You can use our modified script ([click here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/Stochastic_Mapping_DEC.R)), which relies on the DEC analysis conducted in the previous step.

## Retrieve results and generate plots

You can follow our script ([click here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/Stochastic_Mapping_RetrieveResults.R)) to retrieve the biogeographical stochastic mapping data and generate plots: 1) dispersal counts through time betweeen areas (better for visualization of dispersal curves and speculations/correlations with other environmental drivers), and 2) dispersal events between areas plotted as networks (better for visualization of biogeographical sources/sinks).

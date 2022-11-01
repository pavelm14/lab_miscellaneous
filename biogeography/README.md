# Historical biogeography inference

This is a tutorial to estimate ancestral distributional areas and macroevolutionary dispersal through time between areas.

We use model-based inferences using the R package BioGeoBEARS ([Matzke, 2013](https://doi.org/10.21425/F5FBG19694)). For more information about the functionalities, please visit the program's wiki: http://phylo.wikidot.com/biogeobears. We will also infer biogeographical parameters acknowledging speciation and extinction events in a state speciation and extinction context (LEMAD, [Herrera-Alsina et al, 2022](https://doi.org/10.1111/jbi.14489)). For more information about the functionalities, visit the [LEMAD tutorial](https://htmlpreview.github.io/?https://github.com/leonelhalsina/lemad/blob/main/vignettes/Using_lemad.html).

For people aiming to run the analyses using the Czech computer cluster [Metacentrum](https://metavo.metacentrum.cz/en/index.html), you can follow our tutorial ([click here](https://github.com/pavelm14/lab_miscellaneous/tree/main/Rpackages)) describing the process of installing R packages and running R scripts there.

## Input files

- A time-calibrated molecular phylogeny in Newick format
- A distributional matrix containing the extant areas occupied by each species in the study phylogeny, as presence (1) absence (0) (BioGeoBEARS, [see here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/distribution.phy))
- A distributional matrix containing the extant areas occupied by each species as characters and comma-delimited (LEMAD, [see here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/distribution.csv))

# Running a biogeographical model in BioGeoBEARS

First, install the R package BioGeoBEARS and its dependencies in R (> 3.3.2) following the description at: https://github.com/nmatzke/BioGeoBEARS. You will also need the R packages [ape](https://doi.org/10.1093/bioinformatics/btg412) (handling phylogenies) and [qgraph](https://doi.org/10.18637/jss.v048.i04) (plotting dispersal counts between areas) installed.

Second, we will infer historical biogeography parameters using the DEC model ([Ree et al. 2015](https://doi.org/10.1111/j.0014-3820.2005.tb00940.x); [Ree & Smith 2018](https://doi.org/10.1080/10635150701883881)) in a maximum-likelihood framework. We will compare this model with another one introducing a new parameter so-called "J" (founder- or jump-dispersal; sensu [Matzke, 2014](http://dx.doi.org/10.1093/sysbio/syu056))

You can use our modified script ([click here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/DECvsDEC_J.R)) based on: http://phylo.wikidot.com/biogeobears#toc29. You can also use our example phylogeny and distribution files ([here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/))

## Counting dispersal events

Biogeographical stochastic mapping is used to simulated histories along the input phylogeny and based on a biogeographical model. The simulated histories are useful for estimating probabilities of events, which has been argued to be a better way to count dispersal ([Dupin et al., 2016](http://dx.doi.org/10.1111/jbi.12898)).

You can use our modified script ([click here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/Stochastic_Mapping_DEC.R)), which relies on the DEC analysis conducted in the previous step.

## Retrieve results and generate plots

You can follow our modified script ([click here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/Stochastic_Mapping_RetrieveResults.R)) from [Matos-Maraví et al., 2021](https://doi.org/10.1093/biolinnean/blab034), to retrieve the biogeographical stochastic mapping data and generate plots: 1) dispersal counts through time betweeen areas (better for visualization of dispersal curves and speculations/correlations with other environmental drivers), and 2) dispersal events between areas plotted as networks (better for visualization of biogeographical sources/sinks).

Please, if you follow and are inspired by the plots describing dispersal counts, please, cite our publication:

> Mesoamerica is a cradle and the Atlantic Forest is a museum of Neotropical butterfly diversity: insights from the evolution and biogeography of Brassolini (Lepidoptera: Nymphalidae). Biological Journal of the Linnean Society, Volume 133, Issue 3, July 2021, Pages 704–724, DOI: https://doi.org/10.1093/biolinnean/blab034

# Running a biogeographical analysis in LEMAD

First, install the R package LEMAD and its dependencies in R, including Rtools (> 4.2.1) following the description at: https://github.com/leonelhalsina/lemad. You will also need the R package [DDD](https://doi.org/10.1098%2Frspb.2011.1439) (diversification-rate analyses) installed.

Second, we will infer historical biogeography parameters using the DEC model and a model with parameters that resemble DIVA ([Ronquist 1997](https://doi.org/10.1093/sysbio/46.1.195); [Ree & Smith 2018](https://doi.org/10.1080/10635150701883881)) in a maximum-likelihood framework, and compare them.

You can use our modified script ([click here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/LEMAD_DECvsDIVA.R)) based on the [LEMAD tutorial](https://htmlpreview.github.io/?https://github.com/leonelhalsina/lemad/blob/main/vignettes/Using_lemad.html). You can also use our example phylogeny and distribution files ([here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/))

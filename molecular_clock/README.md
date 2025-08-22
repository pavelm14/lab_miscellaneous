# Divergence time estimation

The following tutorial was inspired by several BEAST2 practical exercises available at the website: https://www.beast2.org/tutorials/.

BEAST2 provides a flexible framework consisting of packages that implement new evolutionary models. These models encompass Bayesian selection of substitution models, multispecies coalescent, total-evidence tip dating, ancestral state reconstruction, relaxed clock models, molecular species delimitation, and epidemiological phylodynamics, among others.

## Installation

BEAST2 comes with a graphical user interface called BEAUti. This software is useful for installing and managing all available BEAST2 packages, and for creating input files in .xml format.

Install the latest version of BEAST2 that is available for your operating system. As of August 2025, version 2.7.8 is available at https://www.beast2.org/. 

We will also use FigTree (https://github.com/rambaut/figtree/releases) to view and manipulate phylogenetic trees.

The latest version of Tracer (https://github.com/beast-dev/tracer/releases) will be used to check posterior parameter estimates and statistics.

### Installation of BEAST2 packages

For this tutorial, we will need:

**bModelTest**: This package performs substitution model averaging, thus reducing computational resources while simultaneously averaging out model uncertainty and the phylogeny inference. The method is described in [Bouckaert & Drummond, 2017](https://doi.org/10.1186/s12862-017-0890-6).

**ORC**: This package implements the Optimised Relaxed Clock model, which performs optimisations of the uncorrelated relaxed clock ([Douglas et al. 2021](https://doi.org/10.1371/journal.pcbi.1008322)). Please, read more about phylogenetic clock models to fully understand different models and the importance of comparing them (e.g., strict vs. relaxed clocks).

To install BEAST2 packages, launch BEAUti and go to the tab *File* -> *Manage Packages*. Once you install or upgrade the BEAST2 packages of interest, restart BEAUti to fully incorporate the package options in the interface.

We use model-based inferences using the R package BioGeoBEARS ([Matzke, 2013](https://doi.org/10.21425/F5FBG19694)). For more information about the functionalities, please visit the program's wiki: http://phylo.wikidot.com/biogeobears. We will also infer biogeographical parameters acknowledging speciation and extinction events in a state speciation and extinction context (LEMAD, [Herrera-Alsina et al, 2022](https://doi.org/10.1111/jbi.14489)). For more information about the functionalities, visit the [LEMAD tutorial](https://htmlpreview.github.io/?https://github.com/leonelhalsina/lemad/blob/main/vignettes/Using_lemad.html).

For people aiming to run the analyses using the Czech computer cluster [Metacentrum](https://metavo.metacentrum.cz/en/index.html), you can follow our tutorial ([click here](https://github.com/pavelm14/lab_miscellaneous/tree/main/Rpackages)) describing the process of installing R packages and running R scripts there.

## Input files

- A time-calibrated molecular phylogeny in Newick format
- A distributional matrix containing the extant areas occupied by each species in the study phylogeny, as presence (1) absence (0) (BioGeoBEARS, [see here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/distribution.phy))
- A distributional matrix containing the extant areas occupied by each species as characters and comma-delimited (LEMAD, [see here](https://github.com/pavelm14/lab_miscellaneous/blob/main/biogeography/tutorial/distribution.csv))

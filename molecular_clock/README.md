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

To install BEAST2 packages, launch BEAUti and go to the tab *File* -> *Manage Packages*. Once you install or upgrade the BEAST2 packages of interest (**bModelTest** and **ORC**), restart BEAUti to fully incorporate the package options in the interface.

![BEAUti Package Manager](https://github.com/pavelm14/lab_miscellaneous/blob/main/molecular_clock/BEAUti_PackageManager.png)

## Input file

- A concatenated alignment of five protein-coding genes in Nexus format. This file includes the best-fit partitioning scheme estimated in the [Phylogeny tutorial](https://github.com/pavelm14/lab_miscellaneous/tree/main/phylogeny) ([haeterini_partitioned.nex](https://github.com/pavelm14/lab_miscellaneous/blob/main/molecular_clock/haeterini_partitioned.nex)).

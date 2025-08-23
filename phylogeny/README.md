# Partitioning sequence alignments

In this tutorial, we will learn how to find the best partitioning scheme for our multilocus sequence alignment.

PartitionFinder ([Lanfear et al. 2012](https://doi.org/10.1093/molbev/mss020); [2017](https://doi.org/10.1093/molbev/msw260)) is an excellent software that handles nucleotide, amino acid and morphology alignments. Here, we will use the model selection approach implemented in IQ-TREE2 (ModelFinder, [Kalyaanamoorthy et al., 2017](https://doi.org/10.1038/nmeth.4285)), which resembles PartitionFinder by considering invariable sites and Gamma rate heterogeneity, and by implementing a greedy search strategy for large datasets.

## Installation

BEAST2 comes with a graphical user interface called BEAUti. This software is useful for installing and managing all available BEAST2 packages, and for creating input files in .xml format.

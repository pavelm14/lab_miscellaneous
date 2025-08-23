# Partitioning sequence alignments

In this tutorial, we will learn how to find the best partitioning scheme for our multilocus sequence alignment.

PartitionFinder ([Lanfear et al. 2012](https://doi.org/10.1093/molbev/mss020); [2017](https://doi.org/10.1093/molbev/msw260)) is an excellent software that handles nucleotide, amino acid and morphology alignments. Here, we will use the model selection approach implemented in IQ-TREE2 (ModelFinder, [Kalyaanamoorthy et al., 2017](https://doi.org/10.1038/nmeth.4285)), which resembles PartitionFinder by considering invariable sites and Gamma rate heterogeneity, and by implementing a greedy search strategy for large datasets.

## Installation

As of August 2025, the latest IQ-TREE release was 2.4.0. You can find them at https://github.com/iqtree/iqtree2/releases.

```bash
##in the MobaXterm terminal, log in to the MetaCentrum
##remember to replace the 'username' with yours!
ssh -x username@tarkil.grid.cesnet.cz

#install iq-tree in your software directory
cd ~/software/
wget https://github.com/iqtree/iqtree2/releases/download/v2.4.0/iqtree-2.4.0-Linux-intel.tar.gz
tar -zxvf iqtree-2.4.0-Linux-intel.tar.gz
rm iqtree-2.4.0-Linux-intel.tar.gz
```

For convenience, I add IQ-TREE's `bin` directory to my $PATH to use the commands directly on the screen.

```bash
cd ~
nano ~/.bashrc

## Add the following text to the last line of .bashrc
export PATH="/storage/praha1/home/pavelmatos/software/iqtree-2.4.0-Linux-intel/bin:$PATH"
## Ctrl+x -> Save Y
```

To use IQ-TREE next time you log in to Metacentrum, do the following:

```bash
source ~/.bashrc
iqtree2 -h
```

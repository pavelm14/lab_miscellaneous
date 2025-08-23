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

## Input files

We will work with species in the butterfly tribe [Haeterini](https://en.wikipedia.org/wiki/Haeterini). The data comes from a phylogenetic and species-delimitation study of this group ([Matos-Maraví et al. 2019](https://doi.org/10.1111/syen.12352))

- A concatenated alignment of five protein-coding genes in Nexus format ([haeterini_concatenated.nex](https://github.com/pavelm14/lab_miscellaneous/blob/main/phylogeny/haeterini_concatenated.nex))
- A subset configuration file describing the positions of protein-coding genes and their codon positions in the concatenated alignment ([haeterini_subsets.nex](https://github.com/pavelm14/lab_miscellaneous/blob/main/phylogeny/haeterini_subsets.nex))

# Running PartitionFinder-like in IQ-TREE

Assuming that your current directory is where your working input files are located

```bash
iqtree2 -s ./haeterini_concatenated.nex -p ./haeterini_subsets.nex -T AUTO -m TESTONLY --merge greedy
```

Let's understand what we have done above:

`-s` calls the alignment file. IQ-TREE supports the following formats: Phylip, Fasta, Nexus, ClustalF, MSF

`-p` calls the partition file. IQ-TREE supports the following formats: Nexus and RAxML. Note that this option assumes the edge-linked proportional partition model (see IQ-TREE's manual for other options; `iqtree2 -h`)

`-T` sets the number of cores/threads the program can use (default: 1; AUTO: will automatically detect)

`-m` calls ModelFinder to perform the standard model selection, like jModelTest, ProtTest, etc (TESTONLY: does model selection only; TEST: model selection followed by tree inference; see the manual for other model selection approaches)

`--merge` calls PartitionFinder-like method to merge partitions and increase model fit

`--merge greedy` sets the merging algorithm to the greedy strategy of PartitonFinder (other options include `rcluster` and `rclusterf` [default]; see PartitionFinder's manual for further explanation)

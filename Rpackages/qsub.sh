#PBS -N biogeography_qsub
#PBS -l select=1:ncpus=2:mem=1gb:scratch_local=2gb
#PBS -l walltime=00:29:00

#clean scratch after the end
trap 'clean_scratch' TERM EXIT

#INPUT directory - with R script and other inputs
MYIN="/storage/praha1/home/pavelmatos/biogeography"
#INPUT R script
MYR="script.r"

# go to scratch directory
cd $SCRATCHDIR || exit 1
# copy all files from $MYIN
cp -a "${MYIN}"/* . || exit 2

module add R-4.0.0-gcc

export R_LIBS="/storage/praha1/home/pavelmatos/software/R/packages"
R -q --vanilla < "${MYR}" > "${MYR}".output

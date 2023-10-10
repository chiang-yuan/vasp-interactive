module purge

module load intelmpi/20.4-intel20.4
module load anaconda3
source activate ms

export NCORES=1

TMP="/jet/home/ychiang4/tmp/"
rm -rf $TMP
mkdir $TMP

ROOT=$TMP VASP_BINARY_PATH="/jet/home/ychiang4/.local/bin/" \
INTERACTIVE_PATCH=patch.py \
IPI_PATCH=patch_ipi.py \
./compile_vasp.sh vasp.6.4.0.tgz makefile makefile.include

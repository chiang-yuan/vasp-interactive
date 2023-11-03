#module purge
#source /opt/cray/pe/cpe/23.03/restore_lmod_system_defaults.sh

module load cray-mpich/8.1.27
module load cray-fftw cray-hdf5 nccl
module load gpu PrgEnv-nvidia nvidia python

module --redirect list > active.txt

export NCORES=1

TMP="/global/homes/c/cyrusyc/.local/tmp/"
rm -rf $TMP
mkdir $TMP

ROOT=$TMP VASP_BINARY_PATH="/global/homes/c/cyrusyc/.local/bin/" \
INTERACTIVE_PATCH=patch.py \
IPI_PATCH=patch_ipi.py \
./compile_vasp.sh vasp.6.3.2.tgz makefile makefile.include

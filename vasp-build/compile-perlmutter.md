
# Compilation note on NERSC Perlmmuter

Compiling on Perlmutter by following the instruction on NERSC documentation might lead to the following error:

```shell
/usr/bin/ld: openacc.o: in function `mopenacc_init_acc_cuda_aware_support':
/global/u2/c/user/.local/tmp/vasp.6.4.0/build/std/openacc.f90:221: undefined reference to `MPIX_Query_cuda_support'
```

`MPIX_Query_cuda_support` provides error message when the user tries to use the OpenACC version without CUDA-aware MPI. VASP developers added this to provide more information when the code crashes. 

To bypass this, follow the discussion in the [VASP forum](https://www.vasp.at/forum/viewtopic.php?t=18833) to remove the related lines in `openacc.F`:

```fortran
! INTERFACE
! INTEGER(c_int) FUNCTION MPIX_Query_cuda_support() BIND(C, name="MPIX_Query_cuda_support")
! END FUNCTION
! END INTERFACE
```

and replace it (at line 194) 

```fortran
CUDA_AWARE_SUPPORT = MPIX_Query_cuda_support() == 1
```

with

```fortran
CUDA_AWARE_SUPPORT = .TRUE.
```



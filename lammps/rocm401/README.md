## README for Creation of LAMMPS HPC-Application Singularity and Docker Container Images from Docker-Tar file

This directory contains the LAMMPS tar.gz file, Singularity Definition file, and this README file

Assuming Docker packages are installed.

## Download and save the LAMMPS Docker image lammps.rocm401.ubuntu18.tar.gz

```
Go to saved location of lammps.rocm401.ubuntu18.tar.gz
$ cd <dir-of-tar-file>
```


### How to Build Docker image from tar.gz file

```
Load docker image
$ sudo docker load -i lammps.rocm401.ubuntu18.tar.gz
Loaded image: amddcgpuce/lammps-rocm401-ubuntu18:version1

Verify loading of LAMMPS Docker
$ sudo docker image ls amddcgpuce/lammps-rocm401-ubuntu18:version1
```


### How to Build Singularity image from the tar.gz file

```
$ sudo /usr/local/bin/singularity build lammps.rocm401.ubuntu18.sif lammps.rocm401.ubuntu18.sdf
```

Please refer to https://github.com/amddcgpuce/rocmcontainers/tree/main/lammps for more information

README for Creation of GROMACS HPC-Application Singularity and Docker Container Images from Docker-Tar file

This directory contains the Gromacs tar.gz file, Singularity Definition file, and this README file

Assuming Docker packages are installed.

Download and save the Gromacs Docker image gromacs.rocm401.ubuntu18.tar.gz

Go to saved location of gromacs.rocm401.ubuntu18.tar.gz
$ cd <dir-of-tar-file>


Section A: How to Build Singularity image from the tar.gz file

$ sudo /usr/local/bin/singularity build gromacs.rocm401.ubuntu18.sif gromacs.rocm401.ubuntu18.sdf

Please refer to https://github.com/amddcgpuce/rocmcontainers/tree/main/gromacs for more information


Section B: How to Build Docker image from tar.gz file

Load docker image
$ sudo docker load -i gromacs.rocm401.ubuntu18.tar.gz
Loaded image: amddcgpuce/gromacs-rocm401-ubuntu18:version1

Verify loading of Gromacs Docker
$ sudo docker image ls amddcgpuce/gromacs-rocm401-ubuntu18:version1


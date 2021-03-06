## README for Creation of OPENMM HPC-Application Singularity and Docker Container Images from Docker-Tar file

This directory contains the OPENMM tar.gz file, Singularity Definition file, and this README file.

Assuming Docker packages are installed.

## Download the OPENMM Docker image (.tar.gz) and Singularity Defition File (.sdf)

```
Go to saved location of Docker image file openmm.rocm401.ubuntu18.tar.gz
    cd <dir-of-tar-file>
```

### How to Build Docker image from tar.gz file

```
Load docker image
    sudo docker load -i openmm.rocm401.ubuntu18.tar.gz
    Loaded image: amddcgpuce/openmm-rocm401-ubuntu18:version1

Verify loading of OPENMM Docker
    sudo docker image ls amddcgpuce/openmm-rocm401-ubuntu18:version1
```


### How to Build Singularity image from the tar.gz file

```
    sudo /usr/local/bin/singularity build openmm.rocm401.ubuntu18.sif openmm.rocm401.ubuntu18.sdf

```
Please refer to https://github.com/amddcgpuce/rocmcontainers/tree/main/openmm for more information

## README for Creation of NAMD HPC-Application Singularity and Docker Container Images from Docker-Tar file

This directory contains the NAMD tar.gz file, Singularity Definition file, and this README file.

Assuming Docker packages are installed.

## Download the NAMD Docker image (.tar.gz) & Singularity Definition File (.sdf)

```
Go to saved location of docker image namd.rocm401.ubuntu18.tar.gz
    cd <dir-of-tar-file>
```


### How to Build Docker image from tar.gz file

```
Load NAMD Docker image
    sudo docker load -i namd.rocm401.ubuntu18.tar.gz
    Loaded image: amddcgpuce/namd-rocm401-ubuntu18:version1

Verify loading of NAMD Docker image
    sudo docker image ls amddcgpuce/namd-rocm401-ubuntu18:version1
```


### How to Build Singularity container image from the tar.gz file using sdf file

```
    sudo /usr/local/bin/singularity build namd.rocm401.ubuntu18.sif namd.rocm401.ubuntu18.sdf
```

Please refer to https://github.com/amddcgpuce/rocmcontainers/tree/main/namd for more information


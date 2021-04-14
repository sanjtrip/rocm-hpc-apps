# ROCm-4.0.1-based Pytorch Container

## 1.0 How to Use Docker Container

#### On Ubuntu 18/20 HWE, CentOS/RHEL 7.x, or SLES 15 SP2, use docker:
```
# Launch container in interactive mode, bash shell
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined sanjtrip/pytorch-rocm401-ubuntu18:version1 bash
```
#### On CentOS/RHEL 8.x, use podman:
```
# Launch container in interactive mode, bash shell
sudo podman run -it --privileged docker://sanjtrip/pytorch-rocm401-ubuntu18:version1 bash
```

## 2.0 Steps to build Singularity container from docker image
#### Download Singularity Definition File
```
# Download Singularity Definition file
wget -O pytorch.rocm401.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/sanjtrip/rocm-hpc-apps/master/pytorch/rocm401/ubuntu18/pytorch.rocm401.ubuntu18.sdf
```
#### Build Singularity Image File (SIF)
##### On Ubuntu 18.04/20.04 HWE with singularity installed under /usr/local/bin
```
sudo /usr/local/bin/singularity build pytorch.rocm401.ubuntu18.sif pytorch.rocm401.ubuntu18.sdf
```
##### On CentOS/RHEL 8 with singularity RPM installed
```
sudo singularity build pytorch.rocm401.ubuntu18.sif pytorch.rocm401.ubuntu18.sdf
```

## 3.0 Example Usage of Pytorch Singularity Container
### Run Help
```
singularity run-help pytorch.rocm401.ubuntu18.sif
```
##### Output
```
```

### Copy Pytorch benchmark samples from container to $HOME/Documents on host
```
```
##### Output
```
```

### Running sample benchmark after above copy
```
```
##### Output
```
```

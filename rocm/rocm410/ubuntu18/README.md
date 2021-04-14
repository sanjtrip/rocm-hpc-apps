# ROCm-4.1.0 Container

## 1.0 How to Use Docker Container

#### On Ubuntu 18/20 HWE, CentOS/RHEL 7.x, or SLES 15 SP2, use docker:
```
# Launch container in interactive mode, bash shell
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined sanjtrip/private-rocm410-ubuntu18:version1 bash
```
#### On CentOS/RHEL 8.x, use podman:
```
# Launch container in interactive mode, bash shell
sudo podman run -it --privileged docker://sanjtrip/private-rocm410-ubuntu18:version1 bash
```

## 2.0 Steps to build Singularity container from docker image
#### Download Singularity Definition File
```
# Download Singularity Definition file
wget -O rocm410.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/sanjtrip/rocm-hpc-apps/master/rocm/rocm410/ubuntu18/rocm410.ubuntu18.sdf
```
#### Build Singularity Image File (SIF)
##### On Ubuntu 18.04/20.04 HWE with singularity installed under /usr/local/bin
```
sudo /usr/local/bin/singularity build rocm410.ubuntu18.sif rocm410.ubuntu18.sdf
```
##### On CentOS/RHEL 8 with singularity RPM installed
```
sudo singularity build rocm410.ubuntu18.sif rocm410.ubuntu18.sdf
```

## 3.0 Example Usage of ROCm Singularity Container
### Run Help
```
singularity run-help rocm410.ubuntu18.sif
```
##### Output
```
    singularity run rocm410.ubuntu18.sif /bin/bash -c "cp -r /opt/rocm-4.1.0/hip/samples/ $HOME/Documents/"
    singularity run rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/samples/0_Intro/bit_extract; make HIP_PATH=/opt/rocm-4.1.0/hip; ./bit_extract"
```

### Copy ROCm benchmark samples from container to $HOME/Documents on host
```
singularity run rocm410.ubuntu18.sif /bin/bash -c "cp -r /opt/rocm-4.1.0/hip/samples/ $HOME/Documents/"
```
##### Output
```
Container was created Tue Apr 13 17:29:01 UTC 2021
CWD: /home/USERHOME Launching: /bin/bash -c cp -r /opt/rocm-4.1.0/hip/samples/ /home/USERHOME/Documents/
```

### Running sample benchmark after above copy
```
singularity run rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/samples/0_Intro/bit_extract; make HIP_PATH=/opt/rocm-4.1.0/hip; ./bit_extract"
```
##### Output
```
Container was created Tue Apr 13 17:29:01 UTC 2021
CWD: /home/USERHOME Launching: /bin/bash -c cd /home/USERHOME/Documents/samples/0_Intro/bit_extract; make HIP_PATH=/opt/rocm-4.1.0/hip; ./bit_extract
/opt/rocm-4.1.0/hip/bin/hipcc  bit_extract.cpp -o bit_extract
--------------------------------------------------------------------------
...output snipped...
```

## 4.0 Incompatible ROCm Environment Check Message (NEW)
### ROCm 4.1 Kernel Modules (rock-dkms, rock-dkms-firmware) or newer is required on MI50/MI60 platforms to run ROCm 4.1 or newer user space stack 


#### Docker Run Failure Message On Incompatible ROCm Environment
```
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd  --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined sanjtrip/private-rocm410-ubuntu18:version1 bash
```
###### Output
```
Error: Incompatible ROCm environment. The Docker container
requires the latest kernel driver to operate correctly.

Upgrade the ROCm kernel to v4.1 or newer, or use a container
tagged for v4.0.1 or older.

To inspect the version of the installed kernel driver, run either:
    . dpkg --status rock-dkms [Debian-based]
    . rpm -ql rock-dkms [RHEL, SUSE, and others]

To install or update the driver, follow the installation instructions at:
    https://rocmdocs.amd.com/en/latest/Installation_Guide/Installation-Guide.html

```


#### Singularity Run Failure Message On Incompatible ROCm Environment
```
singularity run rocm410.ubuntu18.sif /bin/bash -c "cp -r /opt/rocm-4.1.0/hip/samples/ $HOME/Documents/"
```
###### Output
```
Container was created Tue Apr 13 19:18:40 UTC 2021

Error: Incompatible ROCm environment. The Docker container
requires the latest kernel driver to operate correctly.

Upgrade the ROCm kernel to v4.1 or newer, or use a container
tagged for v4.0.1 or older.

To inspect the version of the installed kernel driver, run either:
    . dpkg --status rock-dkms [Debian-based]
    . rpm -ql rock-dkms [RHEL, SUSE, and others]

To install or update the driver, follow the installation instructions at:
    https://rocmdocs.amd.com/en/latest/Installation_Guide/Installation-Guide.html
```

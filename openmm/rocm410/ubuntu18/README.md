# ROCm-4.1.0-based HPC Application OPENMM Container

## 1.0 How to Use Docker Container

#### On Ubuntu 18/20 HWE, CentOS/RHEL 7.x, or SLES 15 SP2, use docker:
```
# Launch container in interactive mode, bash shell
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined sanjtrip/private-openmm-rocm410-ubuntu18:version1 bash
```
#### On CentOS/RHEL 8.x, use podman:
```
# Launch container in interactive mode, bash shell
sudo podman run -it --privileged docker://sanjtrip/private-openmm-rocm410-ubuntu18:version1 bash
```

## 2.0 Steps to build Singularity container from docker image
#### Download Singularity Definition File
```
# Download Singularity Definition file
wget -O openmm.rocm410.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/sanjtrip/rocm-hpc-apps/master/openmm/rocm410/ubuntu18/openmm.rocm410.ubuntu18.sdf
```
#### Build Singularity Image File (SIF)
##### On Ubuntu 18.04/20.04 HWE with singularity installed under /usr/local/bin
```
sudo /usr/local/bin/singularity build openmm.rocm410.ubuntu18.sif openmm.rocm410.ubuntu18.sdf
```
##### On CentOS/RHEL 8 with singularity RPM installed
```
sudo singularity build openmm.rocm410.ubuntu18.sif openmm.rocm410.ubuntu18.sdf
```

## 3.0 Example Usage of OPENMM Singularity Container
### Run Help
```
singularity run-help openmm.rocm410.ubuntu18.sif
```
##### Output
```
    singularity run openmm.rocm410.ubuntu18.sif $HOME/Documents/openmm-test/openmmtest.py
    singularity run openmm.rocm410.ubuntu18.sif ./TestHipBrownianIntegrator
```

### Copy OPENMM benchmark samples from container to $HOME/Documents on host
```
singularity run openmm.rocm410.ubuntu18.sif $HOME/Documents/openmm-test/openmmtest.py
```
##### Output
```
Container was created Wed Apr 14 17:49:13 UTC 2021
CWD: /opt/openmm/build Launching: /home/USERHOME/Documents/openmm-test/openmmtest.py
7.5
```

### Running sample benchmark after above copy
```
singularity run openmm.rocm410.ubuntu18.sif ./TestHipBrownianIntegrator
```
##### Output
```
Container was created Wed Apr 14 17:49:13 UTC 2021
CWD: /opt/openmm/build Launching: ./TestHipBrownianIntegrator
Done
```

## 4.0 Incompatible ROCm Environment Check Message (NEW)
### ROCm 4.1 Kernel Modules (rock-dkms, rock-dkms-firmware) or newer is required on MI50/MI60 platforms to run ROCm 4.1 or newer user space stack 


#### Docker Run Failure Message On Incompatible ROCm Environment
```
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd --group-add video --cap-add=SYS_PTRACE --security-opt  seccomp=unconfined sanjtrip/private-openmm-rocm410-ubuntu18:version1 bash
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
singularity run openmm.rocm410.ubuntu18.sif $HOME/Documents/openmm-test/openmmtest.py
```
###### Output
```
Container was created Wed Apr 14 18:08:28 UTC 2021

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

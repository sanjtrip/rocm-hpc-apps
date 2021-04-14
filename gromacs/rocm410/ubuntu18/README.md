# ROCm-4.1.0-based HPC Application GROMACS Container

## 1.0 How to Use Docker Container

#### On Ubuntu 18/20 HWE, CentOS/RHEL 7.x, or SLES 15 SP2, use docker:
```
# Launch container in interactive mode, bash shell
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined sanjtrip/private-gromacs-rocm410-ubuntu18:version1 bash
```
#### On CentOS/RHEL 8.x, use podman:
```
# Launch container in interactive mode, bash shell
sudo podman run -it --privileged docker://sanjtrip/private-gromacs-rocm410-ubuntu18:version1 bash
```

## 2.0 Steps to build Singularity container from docker image
#### Download Singularity Definition File
```
# Download Singularity Definition file
wget -O gromacs.rocm410.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/sanjtrip/rocm-hpc-apps/master/gromacs/rocm410/ubuntu18/gromacs.rocm410.ubuntu18.sdf
```
#### Build Singularity Image File (SIF)
##### On Ubuntu 18.04/20.04 HWE with singularity installed under /usr/local/bin
```
sudo /usr/local/bin/singularity build gromacs.rocm410.ubuntu18.sif gromacs.rocm410.ubuntu18.sdf
```
##### On CentOS/RHEL 8 with singularity RPM installed
```
sudo singularity build gromacs.rocm410.ubuntu18.sif gromacs.rocm410.ubuntu18.sdf
```

## 3.0 Example Usage of GROMACS Singularity Container
### Run Help
```
singularity run-help gromacs.rocm410.ubuntu18.sif
```
##### Output
```
    singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cp -r benchmark $HOME/Documents/"
    singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark/adh_dodec; /usr/local/gromacs/bin/gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20"
    singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark; ./run.sh"
```

### Copy GROMACS benchmark samples from container to $HOME/Documents on host
```
singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cp -r benchmark $HOME/Documents/"
```
##### Output
```
Container was created Sat Apr 10 05:45:18 UTC 2021
CWD: /opt/gromacs Launching: /bin/bash -c cp -r benchmark /home/USERHOME/Documents/
```

### Running sample benchmark after above copy
```
singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark/adh_dodec; /usr/local/gromacs/bin/gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20"
```
##### Output
```
Container was created Sat Apr 10 05:45:18 UTC 2021
CWD: /opt/gromacs Launching: /bin/bash -c cd /home/USERHOME/Documents/benchmark/adh_dodec; /usr/local/gromacs/bin/gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20
--------------------------------------------------------------------------
...output snipped...
```

### Running run.sh benchmark script after above copy
```
singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark; ./run.sh"
```
##### Output
```
Container was created Sat Apr 10 05:45:18 UTC 2021
CWD: /opt/gromacs Launching: /bin/bash -c cd /home/sanjay/Documents/benchmark; ./run.sh
--------------------------------------------------------------------------
...output snipped...
```

## 4.0 Incompatible ROCm Environment Check Message (NEW)
### ROCm 4.1 Kernel Modules (rock-dkms, rock-dkms-firmware) or newer is required on MI50/MI60 platforms to run ROCm 4.1 or newer user space stack 


#### Docker Run Failure Message On Incompatible ROCm Environment
```
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined sanjtrip/private-gromacs-rocm410-ubuntu18:version1 bash
```
###### Output
```
Error: Incompatible ROCm environment. The Docker container
requires the latest kernel driver to operate correctly.

Upgrade the ROCm kernel to v4.1 or newer, or use a container
tagged for v4.0.1 or older.

To inspect the version of the installed kernel driver, run either:
      dpkg --status rock-dkms [Debian-based]
      rpm -ql rock-dkms [RHEL, SUSE, and others]

To install or update the driver, follow the installation instructions at:
    https://rocmdocs.amd.com/en/latest/Installation_Guide/Installation-Guide.html
```


#### Singularity Run Failure Message On Incompatible ROCm Environment
```
singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cp -r benchmark $HOME/Documents/"
```
###### Output
```
Container was created Tue Apr 13 03:08:36 UTC 2021

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

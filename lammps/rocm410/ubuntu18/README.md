# ROCm-4.1.0-based HPC Application LAMMPS Container -- WORK_IN_PROGRESS

## 1.0 How to Use Docker Container

#### On Ubuntu 18/20 HWE, CentOS/RHEL 7.x, or SLES 15 SP2, use docker:
```
# Launch container in interactive mode, bash shell
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined sanjtrip/private-lammps-rocm410-ubuntu18:version1 bash
```
#### On CentOS/RHEL 8.x, use podman:
```
# Launch container in interactive mode, bash shell
sudo podman run -it --privileged docker://sanjtrip/private-lammps-rocm410-ubuntu18:version1 bash
```

## 2.0 Steps to build Singularity container from docker image
#### Download Singularity Definition File
```
# Download Singularity Definition file
wget -O lammps.rocm410.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/sanjtrip/rocm-hpc-apps/master/lammps/rocm410/ubuntu18/lammps.rocm410.ubuntu18.sdf
```
#### Build Singularity Image File (SIF)
##### On Ubuntu 18.04/20.04 HWE with singularity installed under /usr/local/bin
```
sudo /usr/local/bin/singularity build lammps.rocm410.ubuntu18.sif lammps.rocm410.ubuntu18.sdf
```
##### On CentOS/RHEL 8 with singularity RPM installed
```
sudo singularity build lammps.rocm410.ubuntu18.sif lammps.rocm410.ubuntu18.sdf
```

## 3.0 Example Usage of LAMMPS Singularity Container
### Run Help
```
singularity run-help lammps.rocm410.ubuntu18.sif
```
##### Output
```
    singularity run lammps.rocm410.ubuntu18.sif /bin/bash -c "cd /opt/lammps_install/lammps; cp -r examples/melt $HOME/Documents/"
    singularity run lammps.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/melt; LD_LIBRARY_PATH=/opt/ompi/lib /opt/ompi/bin/mpirun -np 1 lmp  -in in.melt -sf gpu -pk gpu 1"
```

### Copy LAMMPS benchmark samples from container to $HOME/Documents on host
```
singularity run lammps.rocm410.ubuntu18.sif /bin/bash -c "cd /opt/lammps_install/lammps; cp -r examples/melt $HOME/Documents/"
```
##### Output
```
```

### Running sample benchmark after above copy
```
singularity run lammps.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/melt; LD_LIBRARY_PATH=/opt/ompi/lib /opt/ompi/bin/mpirun -np 1 lmp  -in in.melt -sf gpu -pk gpu 1"
```
##### Output
```
--------------------------------------------------------------------------
WARNING: There is at least non-excluded one OpenFabrics device found,
but there are no active ports detected (or Open MPI was unable to use
them).  This is most certainly not what you wanted.  Check your
cables, subnet manager configuration, etc.  The openib BTL will be
ignored for this job.

  Local host: gb-hq-23
--------------------------------------------------------------------------
  [1618902436.177380] [gb-hq-23:28   :0]         parser.c:1600 UCX  WARN  unused env variable: UCX_HOME (set UCX_WARN_UNUSED_ENV_VARS=n to suppress this warning)
LAMMPS (29 Oct 2020)
Lattice spacing in x,y,z = 1.6795962 1.6795962 1.6795962
Created orthogonal box = (0.0000000 0.0000000 0.0000000) to (16.795962 16.795962 16.795962)
  1 by 1 by 1 MPI processor grid
Created 4000 atoms
  create_atoms CPU = 0.000 seconds
...output snipped...
```

## 4.0 Incompatible ROCm Environment Check Message (NEW)
### ROCm 4.1 Kernel Modules (rock-dkms, rock-dkms-firmware) or newer is required on MI50/MI60 platforms to run ROCm 4.1 or newer user space stack 


#### Docker Run Failure Message On Incompatible ROCm Environment
```
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd --group-add video --cap-add=SYS_PTRACE --security-opt  seccomp=unconfined sanjtrip/private-lammps-rocm410-ubuntu18:version1 bash
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
singularity run lammps.rocm410.ubuntu18.sif /bin/bash -c "cd /opt/lammps_install/lammps; cp -r examples/melt $HOME/Documents/"
```
###### Output
```
Container was created Tue Apr 20 07:56:12 UTC 2021

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

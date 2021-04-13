# ROCm-4.1.0-based HPC Application NAMD Container

## 1.0 How to Use Docker Container

#### On Ubuntu 18/20 HWE, CentOS/RHEL 7.x, or SLES 15 SP2, use docker:
```
# Launch container in interactive mode, bash shell
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd \
	--device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt \
	seccomp=unconfined sanjtrip/private-namd-rocm410-ubuntu18:version1 bash
```
#### On CentOS/RHEL 8.x, use podman:
```
# Launch container in interactive mode, bash shell
sudo podman run -it --privileged docker://sanjtrip/private-namd-rocm410-ubuntu18:version1 bash
```

## 2.0 Steps to build Singularity container from docker image
#### Download Singularity Definition File
```
# Download Singularity Definition file
wget -O namd.rocm410.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/sanjtrip/rocm-hpc-apps/master/namd/rocm410/ubuntu18/namd.rocm410.ubuntu18.sdf
```
#### Build Singularity Image File (SIF)
##### On Ubuntu 18.04/20.04 HWE with singularity installed under /usr/local/bin
```
sudo /usr/local/bin/singularity build namd.rocm410.ubuntu18.sif namd.rocm410.ubuntu18.sdf
```
##### On CentOS/RHEL 8 with singularity RPM installed
```
sudo singularity build namd.rocm410.ubuntu18.sif namd.rocm410.ubuntu18.sdf
```

## 3.0 Example Usage of NAMD Singularity Container
### Run Help
```
singularity run-help namd.rocm410.ubuntu18.sif
```
##### Output
```
    singularity run namd.rocm410.ubuntu18.sif /bin/bash -c "cp -r benchmark $HOME/Documents/"
    singularity run namd.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark/adh_dodec; /usr/local/namd/bin/gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20"
    singularity run namd.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark; ./run.sh"
```

### Copy NAMD benchmark samples from container to $HOME/Documents on host
```
singularity run namd.rocm410.ubuntu18.sif /bin/bash -c "cp -r benchmark $HOME/Documents/"
```
##### Output
```
Container was created Sat Apr 10 05:45:18 UTC 2021
CWD: /opt/namd Launching: /bin/bash -c cp -r benchmark /home/USERHOME/Documents/
```

### Running sample benchmark after above copy
```
    singularity run namd.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark/adh_dodec; /usr/local/namd/bin/gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20"
```
##### Output
```
--------------------------------------------------------------------------
...output snipped...
```

### Running run.sh benchmark script after above copy
```
singularity run namd.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark; ./run.sh"
```
##### Output
```
Container was created Sat Apr 10 05:45:18 UTC 2021
CWD: /opt/namd Launching: /bin/bash -c cd /home/sanjay/Documents/benchmark; ./run.sh
--------------------------------------------------------------------------
...output snipped...
```

## 4.0 Incompatible ROCm Environment Check Message (NEW)
### ROCm 4.1 Kernel Modules (rock-dkms, rock-dkms-firmware) or newer is required on MI50/MI60 platforms to run ROCm 4.1 or newer user space stack 


#### Docker Run Failure Message On Incompatible ROCm Environment
```
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined sanjtrip/private-namd-rocm410-ubuntu18:version1 bash
```
###### Output
```
```


#### Singularity Run Failure Message On Incompatible ROCm Environment
```
singularity run namd.rocm410.ubuntu18.sif /bin/bash -c "cp -r benchmark $HOME/Documents/"
```
###### Output
```
```

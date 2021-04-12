## README for Loading and Testing of ROM4.1 Based GROMACS HPC-Application Docker

Assuming Docker packages are installed.

### Load/Run Gromacs Docker container

```
# Download the Gromacs Docker for Ubuntu18 from :
	https://hub.docker.com/r/sanjtrip/private-gromacs-rocm410-ubuntu18

# Run the Gromacs Docker container 
$ sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd \
	--device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt \
	seccomp=unconfined sanjtrip/private-gromacs-rocm410-ubuntu18:version1 bash

```

### Test Gromacs Docker container

```
# source /usr/local/gromacs/bin/GMXRC
# cd /opt/gromacs/benchmark/adh_dodec
# gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20
---- output snipped ------
# cd /opt/gromacs/benchmark/
# ./run.sh
---- output snipped ------
```

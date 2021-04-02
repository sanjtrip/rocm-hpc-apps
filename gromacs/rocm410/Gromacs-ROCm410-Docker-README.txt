README for Loading and Testing of ROM4.1 GROMACS HPC-Application Docker

Assuming Docker packages are installed.

===================================================================================

Section A: How to Load Gromacs docker container

Download the Gromacs Docker from :
	https://hub.docker.com/r/sanjtrip/gromacs-rocm410-ubuntu18 

$ sudo docker pull sanjtrip/gromacs-rocm410-ubuntu18:version1

Run the Gromacs docker container 
$ sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd \
	--device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt \
	seccomp=unconfined sanjtrip/gromacs-rocm410-ubuntu18:version1 bash

Verify loading of Gromacs Docker
$ sudo docker image ls sanjtrip/gromacs-rocm410-ubuntu18:version1


Section B: How to test Gromacs docker container

# source /usr/local/gromacs/bin/GMXRC
# cd /opt/gromacs/benchmark/adh_dodec
# gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20
# cd /opt/gromacs/benchmark/
# ./run.sh

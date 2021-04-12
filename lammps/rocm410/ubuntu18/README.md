# ROCm-based LAMMPS Singularity Container Example With ROCm 4.1.0

### Building LAMMPS singularity container from amddcgpuce docker image

```
# Download LAMMPS Singularity Definition file
wget -O lammps.rocm410.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/amddcgpuce/rocmcontainers/main/lammps/lammps.rocm410.ubuntu18.sdf

# Build Singularity image, bootstrap from amddcgpuce docker image
# (replace path to Singularity installation as appropriate)
sudo /usr/local/bin/singularity build lammps.rocm410.ubuntu18.sif lammps.rocm410.ubuntu18.sdf
```

## ROCm-based LAMMPS Singularity Container Examples
### Run Help

```
singularity run-help lammps.rocm410.ubuntu18.sif
    singularity run lammps.rocm410.ubuntu18.sif /bin/bash -c "cd /opt/lammps_install/lammps; cp -r examples/melt $HOME/Documents/"
    singularity run lammps.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/melt; LD_LIBRARY_PATH=/opt/ompi/lib /opt/ompi/bin/mpirun -np 1 lmp  -in in.melt -sf gpu -pk gpu 1"
```

### Copy LAMMPS benchmark samples to $HOME/Documents

```
singularity run lammps.rocm410.ubuntu18.sif /bin/bash -c "cd /opt/lammps_install/lammps; cp -r examples/melt $HOME/Documents/"
Container was created Mon Apr 12 07:00:22 UTC 2021
CWD: /opt/lammps_install/lammps Launching: /bin/bash -c cd /opt/lammps_install/lammps; cp -r examples/melt /home/sanjay/Documents/
```

### Running sample benchmark after above copy

```
singularity run lammps.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/melt; LD_LIBRARY_PATH=/opt/ompi/lib /opt/ompi/bin/mpirun -np 1 lmp  -in in.melt -sf gpu -pk gpu 1"
Container was created Mon Apr 12 07:00:22 UTC 2021
CWD: /opt/lammps_install/lammps Launching: /bin/bash -c cd /home/sanjay/Documents/melt; LD_LIBRARY_PATH=/opt/ompi/lib /opt/ompi/bin/mpirun -np 1 lmp  -in in.melt -sf gpu -pk gpu 1

--------------------------------------------------------------------------
....output snipped...
```

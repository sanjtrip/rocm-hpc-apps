# ROCm-based GROMACS Singularity Container Example With ROCm 4.1.0

### Building GROMACS singularity container from amddcgpuce docker image

```
# Download GROMACS Singularity Definition file
wget -O gromacs.rocm410.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/amddcgpuce/rocmcontainers/main/gromacs/gromacs.rocm410.ubuntu18.sdf

# Build Singularity image, bootstrap from amddcgpuce docker image
# (replace path to Singularity installation as appropriate)
sudo /usr/local/bin/singularity build gromacs.rocm410.ubuntu18.sif gromacs.rocm410.ubuntu18.sdf
```

## ROCm-based GROMACS Singularity Container Examples
### Run Help

```
singularity run-help gromacs.rocm410.ubuntu18.sif
    singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cp -r benchmark $HOME/Documents/"
    singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark/adh_dodec; /usr/local/gromacs/bin/gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20"
    singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark; ./run.sh"
```

### Copy GROMACS benchmark samples to $HOME/Documents

```
singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cp -r benchmark $HOME/Documents/"
Container was created Sat Apr 10 05:45:18 UTC 2021
CWD: /opt/gromacs Launching: /bin/bash -c cp -r benchmark /home/sanjay/Documents/
```

### Running sample benchmark after above copy

```
singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark/adh_dodec; /usr/local/gromacs/bin/gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20"
Container was created Sat Apr 10 05:45:18 UTC 2021
CWD: /opt/gromacs Launching: /bin/bash -c cd /home/sanjay/Documents/benchmark/adh_dodec; /usr/local/gromacs/bin/gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20
--------------------------------------------------------------------------
....output snipped...
```

### Running run.sh benchmark script after above copy

```
singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark; ./run.sh"
Container was created Sat Apr 10 05:45:18 UTC 2021
CWD: /opt/gromacs Launching: /bin/bash -c cd /home/sanjay/Documents/benchmark; ./run.sh
--------------------------------------------------------------------------
 ....output snipped...

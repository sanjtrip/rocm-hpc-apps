# ROCm-based GROMACS Singularity Container Example With ROCm 4.1.0

### Building GROMACS singularity container from sanjtrip docker image
```

# Download GROMACS singularity definition file, bootstrap docker
wget -O gromacs.rocm410.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/sanjtrip/rocm-hpc-apps/master/gromacs/rocm410/ubuntu18/gromacs.rocm410.ubuntu18.sdf

# Build singularity image, bootstrap from sanjtrip docker image
# (replace path to singularity installation as appropriate)
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

    Container was created Wed Feb 24 05:21:54 UTC 2021
    CWD: /opt/gromacs Launching: /bin/bash -c cp -r benchmark /home/USERHOME/Documents/

```

### Running sample benchmark after above copy
```
    singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark/adh_dodec; /usr/local/gromacs/bin/gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20"

    Container was created Wed Feb 24 05:21:54 UTC 2021
    CWD: /opt/gromacs Launching: /bin/bash -c cd /home/master/Documents/benchmark/adh_dodec; /usr/local/gromacs/bin/gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -maxwarn 20
....output snipped...

```

### Running run.sh benchmark script after above copy
```
singularity run gromacs.rocm410.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/benchmark; ./run.sh"

     Container was created D Feb 5 05:21:54 UTC 2021
     CWD: /opt/gromacs Launching: /bin/bash -c cd /home/master/Documents/benchmark; ./run.sh
     --------------------------------------------------------------------------

 ....output snipped...

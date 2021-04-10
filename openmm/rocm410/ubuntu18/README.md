# ROCm-based OpenMM Singularity Container Example With ROCm 4.1.0

### Building OpenMM singularity container from amddcgpuce docker image

```
# Download OpenMM Singularity Definition file
wget -O openmm.rocm410.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/amddcgpuce/rocmcontainers/main/openmm/openmm.rocm410.ubuntu18.sdf

# Build Singularity image, bootstrap from amddcgpuce docker image
# (replace path to Singularity installation as appropriate)
sudo /usr/local/bin/singularity build openmm.rocm410.ubuntu18.sif openmm.rocm410.ubuntu18.sdf
```

## ROCm-based OpenMM Singularity Container Examples
### Run Help

```
singularity run-help openmm.rocm410.ubuntu18.sif
    singularity run openmm.rocm410.ubuntu18.sif $HOME/Documents/openmm-test/openmmtest.py
    singularity run openmm.rocm410.ubuntu18.sif ./TestHipBrownianIntegrator
```

### Copy OpenMM benchmark samples to $HOME/Documents

```
singularity run openmm.rocm410.ubuntu18.sif $HOME/Documents/openmm-test/openmmtest.py
Container was created Sat Apr 10 05:40:56 UTC 2021
CWD: /opt/openmm/build Launching: /home/sanjay/Documents/openmm-test/openmmtest.py
....output snipped...
```

### Running sample benchmark after above copy

```
singularity run openmm.rocm410.ubuntu18.sif ./TestHipBrownianIntegrator
Container was created Sat Apr 10 05:40:56 UTC 2021
CWD: /opt/openmm/build Launching: ./TestHipBrownianIntegrator
....output snipped...
```

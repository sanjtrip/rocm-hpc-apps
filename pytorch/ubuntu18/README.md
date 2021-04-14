# ROCm-based Pytorch Singularity Container Example With ROCm 4.0.1

### Building Pytorch singularity container from amddcgpuce docker image

```
# Download Pytorch Singularity Definition file
wget -O pytorch.rocm401.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/amddcgpuce/rocmcontainers/main/pytorch/pytorch.rocm401.ubuntu18.sdf

# Build Singularity image, bootstrap from amddcgpuce docker image
# (replace path to Singularity installation as appropriate)
sudo /usr/local/bin/singularity build pytorch.rocm401.ubuntu18.sif pytorch.rocm401.ubuntu18.sdf
```

## ROCm-based Pytorch Singularity Container Examples
### Run Help

```
singularity run-help pytorch.rocm401.ubuntu18.sif
```

### Copy Pytorch benchmark samples to $HOME/Documents

```
```

### Running sample benchmark after above copy

```
```

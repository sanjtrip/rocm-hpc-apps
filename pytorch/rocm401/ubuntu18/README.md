# ROCm-4.0.1-based Pytorch-1.7.1 Container

## 1.0 How to Use Docker Container

#### On Ubuntu 18/20 HWE, CentOS/RHEL 7.x, or SLES 15 SP2, use docker:
```
# Launch container in interactive mode, bash shell
sudo docker run -it --privileged --ipc=host --network=host --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined sanjtrip/pytorch171-rocm401-ubuntu18:version1 bash
```
#### On CentOS/RHEL 8.x, use podman:
```
# Launch container in interactive mode, bash shell
sudo podman run -it --privileged docker://sanjtrip/pytorch171-rocm401-ubuntu18:version1 bash
```

## 2.0 Steps to build Singularity container from docker image
#### Download Singularity Definition File
```
# Download Singularity Definition file
wget -O pytorch171.rocm401.ubuntu18.sdf --no-check-certificate https://raw.githubusercontent.com/sanjtrip/rocm-hpc-apps/master/pytorch/rocm401/ubuntu18/pytorch171.rocm401.ubuntu18.sdf
```
#### Build Singularity Image File (SIF)
##### On Ubuntu 18.04/20.04 HWE with singularity installed under /usr/local/bin
```
sudo /usr/local/bin/singularity build pytorch171.rocm401.ubuntu18.sif pytorch171.rocm401.ubuntu18.sdf
```
##### On CentOS/RHEL 8 with singularity RPM installed
```
sudo singularity build pytorch171.rocm401.ubuntu18.sif pytorch171.rocm401.ubuntu18.sdf
```

## 3.0 Example Usage of Pytorch Singularity Container
### Run Help
```
singularity run-help pytorch171.rocm401.ubuntu18.sif
```
##### Output
```
    singularity run pytorch171.rocm401.ubuntu18.sif /bin/bash -c "cd /opt/pytorch-micro-benchmarking; cp -r . $HOME/Documents/pytorch-micro-benchmarking; cd /opt/pytorch/; cp -r caffe2 $HOME/Documents/pytorch/; cd /opt/pytorch/; cp -r benchmarks $HOME/Documents/pytorch/"
   singularity run pytorch171.rocm401.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/pytorch-micro-benchmarking; LD_LIBRARY_PATH=/opt/rocm/lib python3 micro_benchmarking_pytorch.py --network resnext101  --batch-size 128  --iterations 100" 
   singularity run pytorch171.rocm401.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/pytorch; LD_LIBRARY_PATH=/opt/rocm/lib python3 caffe2/python/examples/resnet50_trainer.py --train_data null --batch_size 16 --epoch_size 1000 --num_epochs 2 --num_gpus 2"
```

### Copy Pytorch benchmark samples from container to $HOME/Documents on host
```
singularity run pytorch171.rocm401.ubuntu18.sif /bin/bash -c "cd /opt/pytorch-micro-benchmarking; cp -r . $HOME/Documents/pytorch-micro-benchmarking; cd /opt/pytorch; cp -r caffe2 $HOME/Documents/pytorch/caffe2; cp -r benchmarks $HOME/Documents/pytorch/benchmarks"
```
##### Output
```
```

### Running sample benchmark#1 after above copy
```
singularity run pytorch171.rocm401.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/pytorch-micro-benchmarking; LD_LIBRARY_PATH=/opt/rocm/lib python3 micro_benchmarking_pytorch.py --network resnext101  --batch-size 128  --iterations 100"
```
##### Output
```
Container was created Thu Apr 15 08:54:36 UTC 2021
Benchmark Launching: /bin/bash -c cd /home/master/Documents/pytorch-micro-benchmarking; LD_LIBRARY_PATH=/opt/rocm/lib python3 micro_benchmarking_pytorch.py --network resnext101  --batch-size 128  --iterations 100
INFO: running forward and backward for warmup.
...output snipped...
```
### Running sample benchmark#2 after above copy
```
singularity run pytorch171.rocm401.ubuntu18.sif /bin/bash -c "cd $HOME/Documents/pytorch; LD_LIBRARY_PATH=/opt/rocm/lib python3 caffe2/python/examples/resnet50_trainer.py --train_data null --batch_size 16 --epoch_size 1000 --num_epochs 2 --num_gpus 2"
```
##### Output
```
Container was created Thu Apr 15 08:54:36 UTC 2021
Benchmark Launching: /bin/bash -c cd /home/master/Documents/pytorch; LD_LIBRARY_PATH=/opt/rocm/lib python3 caffe2/python/examples/resnet50_trainer.py --train_data null --batch_size 16 --epoch_size 1000 --num_epochs 2 --num_gpus 2
...output snipped...
```

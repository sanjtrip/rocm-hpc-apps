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
    singularity run pytorch171.rocm401.ubuntu18.sif /bin/bash -c "cp -r /opt/pytorch-micro-benchmarking $HOME/Documents; cd $HOME/Documents/pytorch-micro-benchmarking; python3 micro_benchmarking_pytorch.py --network resnext101  --batch-size 128  --iterations 100"
    singularity run pytorch171.rocm401.ubuntu18.sif /bin/bash -c "cp -r /opt/pytorch/caffe2/python/examples $HOME/Documents; cd $HOME/Documents/examples; python3 $HOME/Documents/examples/resnet50_trainer.py --train_data null --batch_size 16 --epoch_size 1000 --num_epochs 2 --num_gpus 2"
```

### Running sample benchmark#1
```
singularity run pytorch171.rocm401.ubuntu18.sif /bin/bash -c "cp -r /opt/pytorch-micro-benchmarking $HOME/Documents; cd $HOME/Documents/pytorch-micro-benchmarking; python3 micro_benchmarking_pytorch.py --network resnext101  --batch-size 128  --iterations 100"
```
##### Output
```
Container was created Thu Apr 15 20:38:05 UTC 2021
CWD: /opt/pytorch Launching: /bin/bash -c cp -r /opt/pytorch-micro-benchmarking /home/USERHOME/Documents; cd /home/USERHOME/Documents/pytorch-micro-benchmarking; python3 micro_benchmarking_pytorch.py --network resnext101  --batch-size 128  --iterations 100
INFO: running forward and backward for warmup.
INFO: running the benchmark..
OK: finished running benchmark..
--------------------SUMMARY--------------------------
Microbenchmark for network : resnext101
Num devices: 1
Dtype: FP32
Mini batch size [img] : 128
Time per mini-batch : 1.8641224884986878
Throughput [img/sec] : 68.66501573246275
```
### Running sample benchmark#2
```
singularity run pytorch171.rocm401.ubuntu18.sif /bin/bash -c "cp -r /opt/pytorch/caffe2/python/examples $HOME/Documents; cd $HOME/Documents/examples; python3 $HOME/Documents/examples/resnet50_trainer.py --train_data null --batch_size 16 --epoch_size 1000 --num_epochs 2 --num_gpus 2"
```
##### Output
```
Container was created Thu Apr 15 20:38:05 UTC 2021
CWD: /opt/pytorch Launching: /bin/bash -c cp -r /opt/pytorch/caffe2/python/examples /home/USERHOME/Documents; cd /home/USERHOME/Documents/examples; python3 /home/USERHOME/Documents/examples/resnet50_trainer.py --train_data null --batch_size 16 --epoch_size 1000 --num_epochs 2 --num_gpus 2
Ignoring @/caffe2/caffe2/contrib/gloo:gloo_ops as it is not a valid file.
Ignoring @/caffe2/caffe2/contrib/nccl:nccl_ops as it is not a valid file.
Ignoring @/caffe2/caffe2/contrib/gloo:gloo_ops_gpu as it is not a valid file.
Ignoring @/caffe2/caffe2/distributed:file_store_handler_ops as it is not a valid file.
Ignoring @/caffe2/caffe2/distributed:redis_store_handler_ops as it is not a valid file.
[E init_intrinsics_check.cc:43] CPU feature avx is present on your machine, but the Caffe2 binary is not compiled with it. It means you may not get the full speed of your CPU.
[E init_intrinsics_check.cc:43] CPU feature avx2 is present on your machine, but the Caffe2 binary is not compiled with it. It means you may not get the full speed of your CPU.
[E init_intrinsics_check.cc:43] CPU feature fma is present on your machine, but the Caffe2 binary is not compiled with it. It means you may not get the full speed of your CPU.
INFO:Imagenet_trainer:Running on GPUs: [0, 1]
INFO:Imagenet_trainer:Using epoch size: 992
INFO:data_parallel_model:Parallelizing model for devices: [0, 1]
INFO:data_parallel_model:Create input and model training operators
INFO:data_parallel_model:Model for GPU : 0
INFO:data_parallel_model:Model for GPU : 1
...output snipped...
```

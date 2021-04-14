# V1.0 - ROCM Pytorch Dockerfile 
# V1.2
FROM ubuntu:18.04

RUN apt-get clean && \
    apt-get -y update --fix-missing --allow-insecure-repositories && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    aria2 \
    autoconf \
    bison \
    bzip2 \
    check \
    cifs-utils \
    cmake \
    curl \
    dkms \
    dos2unix \
    doxygen \
    flex \
    g++-multilib \
    gcc-multilib \
    git \
    locales \
    libatlas-base-dev \
    libboost-all-dev \
    libboost-program-options-dev \
    libelf-dev \
    libelf1 \
    libfftw3-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libnuma-dev \
    libopenblas-base \
    libopenblas-dev \
    libopencv-dev \
    libpci3 \
    libprotobuf-dev \
    libsnappy-dev \
    libssl-dev \
    libunwind-dev \
    ocl-icd-dev \
    ocl-icd-opencl-dev \
    pkg-config \
    protobuf-compiler \
    python-numpy \
    python-pip \
    python-pip-whl \
    python-scipy \
    python-yaml \
    python3-dev \
    python3-pip \
    ssh \
    swig \
    sudo \
    unzip \
    vim \
    xsltproc && \
        pip3 install Cython && \
        pip3 install numpy && \
        pip3 install optionloop && \
        pip install Cython && \
        pip install numpy && \
        pip install optionloop && \
        pip install setuptools && \
        pip install CppHeaderParser argparse && \
    ldconfig && \
    cd $HOME && \
    apt-get clean && \
    rm -rf /tmp/build /var/lib/apt/lists/*

#
RUN cd $HOME && \
    mkdir -p downloads && \
    cd downloads && \
    wget -O rocminstall.py --no-check-certificate https://raw.githubusercontent.com/srinivamd/rocminstaller/master/rocminstall.py && \
    python3 ./rocminstall.py --nokernel --rev 4.0.1 --nomiopenkernels

#
RUN /bin/sh -c 'ln -sf /opt/rocm-4.0.1 /opt/rocm'

# Control Build target list
# RUN sh -c 'echo "gfx803\ngfx900\ngfx906\ngfx908" >> /opt/rocm/bin/target.lst'

#
RUN locale-gen en_US.UTF-8

# Set up paths
ENV PATH="/opt/rocm-4.0.1/bin:/opt/rocm-4.0.1/opencl/bin:${PATH}"
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Pytorch Build Section

# Clone Pytorcha and benchmark for verification
RUN cd /opt/ && \
    git clone --recursive https://github.com/pytorch/pytorch -b v1.7.1 &&\
    git clone https://github.com/ROCmSoftwarePlatform/pytorch-micro-benchmarking &&\
    cd /opt/pytorch &&\
    python3 -m pip install -r requirements.txt &&\
    pip3 install torchvision --no-deps &&\
    pip3 install image &&\
    python3 tools/amd_build/build_amd.py &&\
    USE_ROCM=1 USE_LMDB=1 USE_OPENCV=1 MAX_JOBS=$(nproc) python3 setup.py install 

# Default to a login shell
CMD ["bash", "-l"]


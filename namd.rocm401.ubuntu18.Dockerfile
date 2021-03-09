# V1.0 ROCM NAMD Dockerfile
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
RUN sh -c 'echo "gfx803\ngfx900\ngfx906\ngfx908" >> /opt/rocm/bin/target.lst'

#
RUN locale-gen en_US.UTF-8

# Set up paths
ENV PATH="/opt/rocm-4.0.1/bin:/opt/rocm-4.0.1/opencl/bin:${PATH}"
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# NAMD Build section
ENV NAMD_HIP=1
ENV NAMD_HOME=/opt/namd
ENV INSTALL_DIR=/opt/namd_install

RUN mkdir $NAMD_HOME && mkdir $INSTALL_DIR

ENV PATH="/opt/namd/NAMD_benchmarks:${PATH}"

# copy NAMD build instruction and buit it
COPY namd-3a6.tgz $INSTALL_DIR/namd-3a6.tgz
COPY NAMD_benchmarks.tgz $INSTALL_DIR/NAMD_benchmarks.tgz

RUN cd $INSTALL_DIR &&\
    tar -zxf namd-3a6.tgz &&\
    tar -zxf NAMD_benchmarks.tgz -C /opt/namd

RUN cd $INSTALL_DIR/NAMD &&\
    wget https://www.ks.uiuc.edu/Research/namd/libraries/fftw-linux-x86_64.tar.gz &&\
    tar -zxf fftw-linux-x86_64.tar.gz --no-same-owner &&\
    mv linux-x86_64 fftw &&\
    wget https://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-x86_64.tar.gz &&\
    tar -zxf tcl8.5.9-linux-x86_64.tar.gz --no-same-owner &&\
    ln -s tcl8.5.9-linux-x86_64 tcl &&\
    wget http://charm.cs.illinois.edu/distrib/charm-6.10.2.tar.gz &&\
    tar -zxf charm-6.10.2.tar.gz --no-same-owner &&\
    ln -s charm-v6.10.2 charm &&\ 
    cd charm &&\
    ./build charm++ multicore-linux-x86_64   -j16  --with-production &&\
    ./build charm++ netlrts-linux-x86_64   smp  -j16  --with-production

########## Build NAMD ##########
# build g++ version
RUN cd $INSTALL_DIR/NAMD &&\
    ./config $NAMD_HOME/Linux-x86_64-g++.hip --with-hip --charm-arch multicore-linux-x86_64 &&\
    cd $NAMD_HOME/Linux-x86_64-g++.hip &&\
    make -j$(nproc)

# Build g++ multi node version
RUN cd $INSTALL_DIR/NAMD &&\
    ./config  $NAMD_HOME/Linux-x86_64-g++.netlrts+hip --with-hip --charm-arch netlrts-linux-x86_64-smp &&\
    cd $NAMD_HOME/Linux-x86_64-g++.netlrts+hip &&\
    make -j$(nproc)

RUN rm -rf $INSTALL_DIR/NAMD_benchmarks.tgz $INSTALL_DIR/namd-3a6.tgz $INSTALL_DIR/NAMD

# Default to a login shell
CMD ["bash", "-l"]

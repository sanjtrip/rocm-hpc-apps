# V1.0 - ROCM LAMMPS Dockerfile 
# V1.2 - ROCM Dockerfile
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

##### UCX & PMI build section

ENV MPI_HOME=/opt/ompi 
ENV UCX_HOME=/opt/ucx 
RUN mkdir $UCX_HOME && mkdir $MPI_HOME 

ENV INSTALL_DIR=/opt/mpi_install 

##############  UCX Build ##################### 
RUN mkdir $INSTALL_DIR && cd $INSTALL_DIR &&\ 
    git clone https://github.com/openucx/ucx.git -b v1.8.0 &&\ 
    cd ucx &&\ 
    ./autogen.sh &&\ 
    mkdir -p build &&\ 
    cd build &&\ 
    ../contrib/configure-release --prefix=$UCX_HOME --with-rocm=/opt/rocm &&\ 
    make -j$(nproc) &&\ 
    make -j$(nproc) install 

##############  MPI Build ##################### 
RUN cd $INSTALL_DIR &&\ 
    git clone https://github.com/open-mpi/ompi.git -b v4.0.3 &&\ 
    cd ompi  &&\ 
    ./autogen.pl &&\ 
    mkdir build &&\ 
    cd build &&\ 
    ../configure --prefix=$MPI_HOME --with-ucx=$UCX_HOME &&\ 
    make -j$(nproc) &&\ 
    make -j$(nproc) install 


ENV INSTALL_DIR=/opt/lammps_install

RUN mkdir $INSTALL_DIR && cd $INSTALL_DIR &&\
    git clone https://github.com/lammps/lammps.git -b stable_29Oct2020 &&\
    cd lammps &&\
    mkdir -p build &&\
    cd build  &&\
    cmake -D PKG_GPU=on -D GPU_API=HIP -D HIP_ARCH=gfx906 -D CMAKE_CXX_COMPILER=hipcc \
          -D HIP_USE_DEVICE_SORT=on -DPKG_KSPACE=yes -DPKG_RIGID=yes -DPKG_MOLECULE=yes \
          -DPKG_MANYBODY=yes -DPKG_GRANULAR=yes -D CMAKE_INSTALL_PREFIX=/usr/local ../cmake &&\
    make -j$(nproc) &&\
    make -j$(nproc) install

# Default to a login shell
CMD ["bash", "-l"]

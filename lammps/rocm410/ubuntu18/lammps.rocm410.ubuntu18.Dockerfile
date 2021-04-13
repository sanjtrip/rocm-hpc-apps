# V1.3 ROCm-4.1.0 LAMMPS HPC Application Dockerfile for Ubuntu18

FROM ubuntu:18.04

RUN sed -i -e "s/\/archive.ubuntu/\/us.archive.ubuntu/" /etc/apt/sources.list && \
    apt-get clean && \
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
    dejagnu \
    dkms \
    dos2unix \
    doxygen \
    flex \
    g++-multilib \
    gcc-multilib \
    git \
    locales \
    libatlas-base-dev \
    libbabeltrace1 \
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
    libpython3.8 \
    libfile-which-perl \
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
    mkdir -p downloads && \
    cd downloads && \
    wget -O rocminstall.py --no-check-certificate https://raw.githubusercontent.com/srinivamd/rocminstaller/master/rocminstall.py && \
    python3 ./rocminstall.py --nokernel --rev 4.1 --nomiopenkernels --repourl http://compute-artifactory.amd.com/artifactory/list/rocm-osdb-deb/compute-rocm-rel-4.1-26/ && \
    cd $HOME && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#
RUN /bin/sh -c 'ln -sf /opt/rocm-4.1.0 /opt/rocm'

#
RUN locale-gen en_US.UTF-8

# Check ROCm-Kernel version
COPY rocm41test.sh /root/rocm41test.sh
RUN chmod a+x /root/rocm41test.sh

ENTRYPOINT ["/root/rocm41test.sh"]


# Set up paths
ENV PATH="/opt/rocm-4.1.0/bin:/opt/rocm-4.1.0/opencl/bin:${PATH}"
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


##### UCX & PMI build section

ENV MPI_HOME=/opt/ompi 
ENV UCX_HOME=/opt/ucx 
RUN mkdir $UCX_HOME && mkdir $MPI_HOME 

ENV INSTALL_DIR=/opt/mpi_install 

##############  UCX Build ##################### 
RUN mkdir $INSTALL_DIR && cd $INSTALL_DIR && \ 
    git clone https://github.com/openucx/ucx.git -b v1.8.0 && \ 
    cd ucx && \ 
    ./autogen.sh && \ 
    mkdir -p build && \ 
    cd build && \ 
    ../contrib/configure-release --prefix=$UCX_HOME --with-rocm=/opt/rocm-4.1.0 && \ 
    make -j$(nproc) && \ 
    make -j$(nproc) install 

##############  MPI Build ##################### 
RUN cd $INSTALL_DIR && \ 
    git clone https://github.com/open-mpi/ompi.git -b v4.0.3 && \ 
    cd ompi  && \ 
    ./autogen.pl && \ 
    mkdir build && \ 
    cd build && \ 
    ../configure --prefix=$MPI_HOME --with-ucx=$UCX_HOME && \ 
    make -j$(nproc) && \ 
    make -j$(nproc) install 

RUN rm -rf $INSTALL_DIR

ENV INSTALL_DIR=/opt/lammps_install
RUN mkdir $INSTALL_DIR 
COPY lammps_stable_29Oct2020.tgz $INSTALL_DIR/lammps_stable_29Oct2020.tgz
 
RUN cd $INSTALL_DIR && \
#   git clone https://github.com/lammps/lammps.git -b stable_29Oct2020 && \
    tar -zxf lammps_stable_29Oct2020.tgz && \
    cd lammps && \
    mkdir -p build && \
    cd build  && \
    cmake -D PKG_GPU=on -D GPU_API=HIP -D HIP_ARCH=gfx906 -D CMAKE_CXX_COMPILER=hipcc \
          -D HIP_USE_DEVICE_SORT=on -DPKG_KSPACE=yes -DPKG_RIGID=yes -DPKG_MOLECULE=yes \
          -DPKG_MANYBODY=yes -DPKG_GRANULAR=yes -D CMAKE_INSTALL_PREFIX=/usr/local ../cmake && \
    make -j$(nproc) && \
    make -j$(nproc) install

RUN rm $INSTALL_DIR/lammps_stable_29Oct2020.tgz


# Default to a login shell
CMD ["bash", "-l"]

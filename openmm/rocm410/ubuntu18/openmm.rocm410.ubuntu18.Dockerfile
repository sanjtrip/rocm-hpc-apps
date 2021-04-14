# V1.3 ROCM-4.1.0 OpenMM HPC Application Dockerfile

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
    wget --no-check-certificate http://sourceforge.net/projects/half/files/latest/download && \
    mv download download.zip && \
    unzip download.zip -d half && \
    mv half /usr/include && \
    cd /tmp && \
    wget https://github.com/opencv/opencv/archive/3.4.0.zip && unzip 3.4.0.zip && \
    rm *.zip && \
    mkdir build && \
    cd /tmp/build && \
    cmake -DWITH_OPENCL=OFF -DWITH_OPENCLAMDFFT=OFF -DWITH_OPENCLAMDBLAS=OFF -DWITH_VA_INTEL=OFF -DWITH_OPENCL_SVM=OFF ../opencv-3.4.0 && \
    make -j$(nproc) && \
    make install && \
    cd $HOME && \
    mkdir -p downloads && \
    cd downloads && \
    wget -O rocminstall.py --no-check-certificate https://raw.githubusercontent.com/srinivamd/rocminstaller/master/rocminstall.py && \
    python3 ./rocminstall.py --nokernel --rev 4.1 --nomiopenkernels --repourl http://compute-artifactory.amd.com/artifactory/list/rocm-osdb-deb/compute-rocm-rel-4.1-26/ && \
    cd $HOME && \
    apt-get clean && \
    rm -rf /tmp/build /tmp/opencv-3.4.0 /var/lib/apt/lists/*

#
RUN /bin/sh -c 'ln -sf /opt/rocm-4.1.0 /opt/rocm'

#
RUN locale-gen en_US.UTF-8

# Set up paths
ENV PATH="/opt/rocm-4.1.0/bin:/opt/rocm-4.1.0/opencl/bin:${PATH}"
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


# Check ROCm-Kernel version
COPY rocm41test.sh /root/rocm41test.sh
RUN chmod a+x /root/rocm41test.sh

ENTRYPOINT ["/root/rocm41test.sh"]


####### OPENMM build section 
ENV LD_LIBRARY_PATH="/usr/local/openmm/lib:${LD_LIBRARY_PATH}"

RUN cd /opt &&\
    git clone --branch hip https://github.com/arghdos/openmm.git &&\
    cd openmm &&\
    mkdir build &&\
    cd build &&\
    cmake .. &&\
    make -j$(nproc) &&\
    make -j$(nproc) install &&\
    cd python/ &&\
    export OPENMM_INCLUDE_PATH=/usr/local/openmm/include &&\
    export OPENMM_LIB_PATH=/usr/local/openmm/lib &&\
    python3 setup.py install 


# Default to a login shell
CMD ["bash", "-l"]

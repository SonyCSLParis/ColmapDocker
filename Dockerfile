# Define Base Image
FROM nvidia/cudia

# Install dependencies

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libfreeimage-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libcgal-qt5-dev

# Install ceres solver
RUN cd /opt
WORKDIR /opt
RUN apt-get install -y libatlas-base-dev libsuitesparse-dev libgoogle-glog-dev libeigen3-dev libsuitesparse-dev
RUN git clone https://ceres-solver.googlesource.com/ceres-solver
RUN cd ceres-solver
WORkDIR /opt/ceres-solver
RUN mkdir build
RUN cd build
WORKDIR /opt/ceres-solver/build
RUN cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
RUN make
RUN make install


# Install Colmap

RUN cd /opt
WORKDIR /opt
RUN git clone https://github.com/colmap/colmap
RUN cd colmap
WORKDIR /opt/colmap
RUN mkdir build
RUN cd build
WORKDIR /opt/colmap/build
RUN cmake ..
RUN make
RUN make install
RUN cd /
RUN mkdir -p /home/app
RUN mkdir /home/app/data

# Specify working directory

WORKDIR /home/app

# Copy script from Host machine to working directory of the container
COPY colmap.sh .

# Specify entry point of the container

ENTRYPOINT ["sh", "colmap.sh"]

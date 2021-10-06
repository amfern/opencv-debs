FROM arm64v8/ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    build-essential \
    cmake \
    pkg-config \
    git

RUN apt-get install -y libjpeg-dev libpng-dev
RUN apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libavresample-dev
RUN apt-get install -y libgtk2.0-dev libcanberra-gtk* libgtk-3-dev
RUN apt-get install -y libxvidcore-dev libx264-dev libfaac-dev libmp3lame-dev libtheora-dev
RUN apt-get install -y python3-dev python3-numpy python3-pip
RUN apt-get install -y libtbb2 libtbb-dev libdc1394-22-dev
RUN apt-get install -y libv4l-dev v4l-utils
RUN apt-get install -y libopenblas-dev libatlas-base-dev libblas-dev
RUN apt-get install -y liblapack-dev gfortran libhdf5-dev
RUN apt-get install -y libprotobuf-dev libgoogle-glog-dev libgflags-dev
RUN apt-get install -y protobuf-compiler
RUN apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

RUN git clone --depth 1 --branch 4.5.2 https://github.com/opencv/opencv.git
RUN git clone --depth 1 --branch 4.5.2 https://github.com/opencv/opencv_contrib.git

RUN mkdir -p opencv/build

WORKDIR /opencv/build

RUN cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local/opencv-4.5.2 \
    -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D WITH_OPENMP=ON \
    -D WITH_OPENCL=OFF \
    -D BUILD_ZLIB=ON \
    -D BUILD_TIFF=ON \
    -D WITH_FFMPEG=ON \
    -D WITH_TBB=ON \
    -D WITH_GSTREAMER=ON \
    -D BUILD_TBB=ON \
    -D BUILD_TESTS=OFF \
    -D WITH_EIGEN=OFF \
    -D WITH_GSTREAMER=OFF \
    -D WITH_V4L=ON \
    -D WITH_LIBV4L=ON \
    -D WITH_VTK=OFF \
    -D WITH_QT=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D BUILD_opencv_python3=TRUE \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D BUILD_EXAMPLES=OFF \
    -D CPACK_BINARY_DEB=ON \
    -D CPACK_SET_DESTDIR=OFF \
    -D CPACK_PACKAGING_INSTALL_PREFIX=/usr/local/opencv-4.5.2 \
    ..

RUN make -j$(nproc)
RUN make install
RUN make package

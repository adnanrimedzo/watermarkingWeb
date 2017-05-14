#!/bin/bash

CV2_VERSION=${1:-3.1.0}

wget -q -O cv2.tar.gz https://github.com/opencv/opencv/archive/${CV2_VERSION}.tar.gz
tar -xvzf cv2.tar.gz && rm cv2.tar.gz

SOURCE_DIR="$PWD/opencv-$CV2_VERSION"
mkdir -p "$SOURCE_DIR/build"
cd "$SOURCE_DIR/build"

cmake \
  -D WITH_1394=OFF\
  -D WITH_TBB=ON\
  -D WITH_EIGEN=ON\
  -D WITH_CUDA=OFF\
  -D BUILD_PERF_TESTS=OFF\
  -D BUILD_TESTS=OFF\
  -D PYTHON3_EXECUTABLE=$(which python3)\
  -D CMAKE_INSTALL_PREFIX=/usr/local\
  -D CMAKE_BUILD_TYPE=RELEASE\
  -D ENABLE_PRECOMPILED_HEADERS=OFF\
  -D BUILD_SHARED_LIBS=ON\
  -D BUILD_opencv_core=ON              `# Core functionality` \
  -D BUILD_opencv_ml=ON                `# Machine Learning` \
  -D BUILD_opencv_imgproc=ON           `# Image processing` \
  -D BUILD_opencv_imgcodecs=ON         `# Image file reading and writing` \
  -D BUILD_opencv_features2d=ON        `# 2D Features Framework` \
  -D BUILD_opencv_flann=ON             `# Clustering and Search in Multi-Dimensional Spaces` \
  -D BUILD_opencv_objdetect=ON         `# Object Detection` \
  -D BUILD_opencv_videoio=OFF          `# Video I/O` \
  -D BUILD_opencv_highgui=OFF          `# High-level GUI` \
  -D BUILD_opencv_video=OFF            `# Video Analysis` \
  -D BUILD_opencv_calib3d=OFF          `# Camera Calibration and 3D Reconstruction` \
  -D BUILD_opencv_photo=OFF            `# Computational Photography` \
  -D BUILD_opencv_stitching=OFF        `# Images stitching` \
  -D BUILD_opencv_cudaarithm=OFF       `# Operations on Matrices` \
  -D BUILD_opencv_cudabgsegm=OFF       `# Background Segmentation` \
  -D BUILD_opencv_cudacodec=OFF        `# Video Encoding/Decoding` \
  -D BUILD_opencv_cudafeatures2d=OFF   `# Feature Detection and Description` \
  -D BUILD_opencv_cudafilters=OFF      `# Image Filtering` \
  -D BUILD_opencv_cudaimgproc=OFF      `# Image Processing` \
  -D BUILD_opencv_cudalegacy=OFF       `# Legacy support` \
  -D BUILD_opencv_cudaobjdetect=OFF    `# Object Detection` \
  -D BUILD_opencv_cudaoptflow=OFF      `# Optical Flow` \
  -D BUILD_opencv_cudastereo=OFF       `# Stereo Correspondence` \
  -D BUILD_opencv_cudawarping=OFF      `# Image Warping` \
  -D BUILD_opencv_cudev=OFF            `# Device layer` \
  -D BUILD_opencv_shape=OFF            `# Shape Distance and Matching` \
  -D BUILD_opencv_superres=OFF         `# Super Resolution` \
  -D BUILD_opencv_videostab=OFF        `# Video Stabilization` \
  -D BUILD_opencv_viz=OFF              `# 3D Visualizer` \
  ..

make -j4
make install

rm -r $SOURCE_DIR
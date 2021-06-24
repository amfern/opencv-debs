# Builds opencv 4.2 for ubuntu 18.04 on reaspbbery pi

all: release

setup:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

image-arm64:
	docker buildx build --platform linux/arm64 -t opencv-4.2-ubuntu-bionic-arm64-debs -o type=docker arm64

image-arm64-cuda-l4t:
	docker build -t opencv-4.2-ubuntu-bionic-arm64-cuda-l4t-debs arm64-cuda-l4t

image-amd64-cuda:
	docker buildx build --platform linux/amd64 -t opencv-4.2-ubuntu-bionic-amd64-cuda-debs -o type=docker amd64-cuda

image-amd64:
	docker buildx build --platform linux/amd64 -t opencv-4.2-ubuntu-bionic-amd64-debs -o type=docker amd64

release-arm64: image-arm64
	mkdir -p release/OpenCV-4.2.0-arm64
	docker run -ti --rm -v `pwd`/release/OpenCV-4.2.0-arm64:/release opencv-4.2-ubuntu-bionic-arm64-debs bash -c "cp *.deb /release"

release-arm64-cuda-l4t: image-arm64-cuda-l4t
	mkdir -p release/OpenCV-4.2.0-arm64-cuda
	docker run -ti --rm -v `pwd`/release/OpenCV-4.2.0-arm64-cuda:/release opencv-4.2-ubuntu-bionic-arm64-cuda-l4t-debs bash -c "cp *.deb /release"

release-amd64-cuda: image-amd64-cuda
	mkdir -p release/OpenCV-4.2.0-amd64-cuda
	docker run -ti --rm -v `pwd`/release/OpenCV-4.2.0-amd64-cuda:/release opencv-4.2-ubuntu-bionic-amd64-cuda-debs bash -c "cp *.deb /release"

release-amd64: image-amd64
	mkdir -p release/OpenCV-4.2.0-amd64
	docker run -ti --rm -v `pwd`/release/OpenCV-4.2.0-amd64:/release opencv-4.2-ubuntu-bionic-amd64-debs bash -c "cp *.deb /release"

release-arm64-tar: release-arm64
	cd release && tar -czf OpenCV-4.2.0-arm64.tar.xz OpenCV-4.2.0-arm64

release-arm64-cuda-l4t-tar: release-arm64-cuda-l4t
	cd release && tar -czf OpenCV-4.2.0-arm64-cuda.tar.xz OpenCV-4.2.0-arm64-cuda

release-amd64-cuda-tar: release-amd64-cuda
	cd release && tar -czf OpenCV-4.2.0-amd64-cuda.tar.xz OpenCV-4.2.0-amd64-cuda

release-amd64-tar: release-amd64
	cd release && tar -czf OpenCV-4.2.0-amd64.tar.xz OpenCV-4.2.0-amd64

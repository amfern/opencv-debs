# Builds opencv 4.2 for ubuntu 18.04 on reaspbbery pi

all: release

setup:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

image-arm64:
	docker buildx build --platform linux/arm64 -t opencv-4.2-ubuntu-bionic-arm64-debs -o type=docker arm64

image-amd64-cuda:
	docker buildx build --platform linux/amd64-cuda -t opencv-4.2-ubuntu-bionic-amd64-cuda-debs -o type=docker amd64-cuda

release-arm64: image-arm64
	mkdir -p release/OpenCV-4.2.0-aarch64
	docker run -ti --rm -v `pwd`/release/OpenCV-4.2.0-aarch64:/release opencv-4.2-ubuntu-bionic-arm64-debs bash -c "cp *.deb /release"

release-amd64-cuda: image-amd64-cuda
	mkdir -p release/OpenCV-4.2.0-amd64-cuda
	docker run -ti --rm -v `pwd`/release/OpenCV-4.2.0-amd64-cuda:/release opencv-4.2-ubuntu-bionic-amd64-cuda-debs bash -c "cp *.deb /release"

release-arm64-tar: release-arm64
	cd release && tar -czf OpenCV-4.2.0-aarch64.tar.xz OpenCV-4.2.0-aarch64

release-amd64-cuda-tar: release-amd64-cuda
	cd release && tar -czf OpenCV-4.2.0-amd64-cuda.tar.xz OpenCV-4.2.0-amd64-cuda

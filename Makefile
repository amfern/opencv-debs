# Builds opencv 4.2 for ubuntu 18.04 on reaspbbery pi

setup:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

image-arm64:
	docker buildx build --platform linux/arm64 -t opencv-4.2-ubuntu-bionic-arm64-debs -o type=docker arm64

# need to be run from l4t jetson device only
image-arm64-cuda-l4t:
	docker build -t opencv-4.2-ubuntu-bionic-arm64-cuda-l4t-debs arm64-cuda-l4t

image-arm64-focal:
	docker buildx build --platform linux/arm64 -t opencv-4.5-ubuntu-focal-arm64-debs -o type=docker arm64-focal

# need to be run cuda capable hardwre with nvidia runtime https://stackoverflow.com/questions/59691207/docker-build-with-nvidia-runtime
image-amd64-cuda:
	docker buildx build --platform linux/amd64 -t opencv-4.2-ubuntu-bionic-amd64-cuda-debs -o type=docker amd64-cuda

image-amd64-focal:
	docker build -t opencv-4.5.2-ubuntu-focal-arm64-debs amd64-focal

# need to be run cuda capable hardwre with nvidia runtime https://stackoverflow.com/questions/59691207/docker-build-with-nvidia-runtime
image-amd64-cuda-focal:
	docker build -t opencv-4.5.2-ubuntu-focal-arm64-cuda-debs amd64-cuda-focal

image-amd64:
	docker buildx build --platform linux/amd64 -t opencv-4.2-ubuntu-bionic-amd64-debs -o type=docker amd64

release-arm64: image-arm64
	mkdir -p release/OpenCV-4.2.0-arm64
	docker run -ti --rm -v `pwd`/release/OpenCV-4.2.0-arm64:/release opencv-4.2-ubuntu-bionic-arm64-debs bash -c "cp *.deb /release"

release-arm64-cuda-l4t: image-arm64-cuda-l4t
	mkdir -p release/OpenCV-4.2.0-arm64-cuda
	docker run -ti --rm -v `pwd`/release/OpenCV-4.2.0-arm64-cuda:/release opencv-4.2-ubuntu-bionic-arm64-cuda-l4t-debs bash -c "cp *.deb /release"

release-arm64-focal: image-arm64-focal
	mkdir -p release/OpenCV-4.5.2-arm64-focal
	docker run -ti --rm -v `pwd`/release/OpenCV-4.5.2-arm64-focal:/release opencv-4.5-ubuntu-focal-arm64-debs bash -c "cp *.deb /release"

release-amd64-cuda: image-amd64-cuda
	mkdir -p release/OpenCV-4.2.0-amd64-cuda
	docker run -ti --rm -v `pwd`/release/OpenCV-4.2.0-amd64-cuda:/release opencv-4.2-ubuntu-bionic-amd64-cuda-debs bash -c "cp *.deb /release"

release-amd64-focal: image-amd64-focal
	mkdir -p release/OpenCV-4.5.2-amd64-focal
	docker run -ti --rm -v `pwd`/release/OpenCV-4.5.2-amd64-focal:/release opencv-4.5.2-ubuntu-focal-arm64-debs bash -c "cp *.deb /release"

release-amd64-cuda-focal: image-amd64-cuda-focal
	mkdir -p release/OpenCV-4.5.2-amd64-cuda-focal
	docker run -ti --rm -v `pwd`/release/OpenCV-4.5.2-amd64-cuda-focal:/release opencv-4.5.2-ubuntu-focal-arm64-cuda-debs bash -c "cp *.deb /release"

release-amd64: image-amd64
	mkdir -p release/OpenCV-4.2.0-amd64
	docker run -ti --rm -v `pwd`/release/OpenCV-4.2.0-amd64:/release opencv-4.2-ubuntu-bionic-amd64-debs bash -c "cp *.deb /release"

release-arm64-tar: release-arm64
	cd release && tar -czf OpenCV-4.2.0-arm64.tar.xz OpenCV-4.2.0-arm64

release-arm64-cuda-l4t-tar: release-arm64-cuda-l4t
	cd release && tar -czf OpenCV-4.2.0-arm64-cuda.tar.xz OpenCV-4.2.0-arm64-cuda

release-arm64-focal-tar: release-arm64-focal
	cd release && tar -czf OpenCV-4.5.2-arm64-focal.tar.xz OpenCV-4.5.2-arm64-focal

release-amd64-cuda-tar: release-amd64-cuda
	cd release && tar -czf OpenCV-4.2.0-amd64-cuda.tar.xz OpenCV-4.2.0-amd64-cuda

release-amd64-focal-tar: release-amd64-focal
	cd release && tar -czf OpenCV-4.5.2-amd64-focal.tar.xz OpenCV-4.5.2-amd64-focal

release-amd64-cuda-focal-tar: release-amd64-cuda-focal
	cd release && tar -czf OpenCV-4.5.2-amd64-cuda-focal.tar.xz OpenCV-4.5.2-amd64-cuda-focal

release-amd64-tar: release-amd64
	cd release && tar -czf OpenCV-4.2.0-amd64.tar.xz OpenCV-4.2.0-amd64

all: release-amd64-tar release-amd64-cuda-focal-tar release-amd64-cuda-tar release-arm64-tar release-arm64-focal-tar

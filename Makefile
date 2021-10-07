# Builds opencv 4.2 for ubuntu 18.04 on reaspbbery pi

setup:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

create-release-dir:
	mkdir -p release

release-arm64-bionic: create-release-dir
	docker buildx build --target=artifact --output type=tar,dest=release/OpenCV-4.2.0-arm64-bionic.tar arm64

release-arm64-cuda-l4t: create-release-dir
	docker buildx build --target=artifact --output type=tar,dest=release/OpenCV-4.2.0-arm64-cuda-l4t.tar arm64-cuda-l4t

release-arm64-focal: create-release-dir
	docker buildx build --target=artifact --output type=tar,dest=release/OpenCV-4.5.2-arm64-focal.tar arm64-focal

# need to be run cuda capable hardwre with nvidia runtime https://stackoverflow.com/questions/59691207/docker-build-with-nvidia-runtime
release-amd64-cuda-bionic: create-release-dir
	docker buildx build --target=artifact --output type=tar,dest=release/OpenCV-4.2.0-amd64-cuda-bionic.tar amd64-cuda-focal

release-amd64-focal: create-release-dir
	docker buildx build --target=artifact --output type=tar,dest=release/OpenCV-4.5.2-amd64-focal.tar amd64-focal

# need to be run cuda capable hardwre with nvidia runtime https://stackoverflow.com/questions/59691207/docker-build-with-nvidia-runtime
release-amd64-cuda-focal: create-release-dir
	docker buildx build --target=artifact --output type=tar,dest=release/OpenCV-4.5.2-amd64-cuda-focal.tar amd64-cuda-focal

release-amd64-bionic: create-release-dir
	docker buildx build --target=artifact --output type=tar,dest=release/OpenCV-4.2.0-amd64-bionic.tar amd64

all: release-arm64-bionic release-arm64-focal release-amd64-cuda-bionic release-amd64-focal release-amd64-cuda-focal release-amd64-bionic

all-l4t: OpenCV-4.5.2-arm64-focal

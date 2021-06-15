# Builds opencv 4.2 for ubuntu 18.04 on reaspbbery pi

all: release

setup:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

image:
	docker buildx build --platform linux/arm64 -t opencv-4.2-ubuntu-bionic-arm64-debs -o type=docker .

release: image
	mkdir -p release
	docker run -ti --rm -v `pwd`/release:/release opencv-4.2-ubuntu-bionic-arm64-debs bash -c "cp *.deb /release"

# Builds opencv 4.2 for ubuntu 18.04 on reaspbbery pi

all: release

image:
	docker buildx build --platform linux/arm64 -t opencv-4.2-ubuntu-bionic-arm64-debs -o type=docker .

release: image
	mkdir -p release
	docker run -ti --rm -v `pwd`/release:/release opencv-4.2-ubuntu-bionic-arm64-debs bash -c "cp *.deb /release"

release-tar: release
	mkdir -p release/OpenCV-4.2.0-aarch64
	cd release && tar -czf OpenCV-4.2.0-aarch64.tar.xz OpenCV-4.2.0-aarch64

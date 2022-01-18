# Precompiled opencv debian package for ubuntu

This project uses buildx to build open cv pacakge for arm64.

On Arch linux install binfmt-qemu-static and qemu-user-static from the AUR on the x86_64 machine/host. binfmt-qemu-static will take care of registering the qemu binaries to binfmt service.
-- or use docker muliarch for this --
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

the following command should return alot of supported platforms
docker buildx inspect --bootstrap

## compile:
```bash
make release-arm64-bionic
make release-amd64-bionic
make release-arm64-focal
make release-amd64-focal
make release-amd64-cuda-bionic
make release-amd64-cuda-focal
```
For l4t support please refer to https://github.com/timongentzsch/Jetson_Ubuntu20_Images or https://github.com/dusty-nv/jetson-containers

## installation
All the recent release can be downloaded from this repo 
Download from the [release](release) direcotry, untar and install with apt

opencv will be installed into `/usr/local`

For example:
```bash
wget -c https://github.com/amfern/opencv-4.2-ubuntu-bionic-arm64-debs/raw/master/release/OpenCV-4.5.2-amd64-cuda-focal.tar -O - | tar -x
cd ./OpenCV-4.5.2-amd64-cuda-focal
apt install -y --no-install-recommends ./*.deb
```

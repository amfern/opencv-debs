# Precompiled opencv debian package for ubuntu 18.04 bionic

This project uses buildx to build open cv pacakge for arm64.

On Arch linux install binfmt-qemu-static and qemu-user-static from the AUR on the x86_64 machine/host. binfmt-qemu-static will take care of registering the qemu binaries to binfmt service.
-- or use docker muliarch for this --
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

the following command should return alot of supported platforms
docker buildx inspect --bootstrap


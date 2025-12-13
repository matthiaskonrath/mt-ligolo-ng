#!/bin/bash


########################################################################
### CONFIG ###
########################################################################
### see https://github.com/nicocha30/ligolo-ng/releases
ligolo_ng_version=0.8.2

### armv6 / armv7 / arm64
ligolo_ng_arch=arm64

### arm / arm64
docker_build_arch=arm64



########################################################################
### SETUP ###
########################################################################
cp Dockerfile_template Dockerfile

sed -i -e "s/VERSION/$ligolo_ng_version/g" Dockerfile
sed -i -e "s/ARCH/$ligolo_ng_arch/g" Dockerfile



########################################################################
### BUILD + EXPORT ###
########################################################################
docker buildx build  --no-cache --platform linux/$docker_build_arch --output=type=docker -t mt-ligolo-ng_$ligolo_ng_arch .
docker save mt-ligolo-ng_$ligolo_ng_arch > mt-ligolo-ng_$ligolo_ng_arch.tar



########################################################################
### Cleanup
########################################################################
rm -rf Dockerfile Dockerfile-e

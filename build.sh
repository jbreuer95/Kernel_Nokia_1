#!/bin/bash

#clean out dir
rm -rf out
mkdir -p out


#ARCH
export ARCH=arm

#get toolchain gcc-4.9
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 gcc4.9
export CROSS_COMPILE=$PWD/gcc4.9/bin/arm-linux-androideabi-

#Defconfig for Nokia 1
make -C $PWD O=$PWD/out ARCH=arm FRT_defconfig


#CompileNow
make -j64 -C $PWD O=$PWD/out ARCH=arm

rm boot.img
abootimg --create boot.img -f files/bootimg.cfg -k out/arch/arm/boot/zImage-dtb -r files/initrd.img

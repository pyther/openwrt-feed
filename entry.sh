#!/bin/sh
BUILD_DIR='/src/build'

# UPDATE ME! x86_64 snapshot
# Platform List: https://openwrt.org/docs/platforms/start
# Release Page: https://downloads.openwrt.org/releases/19.07.3/targets/
SDK_URL="https://downloads.openwrt.org/snapshots/targets/x86/64/openwrt-sdk-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz"
SDK_SUM="6a70cd1e6249125b0c669679fba9302e40cffae004f63b3a5117b2fff6d42049"

#SDK_URL="https://downloads.openwrt.org/releases/19.07.3/targets/x86/64/openwrt-sdk-19.07.3-x86-64_gcc-7.5.0_musl.Linux-x86_64.tar.xz"
#SDK_SUM="aeafd4f8405ac2a226c3aa1b5b98e1994a541cdca2f2fe2d0b8a1696a73cf8d9"
#SDK_URL="https://downloads.openwrt.org/releases/19.07.3/targets/brcm2708/bcm2710/openwrt-sdk-19.07.3-brcm2708-bcm2710_gcc-7.5.0_musl.Linux-x86_64.tar.xz"
#SDK_SUM="31edcbb9a1a9500040d1baef84cea639561d97ed2a9808bef2b109014755c813"

SDK_FILE=$(basename $SDK_URL)

download() {
    echo "Downloading SDK"
    wget $SDK_URL || exit 1
}

setup() {
    # Download file, if it does not exist
    [ -f $SDK_FILE ] || download

    # check that download tar matches expected checksum
    if [ "$(sha256sum $SDK_FILE | awk '{print $1}')" != $SDK_SUM ]; then
       echo "$SDK_FILE does not match sha256 signature"
       exit 1
    fi

    echo "Extracting SDK"
    tar xf $SDK_FILE
    
    echo "Updating and Installing openwrt feeds"
    cd $(basename $SDK_FILE .tar.xz)
    
    cp feeds.conf.default feeds.conf
    echo "src-link pyther /src" >> feeds.conf
    ./scripts/feeds update -a
    ./scripts/feeds install -a

    echo "Generating config and disabling package signing"
    make defconfig
    sed -i 's/CONFIG_SIGNED_PACKAGES=y/CONFIG_SIGNED_PACKAGES=n/' .config
}

if [ ! -d $BUILD_DIR ]; then
   echo "$BUILD_DIR does not exist, did you remember to bind mount it?"
   exit 1
fi

cd $BUILD_DIR

# Check if Directory exists
if [ -d $(basename $SDK_FILE .tar.xz) ]; then
   echo "WARNING: $(basename $SDK_FILE .tar.xz) exists! Skipping setup!"
   cd $(basename $SDK_FILE .tar.xz) || exit 1
else
   setup
fi

PKG=$1
if [ ! -z $PKG ]; then
   echo "$PKG: Download"
   make package/$PKG/download V=s || exit 1
   
   echo "$PKG: Prepare"
   make package/$PKG/prepare V=s || exit 1
   
   echo "$PKG: Compile"
   make package/$PKG/compile V=s || exit 1
fi

# OpenWrt Feed
## Packages

* [`goeap_proxy`](https://github.com/pyther/goeap_proxy) (Go: Proxy EAP packets between network interfaces)
* [`eap_proxy`](https://github.com/jaysoffian/eap_proxy) (Python: Proxy EAP packets between network interfaces)
* [`ookla-speedtest`](https://www.speedtest.net/apps/cli) (Ookla's Speedtest CLI)

## Building Packages
### Openwrt Build Procedure
This is a standard OpenWrt Feed, therefore packages should be built in the same way as another OpenWrt package.

1. Add to feeds.conf: `src-git pyther git://github.com/pyther/openwrt-feed`
2. Update the feed: `./scripts/feeds update pyther`
3. Install the package: `./scritps/feeds install $PKGNAME`
4. Build Package: `make package/$PKGNAME/{download,prepare,compile}' 

Resources
- https://openwrt.org/docs/guide-developer/using_the_sdk
- https://openwrt.org/docs/guide-developer/single.package
- https://openwrt.org/docs/guide-developer/quickstart-build-images

### With Docker
The included DockerFile should make the build process simple and remove any enivorment specific build issues.

1. Clone: `git clone https://github.com/pyther/openwrt-feed.git`
2. Change Dir: `cd openwrt-feed`
3. Update `SDK_URL`, and `SDK_SUM` in `entry.sh`
4. Update UID/GID in the Dockerfile to match that of your current user (`id`)
4. Build Docker Image: `sudo docker build . -t openwrt-sdk:latest`
5. Create Build Directory: `mkdir ./build`
6. Build Package: `sudo docker run --rm -it --volume $(pwd):/src openwrt-sdk:latest goeap_proxy`
  - replace `goeap_proxy` with the name of the package you want to build
7. Built packages can be found in `./build/openwrt-sdk-x86-64_gcc-8.4.0_musl.Linux-x86_64/bin/packages/x86_64/pyther`

Troubleshooting

To get an interactive shell in container to troubleshoot build problems run
```
$ sudo docker run -it --volume $(pwd):/src --entrypoint /bin/sh openwrt-sdk:latest
$ sh -x /tmp/entry.sh # no args setups the build envirnoment
$ sh -x /tmp/entry.sh goeap_proxy # builds goeap_proxy package
```


### With Helper Script
The included entry.sh will automate the process of downloading, extracting, and
building the package. You can either run the script or use it as guide for
manual command execution.

1. Clone: `git clone https://github.com/pyther/openwrt-feed.git`
2. Change Dir: `cd openwrt-feed`
3. Update 'BUILD_DIR`, `SDK_URL`, and `SDK_SUM` in `entry.sh`
4. sh entry.sh PKG_NAME

## Building OpenWrt Image

1. Download the OpenWrt Image Builder: [Instructions: Using the Image Builder](https://openwrt.org/docs/guide-user/additional-software/imagebuilder)
    ```
    $ wget https://downloads.openwrt.org/releases/18.06.4/targets/x86/64/openwrt-imagebuilder-18.06.4-x86-64.Linux-x86_64.tar.xz
    ```

2. Extract Image Builder and enter directory
    ```
    $ tar xf openwrt-imagebuilder-18.06.4-x86-64.Linux-x86_64.tar.xz
    $ cd openwrt-imagebuilder-18.06.4-x86-64.Linux-x86_64
    ```

3. Copy built package into `./packages`
    ```
    $ cp ~/build/openwrt-sdk-18.06.4-x86-64_gcc-7.3.0_musl.Linux-x86_64/bin/packages/x86_64/pyther/goeap_proxy_0.200502.3-1_x86_64.ipk ./packages
    ```

4. Build Image
    ```
    $ make image PACKAGES="goeap_proxy"
    ```

    Note: other platforms (non-x86) you mant to to specify `PROFILE=XXX`

    List of profiles can be obtained with
    ```
    $ make info
    ```

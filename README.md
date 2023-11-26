# OpenWrt Feed

Build `goeap_proxy` or other projects for a specific install on OpenWRT.


## Packages

* [`goeap_proxy`](https://github.com/pyther/goeap_proxy) (Go: Proxy EAP packets between network interfaces)
* [`eap_proxy`](https://github.com/jaysoffian/eap_proxy) (Python: Proxy EAP packets between network interfaces)
* [`ookla-speedtest`](https://www.speedtest.net/apps/cli) (Ookla's Speedtest CLI)

## Building Packages

### With Podman and Buildah

Most people will want this method, for simplicity. Just install `buildah` and
`podman` on your distribution. Everything else will run rootless. The included
DockerFile should make the build process simple and remove any enivorment
specific build issues.

1. Clone: `git clone https://github.com/pyther/openwrt-feed.git`
2. Change Dir: `cd openwrt-feed`
3. Update `SDK_URL`, and `SDK_SUM` in `entry.sh`, you can get these paths by going to the
	* [OpenWRT Release page](https://downloads.openwrt.org/releases), select the
		one you want, likely the newest at the bottom. **It must match the version
		on your router.**
	* Select your build.
	* Select your chipset.
	* Scroll down to "Supplementary Files": the link under "Filename" is your `SDK_URL`; the "sha256sum" is your `SDK_SUM`.
4. Build image, note the image created won't actually have the SDK in it. Just the environment to put the SDK.
	```shell
	buildah bud -t openwrt-sdk:latest .
	```
5. Download the SDK and build package: replace `goeap_proxy` with the name of the package you want to build
	```shell
	podman run --rm -it -v "${PWD}:/src" openwrt-sdk:latest goeap_proxy
	```
6. Built packages can be found in `./build/*/bin/packages/*/pyther`, or with `find`,
	```shell
	# See what packages were built
	ls ./build/*/bin/packages/*/pyther

	# Find them by their full path
	find . -name '*.ipk' -path '*/pyther/*'
	```
7. After you have the packages built you can either,
	* Upload and install directly to LuCI (web interface)
	  * Log into LuCI
		* Click on "System" tab, select "Software" from the drop down
		* Click "Upload Package"
	* Copy the package to the router and install on the CLI with `opkg install ./package.ipk`

### Openwrt Build Procedure

While more complex, this is a standard OpenWrt Feed, therefore packages can be built in the same way as another OpenWrt package.

1. Add to feeds.conf: `src-git pyther https://github.com/pyther/openwrt-feed.git`
2. Update the feed: `./scripts/feeds update pyther`
3. Install the package: `./scritps/feeds install $PKGNAME`
4. Build Package: `make package/$PKGNAME/{download,prepare,compile}' 

Resources
- https://openwrt.org/docs/guide-developer/using_the_sdk
- https://openwrt.org/docs/guide-developer/single.package
- https://openwrt.org/docs/guide-developer/quickstart-build-images

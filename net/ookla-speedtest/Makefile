include $(TOPDIR)/rules.mk

PKG_NAME:=ookla-speedtest
PKG_VERSION:=1.0.0.2
PKG_RELEASE:=1
PKG_SOURCE:=$(PKG_NAME)-1.0.0-x86_64-linux.tgz
PKG_SOURCE_URL:=https://bintray.com/ookla/download/download_file?file_path=
PKG_HASH:=5fe2028f0d4427e4f4231d9f9cf70e6691bb890a70636d75232fe4d970633168

include $(INCLUDE_DIR)/package.mk

define Package/ookla-speedtest
	SECTION=:net
 	CATEGORY:=Network
	TITLE:=Ookla Speedtest CLI
  	URL:=https://www.speedtest.net/apps/cli
endef

define Package/speedtest-cli/description
Speedtest CLI brings the trusted technology and global server network behind
Speedtest to the command line. Built for software developers, system
administrators and computer enthusiasts alike, Speedtest CLI is the first
official Linux-native Speedtest application backed by Ookla.
endef

define Build/Prepare
	$(Build/Prepare/Default)
endef

define Build/Compile
endef

define Package/ookla-speedtest/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(BUILD_DIR)/speedtest $(1)/usr/bin/speedtest
endef

$(eval $(call BuildPackage,ookla-speedtest))


include $(TOPDIR)/rules.mk

PKG_NAME:=eap_proxy
PKG_VERSION:=0.190918
PKG_RELEASE:=2
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/jaysoffian/eap_proxy.git
PKG_SOURCE_VERSION:=44af03d171e88a44c4ddc040b03f22054110f3bb
PKG_SOURCE_DATE:=2019-09-18
PKG_MIRROR_HASH:=426ad42f3edb96565ad98961dd2b34d971ad3cfe5214e77644dc1e04d193abbe

include $(INCLUDE_DIR)/package.mk

define Package/eap_proxy
	SECTION=:net
 	CATEGORY:=Network
	TITLE:=Proxy EAP packets between interfaces
  	URL:=https://github.com/jaysoffian/eap_proxy
	DEPENDS:=+python3-ctypes +python3-logging
	PKGARCH:=all
endef

define Package/eap_proxy/description
Daemon written python to proxy EAP Authentication packets

endef

define Package/eap_proxy/conffiles
/etc/config/eap_proxy
endef

define Build/Prepare
	$(Build/Prepare/Default)
endef

define Build/Configure
	sed -i 's,!/usr/bin/env python,!/usr/bin/env python3,' $(PKG_BUILD_DIR)/eap_proxy.py
endef

define Build/Compile
endef

define Package/eap_proxy/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/eap_proxy.init $(1)/etc/init.d/eap_proxy

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/eap_proxy.conf $(1)/etc/config/eap_proxy

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/eap_proxy.py $(1)/usr/bin/eap_proxy
endef

$(eval $(call BuildPackage,eap_proxy))


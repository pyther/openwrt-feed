include $(TOPDIR)/rules.mk

PKG_NAME:=goeap_proxy
PKG_VERSION:=0.200502.3
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/pyther/goeap_proxy.git
PKG_SOURCE_VERSION:=64e8b890bd1457d1d067d60f549616821675663b
PKG_SOURCE_DATE:=2020-05-02
PKG_MIRROR_HASH:=skip

GO_PKG:=github.com/pyther/goeap_proxy

include $(INCLUDE_DIR)/package.mk
include ../../../../feeds/packages/lang/golang/golang-package.mk

define Package/goeap_proxy
	SECTION=:net
 	CATEGORY:=Network
	TITLE:=Proxy EAP packets between interfaces
  	URL:=https://github.com/pyther/goeap_proxy
	DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/goeap_proxy/description
Daemon written python to proxy EAP Authentication packets

endef

define Package/goeap_proxy/conffiles
/etc/config/goeap_proxy
endef

define Package/goeap_proxy/install
	$(call GoPackage/Package/Install/Bin,$(1))
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/goeap_proxy $(1)/etc/init.d/goeap_proxy

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/goeap_proxy $(1)/etc/config/goeap_proxy
endef

$(eval $(call GoBinPackage,goeap_proxy))
$(eval $(call BuildPackage,goeap_proxy))


include $(TOPDIR)/rules.mk

PKG_NAME:=jq
PKG_VERSION:=1.5
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/stedolan/jq/releases/download/jq-$(PKG_VERSION)/
PKG_MD5SUM:=0933532b086bd8b6a41c1b162b1731f9
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/jq
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Lightweight and flexible command-line JSON processor
	URL:=https://stedolan.github.io/jq/
	MAINTAINER:=Luke Street <luke.street@encounterpc.com>
endef

define Package/jq/description
 jq is like sed for JSON data – you can use it to slice
 and filter and map and transform structured data with
 the same ease that sed, awk, grep and friends let you
 play with text.
endef

CONFIGURE_ARGS += \
	--disable-maintainer-mode

TARGET_CFLAGS += \
	-std=c99

define Package/jq/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/jq $(1)/opt/bin/
endef

$(eval $(call BuildPackage,jq))

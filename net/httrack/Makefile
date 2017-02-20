#
# Copyright (C) 2008-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=httrack
PKG_VERSION:=3.48.22
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL=https://mirror.httrack.com/historical
PKG_MD5SUM:=843ccd49bfef2309b195479cac07d618

PKG_LICENSE:=GPL-3.0+
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=M-C Reid <fyvekatz@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/httrack
  SECTION:=net
  CATEGORY:=Network
  TITLE:=HTTrack is a free and easy-to-use offline browser utility.
  URL:=https://www.httrack.com
  DEPENDS:=+zlib +libopenssl
endef

define Package/httrack/description
  HTTrack is a free and easy-to-use offline browser utility
endef

CONFIGURE_ARGS+=--enable-shared \
                --with-openssl-dir="$(STAGING_DIR)/opt" \
                --with-zlib-dir="$(STAGING_DIR)/opt"
		
define Package/httrack/install
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/.libs/httrack $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/.libs/htsserver $(1)/opt/bin
	$(CP) $(PKG_BUILD_DIR)/src/.libs/lib*.so* $(1)/opt/lib
endef

$(eval $(call BuildPackage,httrack))

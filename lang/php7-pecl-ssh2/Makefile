#
# Copyright (C) 2012-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PECL_NAME:=ssh2
PECL_LONGNAME:=Bindings for the libssh2 library

PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_MD5SUM:=1f84d2d0621933dce06eedeffe54ebd0

PKG_NAME:=php7-pecl-$(PECL_NAME)
PKG_SOURCE:=$(PECL_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=https://pecl.php.net/get/

PKG_MAINTAINER:=Sara Golemon <pollita@php.net> Mike Sullivan <mikesul@php.net> Pierre Joye Casper Langemeijer <langemeijer@php.net>

PKG_LICENSE:=PHPv3.01
PKG_LICENSE_FILES:=

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PECL_NAME)-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include ../php7/pecl.mk

CONFIGURE_ARGS+= --with-ssh2=shared,"$(STAGING_DIR)/opt"

$(eval $(call PECLPackage,$(PECL_NAME),$(PECL_LONGNAME),+libssh2))
$(eval $(call BuildPackage,$(PKG_NAME)))

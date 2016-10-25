#
# Copyright (C) 2012-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PECL_NAME:=msgpack
PECL_LONGNAME:=PHP extension for interfacing with MessagePack

PKG_VERSION:=2.0.1
PKG_RELEASE:=1
PKG_MD5SUM:=4d1db4592ffa4101601aefc794191de5

PKG_NAME:=php7-pecl-$(PECL_NAME)
PKG_SOURCE:=$(PECL_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=https://pecl.php.net/get/

PKG_MAINTAINER:=advect vasquaz <advect@gmail.com> Xinchen Hui <laruence@php.net>

PKG_LICENSE:=New BSD
PKG_LICENSE_FILES:=

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PECL_NAME)-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include ../php7/pecl.mk

$(eval $(call PECLPackage,$(PECL_NAME),$(PECL_LONGNAME),))
$(eval $(call BuildPackage,$(PKG_NAME)))

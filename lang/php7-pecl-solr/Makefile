#
# Copyright (C) 2012-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PECL_NAME:=solr
PECL_LONGNAME:=The Apache Solr PHP extension

PKG_VERSION:=2.4.0
PKG_RELEASE:=1
PKG_MD5SUM:=2c9accf66681a3daaaf371bc07e44902

PKG_NAME:=php7-pecl-$(PECL_NAME)
PKG_SOURCE:=$(PECL_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=https://pecl.php.net/get/

PKG_MAINTAINER:=Omar Shaban <omars@php.net> (lead), Nick Wallace <fyb3roptik@php.net> (developer)

PKG_LICENSE:=PHPv3.01
PKG_LICENSE_FILES:=

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PECL_NAME)-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
include ../php7/pecl.mk

CONFIGURE_ARGS+= --with-curl=shared,"$(STAGING_DIR)/opt" --with-libxml-dir=shared, "$(STAGING_DIR)/opt/include/libxml2" ac_cv_php_xml2_config_path="$(STAGING_DIR)/host/bin/xml2-config"

$(eval $(call PECLPackage,$(PECL_NAME),$(PECL_LONGNAME),+libcurl +libxml2))
$(eval $(call BuildPackage,$(PKG_NAME)))

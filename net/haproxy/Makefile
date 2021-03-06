#
# Copyright (C) 2010-2016 OpenWrt.org
# Copyright (C) 2009-2016 Thomas Heil <heil@terminal-consulting.de>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Downgraded from 1.7.2.The newer haproxy versions enable extra openssl compile flags
# USE_GETADDRINFO=1 option added

include $(TOPDIR)/rules.mk

PKG_NAME:=haproxy
PKG_VERSION:=1.7.9
PKG_RELEASE:=02

PKG_SOURCE:=haproxy-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.haproxy.org/download/1.7/src/
PKG_HASH:=1072337e54fa188dc6e0cfe3ba4c2200b07082e321cbfe5a0882d85d54db068e

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)
PKG_LICENSE:=GPL-2.0
MAINTAINER:=Thomas Heil <heil@terminal-consulting.de>

include $(INCLUDE_DIR)/package.mk

define Package/haproxy/Default
  SUBMENU:=Web Servers/Proxies
  SECTION:=net
  CATEGORY:=Network
  TITLE:=The Reliable, High Performance TCP/HTTP Load Balancer
  URL:=http://haproxy.1wt.eu/
endef

define Download/lua534
	FILE:=lua-5.3.4.tar.gz
	URL:=http://www.lua.org/ftp/
	HASH:=f681aa518233bc407e23acf0f5887c884f17436f000d453b2491a9f11a52400c
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifeq ($(ENABLE_LUA),y)
	tar -zxvf $(DL_DIR)/lua-5.3.4.tar.gz -C $(PKG_BUILD_DIR)
	ln -s $(PKG_BUILD_DIR)/lua-5.3.4 $(PKG_BUILD_DIR)/lua
endif
endef

define Package/haproxy/Default/conffiles
/opt/etc/haproxy.cfg
endef

define Package/haproxy/Default/description
 Open source Reliable, High Performance TCP/HTTP Load Balancer.
endef

define Package/haproxy
  DEPENDS+= +libpcre +libltdl +zlib +libpthread +libopenssl +libncursesw +libreadline +@OPENSSL_WITH_DEPRECATED +@OPENSSL_WITH_EC +@OPENSSL_WITH_EC2M  +@OPENSSL_WITH_DTLS +@OPENSSL_WITH_COMPRESSION +@OPENSSL_WITH_NPN  +@OPENSSL_WITH_PSK +@OPENSSL_WITH_SRP +@OPENSSL_ENGINE_DIGEST +@OPENSSL_ENGINE_CRYPTO

  TITLE+= (with SSL support)
  VARIANT:=ssl
$(call Package/haproxy/Default)
endef

define Package/haproxy/conffiles
$(call Package/haproxy/Default/conffiles)
endef

define Package/haproxy/description
$(call Package/haproxy/Default/description)
 This package is built with SSL and LUA support.
endef

define Package/haproxy/config
	select CONFIG_OPENSSL_WITH_DEPRECATED
	$(call Package/haproxy/Default/config)
endef

define Package/haproxy-nossl
  TITLE+= (without SSL support)
  VARIANT:=nossl
  DEPENDS+= +libpcre +libltdl +zlib +libpthread
  TITLE+= (without SSL support)
$(call Package/haproxy/Default)
endef

define Package/haproxy-nossl/conffiles
$(call Package/haproxy/Default/conffiles)
endef

define Package/haproxy-nossl/description
$(call Package/haproxy/Default/description)
 This package is built without SSL support.
endef

ENABLE_LUA:=y
ifeq ($(CONFIG_mips)$(CONFIG_mipsel),y)
  ENABLE_LUA:=n
endif

ifeq ($(CONFIG_avr32),y)
  LINUX_TARGET:=linux26
else
  LINUX_TARGET:=linux2628
endif

ifeq ($(BUILD_VARIANT),ssl)
	ADDON+=USE_OPENSSL=1
	ADDON+=ADDLIB="-lcrypto -lm "
else ifeq ($(CONFIG_mips)$(CONFIG_mipsel),n)
	ADDON+=USE_LUA=1
	ADDON+=LUA_LIB_NAME="lua534"
	ADDON+=LUA_INC="$(STAGING_DIR)/lua-5.3.4/include"
	ADDON+=LUA_LIB="$(STAGING_DIR)/lua-5.3.4/lib"
else
	ADDON+=ADDLIB="-lm"
endif

ifeq ($(ENABLE_LUA),y)
define Build/Compile/lua
	$(MAKE) TARGET=$(LINUX_TARGET) -C $(PKG_BUILD_DIR)/lua \
		INSTALL_TOP="$(STAGING_DIR)/lua-5.3.4/" \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS) -lncurses -lreadline" \
		LD="$(TARGET_LD)" \
		linux install

	mv $(STAGING_DIR)/lua-5.3.4/lib/liblua.a $(STAGING_DIR)/lua-5.3.4/lib/liblua534.a
endef
endif

define Build/Compile
	$(call Build/Compile/lua)
	$(MAKE) TARGET=$(LINUX_TARGET) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		CC="$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS)" \
		PCREDIR="$(STAGING_DIR)/opt/" \
		SMALL_OPTS="-DBUFSIZE=16384 -DMAXREWRITE=1030 -DSYSTEM_MAXCONN=165530 " \
		USE_LINUX_TPROXY=1 USE_LINUX_SPLICE=1 USE_REGPARM=1 \
		USE_ZLIB=yes USE_PCRE=1 USE_PCRE_JIT=1 USE_GETADDRINFO=1 \
		VERSION="$(PKG_VERSION)-patch$(PKG_RELEASE)" \
		$(ADDON)
		CFLAGS="$(TARGET_CFLAGS) -fno-align-jumps -fno-align-functions -fno-align-labels -fno-align-loops -pipe -fomit-frame-pointer -fhonour-copts" \
		LD="$(TARGET_LD)" \
		LDFLAGS="$(TARGET_LDFLAGS) -lcurses -lreadline" \
		GNOREGIT=1

	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) \
		PREFIX="/opt" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		LD="$(TARGET_CC)" \
                LDFLAGS="$(TARGET_LDFLAGS)" \
		$(MAKE_FLAGS) \
		install

	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR)/contrib/halog \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		$(MAKE_FLAGS) \
		ADDLIB="-lcrypto" \
		VERSION="$(PKG_VERSION)-patch$(PKG_RELEASE)" \
		halog
endef

define Package/haproxy/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/haproxy $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) ./files/haproxy.cfg $(1)/opt/etc/
endef

Package/haproxy-nossl/install = $(Package/haproxy/install)

define Package/halog
	MENU:=1
	$(call Package/haproxy)
	TITLE+= halog
	DEPENDS:=haproxy
endef

define Package/halog/description
	HAProxy Log Analyzer
endef

define Package/halog/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/contrib/halog/halog $(1)/opt/bin/
endef

$(eval $(call Download,lua534))
$(eval $(call BuildPackage,haproxy))
$(eval $(call BuildPackage,halog))
$(eval $(call BuildPackage,haproxy-nossl))

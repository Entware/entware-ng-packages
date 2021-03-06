#
# Copyright (C) 2006-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=node
PKG_VERSION:=v6.11.2
PKG_RELEASE:=3
PKG_SOURCE:=node-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://nodejs.org/dist/${PKG_VERSION}
PKG_HASH:=04af4992238b19124ea56f1bcfda36827613a24eb3b00fc3b50f261a415a26e4

HOST_BUILD_DEPENDS:=python/host
PKG_BUILD_DEPENDS:=python/host

PKG_INSTALL:=1
PKG_USE_MIPS16:=0

HOST_BUILD_PARALLEL:=1
PKG_BUILD_PARALLEL:=1

PKG_MAINTAINER:=John Crispin <blogic@openwrt.org>, Adrian Panella <ianchi74@outlook.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk

define Package/node
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Node.js
  TITLE:=Node.js is a platform built on Chrome's JavaScript runtime
  URL:=http://nodejs.org/
  DEPENDS:=+libstdcpp +libopenssl +zlib +USE_UCLIBC:libpthread +USE_UCLIBC:librt +NODEJS_ICU:icu +libuv @!TARGET_armv5soft
endef

define Package/node/description
  Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine. Node.js uses
  an event-driven, non-blocking I/O model that makes it lightweight and efficient. Node.js'
   package ecosystem, npm, is the largest ecosystem of open source libraries in the world.
endef

define Package/node-npm
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Node.js
  TITLE:=NPM stands for Node Package Manager
  URL:=http://npmjs.com/
  DEPENDS:=+node
endef

define Package/node-npm/description
	NPM is the package manager for NodeJS
endef

define Package/node/config
	menu "Module Selection"

	config NODEJS_ICU
		bool "enable i18n features"
		default n

	endmenu
endef

NODEJS_CPU:=$(subst powerpc,ppc,$(subst aarch64,arm64,$(subst x86_64,x64,$(subst i386,ia32,$(ARCH)))))

MAKE_VARS+= \
	DESTCPU=$(NODEJS_CPU)

CONFIGURE_ARGS:= \
	--dest-cpu=$(NODEJS_CPU) \
	--dest-os=linux \
	--without-snapshot \
	--shared-zlib \
	--shared-openssl \
	--prefix=/opt

ifneq ($(findstring arm,$(NODEJS_CPU)),)
ifeq ($(CONFIG_SOFT_FLOAT),y)
CONFIGURE_ARGS+= --with-arm-float-abi=softfp
else

CONFIGURE_ARGS+= --with-arm-float-abi=hard

ifneq ($(findstring vfp,$(CONFIG_CPU_TYPE)),)
ARM_FPU=vfp
endif

ifneq ($(findstring vfpv3,$(CONFIG_CPU_TYPE)),)
ARM_FPU=vfpv3
endif

ifneq ($(findstring vfpv3-d16,$(CONFIG_CPU_TYPE)),)
ARM_FPU=vfpv3-d16
endif

ifneq ($(findstring neon,$(CONFIG_CPU_TYPE)),)
ARM_FPU=neon
endif

CONFIGURE_ARGS+= --with-arm-fpu=$(ARM_FPU)
endif
endif

ifneq ($(findstring mips,$(NODEJS_CPU)),)
ifeq ($(CONFIG_SOFT_FLOAT),y)
CONFIGURE_ARGS+= \
	--with-mips-float-abi=soft
endif
endif

ifeq ($(CONFIG_NODEJS_ICU),y)
CONFIGURE_ARGS+= \
	--with-intl=system-icu
else
CONFIGURE_ARGS+= \
	--with-intl=none
endif

HOST_CONFIGURE_VARS:=

HOST_CONFIGURE_ARGS:= \
	--dest-os=linux \
	--without-snapshot \
	--shared-zlib \
	--prefix=$(STAGING_DIR_HOSTPKG)

HOST_CONFIGURE_CMD:=python ./configure

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/* $(1)/opt/include/
endef

define Package/node/install
	mkdir -p $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/node $(1)/opt/bin/
endef

define Package/node-npm/install
	mkdir -p $(1)/opt/bin $(1)/opt/lib/node_modules/npm/{bin,lib,node_modules}
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/npm $(1)/opt/bin/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/node_modules/npm/{package.json,LICENSE,cli.js} $(1)/opt/lib/node_modules/npm
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/node_modules/npm/bin/npm-cli.js $(1)/opt/lib/node_modules/npm/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/node_modules/npm/lib/* $(1)/opt/lib/node_modules/npm/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/node_modules/npm/node_modules/* $(1)/opt/lib/node_modules/npm/node_modules/
	$(SED) 's,/usr/bin/env node,/opt/bin/node,g' $(1)/opt/lib/node_modules/npm/cli.js
	$(SED) 's,/usr/bin/env node,/opt/bin/node,g' $(1)/opt/lib/node_modules/npm/bin/npm-cli.js
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,node))
$(eval $(call BuildPackage,node-npm))

#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Package/php7-pecl/Default
  SUBMENU:=PHP
  SECTION:=lang
  CATEGORY:=Languages
  URL:=http://pecl.php.net/
  DEPENDS:=php7
endef

define Build/Prepare
	$(Build/Prepare/Default)
	( cd $(PKG_BUILD_DIR); $(STAGING_DIR)/host/opt/bin/phpize7 )
endef

CONFIGURE_ARGS+= \
	--with-php-config=$(STAGING_DIR)/host/opt/bin/php7-config

define PECLPackage

  define Package/php7-pecl-$(1)
    $(call Package/php7-pecl/Default)
    TITLE:=$(2)

    ifneq ($(3),)
      DEPENDS+=$(3)
    endif
  endef

  define Package/php7-pecl-$(1)/install
	$(INSTALL_DIR) $$(1)/opt/lib/php7
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modules/$(subst -,_,$(1)).so $$(1)/opt/lib/php7/
	$(INSTALL_DIR) $$(1)/opt/etc/php7
    ifeq ($(5),zend)
	echo "zend_extension=/opt/lib/php7/$(subst -,_,$(1)).so" > $$(1)/opt/etc/php7/$(if $(4),$(4),20)_$(subst -,_,$(1)).ini
    else
	echo "extension=$(subst -,_,$(1)).so" > $$(1)/opt/etc/php7/$(if $(4),$(4),20)_$(subst -,_,$(1)).ini
    endif
  endef

endef

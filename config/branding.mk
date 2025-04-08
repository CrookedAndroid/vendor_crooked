#
# Copyright (C) 2018-2024 StatiXOS
#
# SPDX-License-Identifier: Apache-2.0
#

CROOKED_DEVICE := $(patsubst %f,%,$(subst crooked_,,$(TARGET_PRODUCT)))

# Set date and time
BUILD_DATE := $(shell date +%Y%m%d)
BUILD_TIME := $(shell date +%H%M)

## Versioning System
# Set all versions
CROOKED_BASE_NAME := CrookedAndroid
CROOKED_BASE_VERSION := 6.2
CROOKED_PLATFORM_VERSION := $(PLATFORM_VERSION)

ifndef CROOKED_BUILD_TYPE
    CROOKED_BUILD_TYPE := UNOFFICIAL
endif

CROOKED_VERSION := $(TARGET_PRODUCT)-$(BUILD_DATE)-$(CROOKED_PLATFORM_VERSION)-$(CROOKED_BASE_VERSION)-$(CROOKED_BUILD_TYPE)

# Fingerprint
ROM_FINGERPRINT := CrookedAndroid/$(PLATFORM_VERSION)/$(STATIX_BUILD_TYPE)/$(BUILD_DATE)
# Declare it's a StatiX build
CROOKED_BUILD := true

# CrookedAndroid version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.crooked.version=$(CROOKED_BASE_VERSION)-$(CROOKED_BUILD_TYPE)-$(BUILD_DATE) \
    ro.crooked.base.version=$(CROOKED_BASE_VERSION) \
    ro.mod.version=$(BUILD_ID)-$(BUILD_DATE)-$(CROOKED_BASE_VERSION) \
    ro.crooked.fingerprint=$(ROM_FINGERPRINT) \
    ro.crooked.buildtype=$(CROOKED_BUILD_TYPE)

## Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
    # Define security directory
    PROD_CERTS := vendor/crooked/build/target/product/security

    # Display a cleaner build number even on userdebug builds
    ifeq (userdebug,$(TARGET_BUILD_VARIANT))
        DISPLAY_ID := $(BUILD_ID)-$(TARGET_BUILD_VARIANT) $(BUILD_KEYS)
    else
        DISPLAY_ID := $(BUILD_ID) $(BUILD_KEYS)
    endif

    # Release keys
    ifneq (,$(wildcard $(PROD_CERTS)/releasekey.pk8))
        PRODUCT_DEFAULT_DEV_CERTIFICATE := $(PROD_CERTS)/releasekey
        # OEM unlock
        PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
        # Strip build keys info from display ID
        ifeq (userdebug,$(TARGET_BUILD_VARIANT))
            DISPLAY_ID := $(BUILD_ID)-$(TARGET_BUILD_VARIANT)
        else
            DISPLAY_ID := $(BUILD_ID)
        endif
    endif

    # Override display ID with the final value
    PRODUCT_BUILD_PROP_OVERRIDES += BuildDisplayId="$(DISPLAY_ID)"
    ifeq (userdebug,$(TARGET_BUILD_VARIANT))
        PRODUCT_BUILD_PROP_OVERRIDES += BuildDescOverride="$(DISPLAY_ID)"
    endif

    # OTA keys
    ifneq (,$(wildcard $(PROD_CERTS)/otakey.x509.pem))
        PRODUCT_OTA_PUBLIC_KEYS := $(PROD_CERTS)/otakey.x509.pem
    endif
endif

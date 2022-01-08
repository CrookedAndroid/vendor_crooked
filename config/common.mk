include vendor/crooked/build/core/vendor/*.mk

ifeq ($(PRODUCT_USES_QCOM_HARDWARE), true)
include vendor/crooked/build/core/ProductConfigQcom.mk
endif

$(call inherit-product, vendor/qcom/opensource/power/power-vendor-board.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifeq ($(TARGET_USES_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.build.selinux=1

# copy privapp permissions
PRODUCT_COPY_FILES += \
    vendor/crooked/prebuilt/common/etc/permissions/privapp-permissions-crooked-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-crooked-product.xml \
    vendor/crooked/prebuilt/common/etc/permissions/privapp-permissions-crooked-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-crooked-system.xml \
    vendor/crooked/prebuilt/common/etc/permissions/privapp-permissions-crooked-se.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-crooked-se.xml


PRODUCT_COPY_FILES += \
    vendor/crooked/prebuilt/common/etc/sysconfig/quick_tap.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/quick_tap.xml

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# IORap app launch prefetching using Perfetto traces and madvise
PRODUCT_PRODUCT_PROPERTIES += \
    ro.iorapd.enable=true

# Crooked-specific init file
PRODUCT_COPY_FILES += \
    vendor/crooked/prebuilt/common/etc/init.crooked.rc:system/etc/init/init.crooked.rc

# Sysconfig
PRODUCT_COPY_FILES += \
    vendor/crooked/prebuilt/common/etc/sysconfig/game_overlay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/game_overlay.xml

# Build ID
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_DISPLAY_ID="$(BUILD_ID)-$(TARGET_BUILD_VARIANT)"

# Packages
include vendor/crooked/config/packages.mk

# Branding
include vendor/crooked/config/branding.mk

# Bootanimation
include vendor/crooked/config/bootanimation.mk

# Fonts
include vendor/crooked/config/fonts.mk

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/crooked/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/crooked/overlay/common

# Black Themes
PRODUCT_PACKAGES += \
    AndroidBlackThemeOverlay

# Face Unlock
PRODUCT_PACKAGES += \
    FaceUnlockService
    
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=true
    
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml

# Artifact path requirements
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/etc/init/init.crooked.rc \
    system/etc/permissions/privapp-permissions-crooked-system.xml \
    system/lib/libRSSupport.so \
    system/lib/libblasV8.so \
    system/lib/librsjni.so \
    system/lib64/libRSSupport.so \
    system/lib64/libblasV8.so \
    system/etc/permissions/android.hardware.biometrics.face.xml \
    system/etc/permissions/privapp-permissions-com.crdroid.faceunlock.xml \
    system/etc/sysconfig/hiddenapi-whitelist-com.crdroid.faceunlock.xml \
    system/lib64/faceunlock_vendor_dependencies.so \
    system/lib64/libFaceDetectCA.so \
    system/lib64/libMegviiUnlock-jni-1.2.so \
    system/lib64/libMegviiUnlock.so \
    system/lib64/libarcsoft-lib.so \
    system/lib64/libarcsoft_faceid.so \
    system/lib64/libarcsoftbase.so \
    system/lib64/libmegface.so \
    system/lib64/libmpbase.so \
    system/priv-app/FaceUnlockService/FaceUnlockService.apk \
    system/lib64/librsjni.so

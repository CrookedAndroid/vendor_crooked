# Pixel APNs
PRODUCT_COPY_FILES += \
    vendor/crooked/telephony/apns-full-conf.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/apns-conf.xml

# SIM Toolkit
PRODUCT_PACKAGES += \
    messaging \
    Stk \
    CellBroadcastReceiver

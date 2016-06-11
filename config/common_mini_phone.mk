# Inherit common vu stuff
$(call inherit-product, vendor/vu/config/common.mk)

# Include CM audio files
include vendor/vu/config/cm_audio.mk

# Required vu packages
PRODUCT_PACKAGES += \
    LatinIME

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/vu/prebuilt/common/bootanimation/320.zip:system/media/bootanimation.zip
endif

$(call inherit-product, vendor/vu/config/telephony.mk)

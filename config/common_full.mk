# Inherit common CM stuff
$(call inherit-product, vendor/vu/config/common.mk)

# Include CM audio files
include vendor/vu/config/cm_audio.mk

# Optional CM packages
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    PhotoTable \
    SoundRecorder \
    PhotoPhase

# Extra tools in CM
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip

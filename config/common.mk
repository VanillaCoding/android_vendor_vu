PRODUCT_BRAND ?= vanilla-unicorn

PRODUCT_BOOTANIMATION := vendor/vu/prebuilt/common/bootanimation/bootanim.zip

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/vu/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/vu/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/vu/prebuilt/common/bin/50-vu.sh:system/addon.d/50-vu.sh \
    vendor/vu/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/vu/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/vu/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/vu/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/vu/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/vu/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# VanillaUnicorn-specific init file
PRODUCT_COPY_FILES += \
    vendor/vu/prebuilt/common/etc/init.local.rc:root/init.vu.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/vu/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is VanillaUnicorn (CM / CAF)!
PRODUCT_COPY_FILES += \
    vendor/vu/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# T-Mobile theme engine
include vendor/vu/config/themes_common.mk

# CMSDK
include vendor/vu/config/cmsdk_common.mk

# Required VanillaUnicorn packages
PRODUCT_PACKAGES += \
    Development \
    BluetoothExt \
    Profiles

# Optional VanillaUnicorn packages
PRODUCT_PACKAGES += \
    libemoji \
    Terminal

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# Custom CM packages
PRODUCT_PACKAGES += \
    Launcher3 \
    Trebuchet \
    AudioFX \
    CMWallpapers \
    CMFileManager \
    Eleven \
    LockClock \
    CMAccount \
    CyanogenSetupWizard \
    CMSettingsProvider \
    ExactCalculator \
    LiveLockScreenService \
    WeatherProvider \
    DataUsageProvider \
    WallpaperPicker

# Custom VU packages
PRODUCT_PACKAGES += \
    VUPapers

# Extra tools in VU
PRODUCT_PACKAGES += \
    libsepol \
    mke2fs \
    tune2fs \
    bash \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    ntfsfix \
    ntfs-3g \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# TCM (TCP Connection Management)
PRODUCT_PACKAGES += \
    tcmiface

PRODUCT_BOOT_JARS += \
    tcmiface

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank \
    su
endif

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

DEVICE_PACKAGE_OVERLAYS += vendor/vu/overlay/common

# vanilla unicorn version
VU_RELEASE = false
VU_VERSION_MAJOR = 2
VU_VERSION_MINOR = 0

# Release
ifeq ($(VU_RELEASE),true)
    VU_VERSION := vu-$(VU_VERSION_MAJOR).$(VU_VERSION_MINOR)-$MILESTONE-$(shell date -u +%Y%m%d)-$(VU_BUILD)
else
    VU_VERSION := vu-$(VU_VERSION_MAJOR).$(VU_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(VU_BUILD)
endif

VU_DISPLAY_VERSION := $(VU_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.vu.version=$(VU_VERSION) \
  ro.modversion=$(VU_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.vu.display.version=$(VU_DISPLAY_VERSION)

-include vendor/vu-priv/keys/keys.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk

-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)

DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8909/overlay

TARGET_USES_QCOM_BSP := true
ifeq ($(TARGET_PRODUCT),msm8909)
TARGET_USES_QCA_NFC := true
endif
ifeq ($(TARGET_USES_QCOM_BSP), true)
# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
endif #TARGET_USES_QCOM_BSP


#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := msm8909
PRODUCT_DEVICE := msm8909

ifeq ($(strip $(TARGET_USES_QTIC)),true)
# font rendering engine feature switch
-include $(QCPATH)/common/config/rendering-engine.mk
ifneq (,$(strip $(wildcard $(PRODUCT_RENDERING_ENGINE_REVLIB))))
    MULTI_LANG_ENGINE := REVERIE
endif
endif

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# NFC packages
ifeq ($(TARGET_USES_QCA_NFC),true)
NFC_D := true

ifeq ($(NFC_D), true)
    PRODUCT_PACKAGES += \
        libnfcD-nci \
        libnfcD_nci_jni \
        nfc_nci.msm8916 \
        NfcDNci \
        Tag \
        com.android.nfc_extras \
        com.android.nfc.helper \
        SmartcardService \
        org.simalliance.openmobileapi \
        org.simalliance.openmobileapi.xml \
        libassd
else
    PRODUCT_PACKAGES += \
    libnfc-nci \
    libnfc_nci_jni \
    nfc_nci.msm8916 \
    NfcNci \
    Tag \
    com.android.nfc_extras
endif

# file that declares the MIFARE NFC constant
# Commands to migrate prefs from com.android.nfc3 to com.android.nfc
# NFC access control + feature files + configuration
PRODUCT_COPY_FILES += \
        packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
        frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
        frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
        frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
        frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml
# Enable NFC Forum testing by temporarily changing the PRODUCT_BOOT_JARS
# line has to be in sync with build/target/product/core_base.mk
endif # TARGET_USES_QCA_NFC

PRODUCT_BOOT_JARS += qcmediaplayer \
                     WfdCommon \
                     oem-services \
                     qcom.fmradio \
                     org.codeaurora.Performance \
                     vcard \
                     tcmiface

# Feature definition files for msm8909
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcompostprocbundle \
    libqcomvoiceprocessing

#OEM Services library
PRODUCT_PACKAGES += oem-services
PRODUCT_PACKAGES += libsubsystem_control
PRODUCT_PACKAGES += libSubSystemShutdown

PRODUCT_PACKAGES += wcnss_service

#ANT+ stack
PRODUCT_PACKAGES += \
AntHalService \
libantradio \
antradio_app

# Defined the locales
PRODUCT_LOCALES += th_TH vi_VN tl_PH hi_IN ar_EG ru_RU tr_TR pt_BR bn_IN mr_IN ta_IN te_IN zh_HK \
        in_ID my_MM km_KH sw_KE uk_UA pl_PL sr_RS sl_SI fa_IR kn_IN ml_IN ur_IN gu_IN or_IN en_ZA

# Add the overlay path
PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res-overlay \
        $(QCPATH)/qrdplus/globalization/multi-language/res-overlay \
        $(PRODUCT_PACKAGE_OVERLAYS)

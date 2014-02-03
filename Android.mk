# This flag will be set to true during migration to Snapdragon Display Engine.
TARGET_USES_SDE = false

ifeq ($(TARGET_USES_SDE), true)
display-hals := libgralloc libcopybit liblight libmemtrack

ifeq ($(TARGET_USES_SDE), true)
    sde-libs := displayengine/libs
    display-hals += $(sde-libs)/utils $(sde-libs)/core $(sde-libs)/hwc
else
    display-hals += libgenlock libhwcomposer liboverlay libqdutils libhdmi
    display-hals += libqservice
endif
else
ifeq ($(TARGET_QCOM_DISPLAY_VARIANT),caf-bfam)
display-hals := libgralloc libgenlock libcopybit libmemtrack
display-hals += libhwcomposer liboverlay libqdutils libhdmi libqservice
ifneq ($(TARGET_PROVIDES_LIBLIGHT),true)
display-hals += liblight
endif
endif
ifeq ($(call is-vendor-board-platform,QCOM),true)
    include $(call all-named-subdir-makefiles,$(display-hals))
else
ifneq ($(filter msm% apq%,$(TARGET_BOARD_PLATFORM)),)
    include $(call all-named-subdir-makefiles,$(display-hals))
endif
endif
endif

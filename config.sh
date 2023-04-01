#!/bin/bash

# Device
export SHRP_MANIFEST="https://github.com/SHRP/manifest.git"
export SHRP_BRANCH="omni-9.0"
export DT_LINK="https://github.com/SHRP-Devices/device_xiaomi_whyred -b omni-9.0"

export DEVICE="whyred"
export OEM="xiaomi"
#export PLATFORM="msm8998"
export TARGET="recoveryimage"

export OUTPUT="SHRP_v*.zip"
export ADDON="SHRP_A*.zip"

# Kernel Source
# Uncomment the next line if you want to clone a kernel source.
#export KERNEL_SOURCE="https://github.com/faoliveira78/android_kernel_oneplus_msm8998"

# Extra Command
export EXTRA_CMD=""

# Not Recommended to Change
if [ ! -e $HOME/work ]; then
mkdir $HOME/work
fi

export SYNC_PATH="$HOME/work" # Full (absolute) path.

export J_VAL=16

if [ ! -z "$PLATFORM" ]; then
    export KERNEL_PATH="kernel/$OEM/$PLATFORM"
else
    export KERNEL_PATH="kernel/$OEM/$DEVICE"
fi
export DT_PATH="device/$OEM/$DEVICE"

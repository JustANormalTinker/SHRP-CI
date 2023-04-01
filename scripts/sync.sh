#!/bin/bash

# Source Vars
source $CONFIG

# Change to the Home Directory
cd ~

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Clone the Sync Repo
cd $SYNC_PATH
repo init https://github.com/SHRP/manifest.git -c --depth=1
repo sync

# Clone Trees
git clone $DT_LINK $DT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }

# Clone the Kernel Sources
# only if the Kernel Source is Specified in the Config
[ ! -z "$KERNEL_SOURCE" ] && git clone --depth=1 --single-branch $KERNEL_SOURCE $KERNEL_PATH

# Cherry-pick gerrit patches
if [ "$SHRP_BRANCH" = "shrp-12.1" ]; then

  git -C bootable/recovery fetch https://gerrit.twrp.me/android_bootable_recovery refs/changes/17/5917/2 && git -C bootable/recovery cherry-pick FETCH_HEAD
	git -C bootable/recovery fetch https://gerrit.twrp.me/android_bootable_recovery refs/changes/06/6106/1 && git -C bootable/recovery cherry-pick FETCH_HEAD
	git -C bootable/recovery fetch https://gerrit.twrp.me/android_bootable_recovery refs/changes/20/6120/1 && git -C bootable/recovery cherry-pick FETCH_HEAD

fi

# Exit
exit 0

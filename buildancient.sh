#!/bin/bash
#set -e

rund="$(pwd)"
para="$(nproc)"

if [ ! "$1" ]; then
	echo "set build directory"
	exit
fi

pushd "$1"

repo init -u repo init -u https://github.com/Ancient-Roms/manifest -b eleven
repo sync -j${para} -c -q --force-sync --no-tags --no-clone-bundle --optimized-fetch --prune ||exit
bash ${rund}/apply-patches.sh ${rund}
cd device/phh/treble
bash generate.sh ancient
cd -
. build/envsetup.sh
lunch treble_arm64_bvS-userdebug
make -j${para} systemimage

#!/bin/bash
# ###########################################################
# mksplash.sh
# ver. 0.1-alpha
# Lenovo K30-T / A6000 / Kraft-A6000 Custom splash maker 
# by K Janus Yacinthus - janusyacinthus@mail.com -
# ###########################################################
# Required installed packages
# - ffmpeg
# # ###########################################################
# TODO
# ###########################################################
# CHANGELOG
# 0.1-alpha 18 Oct 2018 
#############################################################
# The vars
FULLNAME="Lenovo K30-T / A6000 / Kraft-A6000 Custom splash maker"
AUTHOR="K Janus Yacinthus - janusyacinthus@mail.com"
NAME="mksplash"
VERSION="0.1-alpha"
FFMPEG=`which ffmpeg`
RES=720x1280
# The subs
banner() {
	echo "======================================================"
	echo "$FULLNAME a.k.a $NAME"
	echo "Version $VERSION"
	echo "By $AUTHOR"
	echo "======================================================"
}
usage() {
	echo "Usage:"
	echo "
		1. Copy your 2 files <logo.png> and/or <fastboot.png> in the pict/ folder
		2. Run the script $NAME 
		"
}
# Main
# Do we have ffmpeg installed ?
if [ ! $FFMPEG ]; then
	banner
	echo "FFmpeg package seems to be missing."
	echo "Please install ffmpeg to continue."
	echo "[!!] ffmpeg not found! Exiting..."
	exit
else 
	echo "[+] Converting pictures to 720x1280 RAW"
	echo "[+] Creating Logo..."
	rm -fv out/logo.raw
	ffmpeg -hide_banner -loglevel quiet -i pict/logo.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -s $RES out/logo.raw
	echo "[+] Creating Fastboot..."
	rm -fv out/fastboot.raw
	ffmpeg -hide_banner -loglevel quiet -i pict/fastboot.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -s $RES out/fastboot.raw
	echo "[+] Generating flashable img in out/splash.img"
	rm -fv out/splash.img
	cat lib/header.img out/logo.raw lib/header.img out/fastboot.raw > out/splash.img
	echo "[+] Done. You can now fastboot flash splash splash.img"

fi
# EOF

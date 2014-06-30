#!/bin/bash
PACKAGENAME="play-movie"
MAINTAINER="Oskar Holowaty <me@oskarholowaty.com>"
VENDOR="Oskar Holowaty <me@oskarholowaty.com>"
VERSION="0.2"
URL="https://github.com/bullshit/play-movie"
LICENSE=""
DESCRIPTION="Install a video downloader and play it with omxplayer"

#TODO sed version number in changelog and setup.sh

ROOT=`pwd`

cd ./src
fpm -f -s dir -t deb -a all \
	-n "$PACKAGENAME" \
	-m "$MAINTAINER" \
	-d "wget" \
	-d "omxplayer" \
	-d "python" \
	-d "python-configobj" \
	--vendor "$VENDOR" \
	--category "misc" \
	--license "$LICENSE" \
	--url $URL \
	--description "$DESCRIPTION" \
	--after-install "${ROOT}/debian/install.sh" \
	--post-uninstall "${ROOT}/debian/uninstall.sh" \
	-v "$VERSION" \
	-p "${ROOT}/${PACKAGENAME}_${VERSION}_all.deb" \
	--config-files "/etc/" \
	--deb-changelog "${ROOT}/debian/changelog" \
	--deb-compression "xz" \
	.
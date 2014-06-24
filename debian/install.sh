#!/bin/sh
# postinst script for lxcu-repo
#
# see: dh_installdeb(1)

set -e

# summary of how this script can be called:
#        * <postinst> `configure' <most-recently-configured-version>
#        * <old-postinst> `abort-upgrade' <new version>
#        * <conflictor's-postinst> `abort-remove' `in-favour' <package>
#          <new-version>
#        * <postinst> `abort-remove'
#        * <deconfigured's-postinst> `abort-deconfigure' `in-favour'
#          <failed-install-package> <version> `removing'
#          <conflicting-package> <version>
# for details, see http://www.debian.org/doc/debian-policy/ or
# the debian-policy package

# source debconf library
. /usr/share/debconf/confmodule

case "$1" in

  configure)
	echo "Please add a cronjob"
	echo ""
	echo "crontab -e"
	echo "add following command"
	echo "*/5 * * * * /opt/play-movie/cronjob.sh"
	echo ""
	echo "add the playback script to rc.local"
	echo "nohup /opt/play-movie/playback.sh &"
	echo ""
  ;;

  abort-upgrade|abort-remove|abort-deconfigure)
    exit 0
  ;;

  *)
    echo "postinst called with unknown argument \`$1'" >&2
    exit 1
  ;;

esac

exit 0
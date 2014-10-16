#!/bin/sh

### BEGIN INIT INFO
# Provides:          banchanggo
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the banchanggo server
# Description:       starts banchanggo using start-stop-daemon
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/home/foobargem/sbin/banchanggo
NAME=banchanggo
DESC=banchanggo


test -x $DAEMON || exit 0

set -e

. /lib/lsb/init-functions

case "$1" in
	start)
		echo -n "Starting $DESC: "
		start-stop-daemon --start --background --quiet \
		    --make-pidfile --pidfile /var/run/$NAME.pid \
		    --exec $DAEMON -- $DAEMON_OPTS || true
		echo "$NAME."
		;;

	stop)
		echo -n "Stopping $DESC: "
		start-stop-daemon --stop --quiet --pidfile /var/run/$NAME.pid \
		    --exec $DAEMON || true
		echo "$NAME."
		;;

	restart)
		echo -n "Restarting $DESC: "
		start-stop-daemon --stop --quiet --pidfile \
		    /var/run/$NAME.pid --exec $DAEMON || true
		sleep 1

		start-stop-daemon --start --background --quiet \
		    --make-pidfile --pidfile /var/run/$NAME.pid \
		    --exec $DAEMON -- $DAEMON_OPTS || true
		echo "$NAME."
		;;


	status)
		status_of_proc -p /var/run/$NAME.pid "$DAEMON" banchanggo && exit 0 || exit $?
		;;
	*)
		echo "Usage: $NAME {start|stop|restart|status}" >&2
		exit 1
		;;
esac

exit 0

#! /bin/bash
DBUS_ADDRESS=`grep -z DBUS_SESSION_BUS_ADDRESS /proc/*/environ 2> /dev/null| sed 's/DBUS/\nDBUS/g' | tail -n 1`
if [ "x$DBUS_ADDRESS" != "x" ]; then
        export $DBUS_ADDRESS
	echo $DBUS_ADDRESS
        /usr/bin/whoiam -h
fi

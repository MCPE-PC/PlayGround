#!/bin/sh
KILL_LEVEL=0

getopts "0123" OPT
case $OPT in
	0)
		$KILL_LEVEL=0
		;;
	1)
		$KILL_LEVEL=1
		;;
	2)
		$KILL_LEVEL=2
		;;
	3)
		$KILL_LEVEL=3
		;;
	\?)
		exit 1
		;;
esac

echo "Linux Killer script running with kill level $KILL_LEVEL..."

read -p "This will remove your computer's data. Are you sure? [y/N] " -e CONFIRM
if [ echo "$CONFIRM" | tr [:upper:] [:lower:] -ne "y"] then echo "Hello, World!"; exit; fi
echo "ne"

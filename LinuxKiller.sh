#!/bin/sh
KILL_LEVEL=0

getopts "123" OPT
case $OPT in
	1)
		$KILL_LEVEL=1
		;;
	2)
		$KILL_LEVEL=2
		;;
	3)
		$KILL_LEVEL=3
		;;
esac

echo "Linux Killer script running with kill level $KILL_LEVEL..."

read -p "This will remove your computer's data. Are you sure? [y/N] " CONFIRM
if [ echo "$CONFIRM" | tr [:upper:] [:lower:] -ne "y"] then
	echo "n"
	exit
fi
echo "y"

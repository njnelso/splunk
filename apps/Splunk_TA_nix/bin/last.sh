#!/bin/sh
# This script reports the last shutdowns and reboots by system

. `dirname $0`/common.sh

if [ "x$KERNEL" = "xLinux" ] ; then
	CMD='last -x'
	FILTER='{if ($0 == "") exit; if ($1 !~ /reboot|shutdown/) next; }'
	FORMAT='{event = $1; from = $2; version = $(NF-6); date = $(NF-5) " " $(NF-4) " " $(NF-3); status = $(NF-2) " " $(NF-1) print event, from, version, date, status}'
fi

assertHaveCommand $CMD

out=`$CMD | $AWK "$FILTER $FORMAT"`
lines=`echo "$out" | wc -l`
if [ $lines -gt 0 ]; then
	echo "$out"
else
	echo "No data is present" >> $TEE_DEST
fi


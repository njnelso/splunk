#!/bin/sh
# This script reports the last shutdowns and reboots by system

. `dirname $0`/common.sh

HEADER='EVENT                          FROM                            VERSION                       DATE                    STATUS'
HEADERIZE="BEGIN {print \"$HEADER\"}"
PRINTF='{printf "%-30s  %-30s  %-30s  %-s  %-s\n", event, from, version, date, status}'

if [ "x$KERNEL" = "xLinux" ] ; then
	CMD='last -x'  # Changed to last -x
	# Modified filter to include reboot and shutdown
	FILTER='{if ($0 == "") exit; if ($1 !~ /reboot|shutdown/ && !($1 in users)) next; users[$1]=1}'
	# Adjust FORMAT to accurately capture the output structure
	FORMAT='{event = $1; from = $2; version = $(NF-6); date = $(NF-5) " " $(NF-4) " " $(NF-3); status = $(NF-2) " " $(NF-1)}'
fi

assertHaveCommand $CMD

out=`$CMD | tee $TEE_DEST | $AWK "$HEADERIZE $FILTER $FORMAT $PRINTF"  header="$HEADER"`
lines=`echo "$out" | wc -l`
if [ $lines -gt 1 ]; then
	echo "$out"
	echo "Cmd = [$CMD];  | $AWK '$HEADERIZE $FILTER $FORMAT $PRINTF' header=\"$HEADER\"" >> $TEE_DEST
else
	echo "No data is present" >> $TEE_DEST
fi


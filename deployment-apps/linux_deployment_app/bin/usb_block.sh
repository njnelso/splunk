#!/bin/sh
#
# This script will scan /etc/nsswitch.conf file which should be common in both
# Linux and Solaris systems.
# Output should be e

. `dirname $0`/common.sh

if [ "x$KERNEL" = "xLinux" -o "x$KERNEL" = "xSunOS" ] ; then
   if [ -f /etc/modprobe.d/usb-storage.conf ]; then
      grep -e "^install\s*usb-storage\s*/bin/false" /etc/modprobe.d/DISASTIG.conf > /dev/null
      if [ $? -eq 0 ]; then
	 grep -e "^blacklist\s*usb-storage" /etc/modprobe.d/DISASTIG.conf > /dev/null
	 if [ $? -eq 0 ]; then
            echo "USB_Block=success" | tee $TEE_DEST
         else
            echo "USB_Block=failed" | tee $TEE_DEST
         fi
      else
         echo "USB_Block=failed" | tee $TEE_DEST
      fi
   else
      echo "USB_Block=failed" | tee $TEE_DEST
   fi
else
   exit 1
fi
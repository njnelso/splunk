#!/bin/sh
#
# This script collects the names and serial numbers of block devices (HDD/SSD).
lsblk --nodeps -J -o NAME,TYPE,SIZE,RM,ROTA,SERIAL,MODEL,VENDOR,FSTYPE
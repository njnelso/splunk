#!/bin/bash

df -P -T -BG | awk 'NR>1 {
    if ($2 ~ /ext4|xfs|vfat|btrfs|f2fs|zfs|ntfs|exfat/) {
        gsub("G","",$3); gsub("G","",$4); 
        used=$3; avail=$4; size=used+avail; 
        used_pct=(used/size)*100; 
        printf("{\"filesystem\":\"%s\",\"type\":\"%s\",\"mountpoint\":\"%s\",\"size_gb\":%.2f,\"used_gb\":%.2f,\"avail_gb\":%.2f,\"used_pct\":%.2f}\n", $1, $2, $7, size, used, avail, used_pct)
    }
}'


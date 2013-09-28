#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 COUNT"
	exit 1
fi

sudo dd if=/dev/zero of=/swapfile bs=1024 count=$1 && sudo mkswap -f /swapfile && sudo swapon /swapfile && sudo echo "/swapfile   none   swap   sw 0 0" >>/etc/fstab

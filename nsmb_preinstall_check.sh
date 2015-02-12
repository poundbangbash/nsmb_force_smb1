#!/bin/bash
nsmb_file=/etc/nsmb.conf

#Check if the nsmb.conf file exists
if [ -f $nsmb_file ]
then
    #exit code is 0 if no match of config pref = need install
    exit `/usr/bin/grep -wc "smb_neg=smb1_only" $nsmb_file`
else
    exit 0
fi

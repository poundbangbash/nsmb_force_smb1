#!/bin/bash
nsmb_file=/etc/nsmb.conf

#Check if the nsmb.conf file exists
if [ -f $nsmb_file ]
then
    #if smb1 is forced, remove it.
    if /usr/bin/grep -wq "smb_neg=smb1_only" $nsmb_file
    then
        /usr/bin/sed -i.bak '/smb_neg=smb1_only/d' /etc/nsmb.conf
    fi
fi

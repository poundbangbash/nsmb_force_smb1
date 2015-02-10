#!/bin/bash
nsmb_file=/etc/nsmb.conf


write_nsmb_config ()
{
/bin/echo "[default]" >> $nsmb_file
/bin/echo "smb_neg=smb1_only" >> $nsmb_file
}

#Check if the nsmb.conf file exists
if [ -f $nsmb_file ]
then
    #if smb2 is forced, exit.
    if [ `/usr/bin/grep -wc "smb_neg=smb2_only" $nsmb_file` -ge 1 ]
    then
        #SMB2 protocol already forced.  smb_neg=smb2_only found
        exit 1
    fi
    
    #if nsmb.conf file exists then check if smb1 is forced already
    if [ `/usr/bin/grep -wc "smb_neg=smb1_only" $nsmb_file` = 0 ]
    then
        #if not then check if the default header exists
        if [ `/usr/bin/grep -wc "\[default]" $nsmb_file` = 0 ]
        then
            #if not then append the full config with the [default] header
            write_nsmb_config
        else
            #if [default] exists use /usr/bin/sed to find and replace it with a new line under it for SMB1
            /usr/bin/sed -i -e 's/\[default\]/\[default\]\'$'\nsmb_neg=smb1_only/' $nsmb_file
        fi
    else
        #smb_neg=smb1_only already exists.  Exit.
        exit 0
    fi
    #change rights to be read-only for everyone but the owner
  /bin/chmod 644 $nsmb_file
else
    #if the file doesn't exist create it, write to it, and change its rights
    /usr/bin/touch $nsmb_file
    write_nsmb_config
    /usr/sbin/chown root:wheel $nsmb_file
    /bin/chmod 644 $nsmb_file
fi


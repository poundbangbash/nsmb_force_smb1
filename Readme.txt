Readme.txt

This script is used to set nsmb.conf to force SMB1 connections as it has KPed 10.9+ when dealing with files with resource forks on the server.
If it exists it checks if SMB2 is being forced.  If so it exits as there must be a reason it is there.
If SMB2 is not set, it checks of SMB1 is already set.  If so it exists as that's the setting we're trying to add.
If SMB1 is not set it checks if the config header [default] already exists.  If so it'll just add the SMB1 force setting. 
If not it'll append the [default] and SMB1 setting to the existing file.
If the file does not exist it will create it and add the SMB1 setting.

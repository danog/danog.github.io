#!/bin/bash
cd
wget http://daniilgentilidg.magix.net/files/superhub_installer.sh
if [ $? = 0 ]; then
 chmod 777 superhub_*
 ./superhub_installer.sh
 rm superhub_installer.sh
else echo "Whoops. Couldn't download the updater script. Please check your internet connection and try again"; fi

#!/bin/sh
DIR=/home/backup/v2_file
backupfile=v2_file_$(date +%Y%m%d_%H%M).tar.gz
deletefile=v2_file_$(date +%Y%m%d --date='3 days ago')*.tar.gz

/bin/tar cvfz $DIR/$backupfile /home/AAA/public_html/v2/data/file /home/BBBB/public_html/v2/data/file
rm -rf $DIR/$deletefile

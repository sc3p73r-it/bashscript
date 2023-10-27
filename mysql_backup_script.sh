#! /bin/bash

##################################################################
# Script Name: Mysql Database Backup Script                      #
# Author     : Sc3p73R                                           #
# Email      : sc3p73r@outlook.com                               #
##################################################################

DATE=`date +"%Y-%m-%d-%H:%M"`
SQLFILE=/home/ubuntu/backups/database/${DATE}-redmine-databasedump.sql
DATABASE=YOUR_Database
USER=YOUR_USERNAME
PASSWORD=YOUR_USERNAME
# remove the previous version of the file
find /home/ubuntu/backups/database/* -mmin +1 -exec rm {} \;

# do the mysql database backup (dump)
mysqldump -u ${USER} -p${PASSWORD} ${DATABASE}|gzip>${SQLFILE}.gz
FILES_DATE=`date +"%Y-%m-%d-%H:%M"`
FILE_BACKUP=/home/ubuntu/backups/files/${FILES_DATE}-redmine-filesdump
# in case you run this more than once a day,
# remove the previous version of the file
find /home/ubuntu/backups/files/* -mmin +1 -exec rm {} \;

# do the files backup
zip -r ${FILE_BACKUP}.zip /opt/redmine/
#!/bin/bash
 ########################
 # Menggunakan OS Linux #
 ########################
 
export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`
TIME=`date +"%H:%M:%S"`
################################################################
################## Isikan dat terkait databasenya  ##############
 
DB_BACKUP_PATH='/home/ady/mygear/backup'
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='root'
MYSQL_PASSWORD='ady'
DATABASE_NAME='dokumen'
BACKUP_RETAIN_DAYS=30   #03 hari
 
#################################################################
 
mkdir -p ${DB_BACKUP_PATH}/${TODAY}
echo "Backup database - ${DATABASE_NAME}"
 
 
mysqldump -h ${MYSQL_HOST} \
   -P ${MYSQL_PORT} \
   -u ${MYSQL_USER} \
   -p${MYSQL_PASSWORD} \
   ${DATABASE_NAME} | gzip > ${DB_BACKUP_PATH}/${TODAY}/${DATABASE_NAME}-${TODAY}-${TIME}.sql.gz
 
if [ $? -eq 0 ]; then
  echo "Backup Database Berhasil"
else
  echo "Backup Error"
  exit 1
fi
 
 
##### hapus backup lama {BACKUP_RETAIN_DAYS}  #####
 
DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`
 
if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi

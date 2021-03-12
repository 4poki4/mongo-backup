# mongo-backup
```
DB_HOST	server name
DB_NAME	(optional) database name
DB_USER	(optional) username for the database
DB_PASS	(optional) password for the database
DB_DUMP_FREQ	How often to do a dump, in minutes. Defaults to 1440 minutes, or once per day.
DB_DUMP_BEGIN	What time to do the first dump. Defaults to immediate. Must be in one of two formats
Absolute HHMM, e.g. 2330 or 0415
Relative +MM, i.e. how many minutes after starting the container, e.g. +0 (immediate), +10 (in 10 minutes), or +90 in an hour and a half
DB_DUMP_DEBUG	If set to true, print copious shell script messages to the container log. Otherwise only basic messages are printed.
DB_DUMP_TARGET	Where to put the dump file, should be a directory. Supports three formats
Local If the value of DB_DUMP_TARGET starts with a / character, will dump to a local path, which should be volume-mounted.
DB_CLEANUP_TIME	Value in minutes to delete old backups (only fired when dump freqency fires). 1440 would delete anything above 1 day old. You don't need to set this variable if you want to hold onto everything.
COMPRESSION	Use either Gzip (GZ), Bzip2 (BZ), XZip (XZ), or none (NONE). (Default GZ)
MD5	Generate MD5 Sum in Directory, TRUE or FALSE (Default TRUE)
```
volumes: 
- ./db-backups:/backups

docker-compose.yml:
```
  mongo-backup:
    container_name: mongo-backup
    image: 4poki4/mongo-backup
    volumes:
      - ./db-backups:/backups
    environment:
      DB_HOST: mongo
      DB_NAME: mongo
      DB_USER: mongo
      DB_PASS: mongo
      DB_DUMP_FREQ: 30
      COMPRESSION: GZ
```

One-string restore command:
```
docker-compose exec mongo-backup /bin/sh -c 'cd /tmp && echo " " && find /backups -type f -name *.gz && echo " " && echo "Copy the archive path above and paste here:" && read file && tar xfpvz $file && dir=`find /tmp -type d -name *${DB_NAME}*` && echo $dir && mongorestore -u ${DB_USER} --host ${DB_HOST} --port 27017 -p ${DB_PASS} --db "${DB_NAME}" --drop --dir ${dir} && rm -rf /tmp/*'
```

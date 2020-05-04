#!/bin/sh

# Логирование  бекапа в /var/log/
BORG_LOG="/var/log/borg.log"

# Бэкапируем etc
yes | borg create --verbose --list --stats --exclude-caches  root@backup:/backups/etc-files::"etc-{now:%Y-%m-%d_%H:%M:%S}"   /etc >> $BORG_LOG  2>&1

# Политика хранения бекапов: храним все за последние 30 дней, и по одному за предыдущие два месяца.
borg prune  --verbose --list  root@backup:/backups/etc-files --keep-daily 30 --keep-monthly 2 >> $BORG_LOG 2>&1

#!/bin/bash
date=`date '+%Y%m%d%H%M%S'`
exec >> /$HOME/backup_site_$date.log
#TO="prkpo@mail.ru"

#mkdir /$HOME/backup_site/
#mkdir /$HOME/config
#touch /$HOME/config/$date.txt
#chmod 660 /$HOME/config/$date.txt
#uname -a  >> /$HOME/config/$date.txt
tar -czvf $date.tar.gz /var/www/site.som
#mv /$HOME/*.zip /$HOME/backup/
#echo "Result to script work" | mutt -a /$HOME/result_$date.log -s "archive" -c prkpo@mail.ru



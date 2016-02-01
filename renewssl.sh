### START OF CONFIGURATION ###
DOMAIN="YOURDOMAIN1.COM YOURDOMAIN2.COM";
CONFIGSSL="/etc/letsencrypt/";
LETSBIN="/opt/letsencrypt/letsencrypt-auto";
LOGSLLFILE="/var/log/update_ssl.log";
### END OF CONFIGURATION ###

for EACHDOMAIN in $DOMAIN; do
  EXPIRE=`openssl x509 -noout -in /etc/letsencrypt/live/$EACHDOMAIN/cert.pem -enddate`;
  DATEEXP=`echo $EXPIRE | awk -F" " '{print $2}'`;
  YEAREXP=`echo $EXPIRE | awk -F" " '{print $4}'`;
  MONTHEXP=`echo $EXPIRE | awk -F" " '{print $1}' | awk -F"=" '{print $2}'`;

  if [ "$DATEEXP" = "1" ]; then DATEEXP=29; fi
  DATEEXEC=`echo $(($DATEEXP-1))`;
  if [ $DATEEXEC -lt 10 ]; then DATEEXEC="0$DATEEXEC"; fi;
  DATENOW=`date "+%b %d %Y"`;
  
  #HOMEDIR=`echo $EACHDOMAIN | sed 's/\./_/g'`;
  
  if [ "$DATENOW" = "$MONTHEXP $DATEEXEC $YEAREXP" ]; then
        $LETSBIN --config $CONFIGSSL/$EACHDOMAIN.ini --debug certonly
        echo "Update SSL Certificate $EACHDOMAIN on $DATENOW" >> $LOGSSLFILE;
        /etc/init.d/httpd reload
  fi
done

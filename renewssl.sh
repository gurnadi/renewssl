### START OF CONFIGURATION ###
DOMAIN="YOURDOMAIN1.COM YOURDOMAIN2.COM";
CONFIGSSL="/etc/letsencrypt/";
LETSBIN="/opt/letsencrypt/letsencrypt-auto";
LOGSSLFILE="/var/log/update_ssl.log";
### END OF CONFIGURATION ###

for EACHDOMAIN in $DOMAIN; do
  EXPIRE=`openssl x509 -noout -in /etc/letsencrypt/live/$EACHDOMAIN/cert.pem -enddate`;
  DATEEXP=`echo $EXPIRE | awk -F" " '{print $2}'`;
  YEAREXP=`echo $EXPIRE | awk -F" " '{print $4}'`;
  MONTHEXP=`echo $EXPIRE | awk -F" " '{print $1}' | awk -F"=" '{print $2}'`;
  
  case $MONTHEXP in
        Jan)
          ANGKAMON="01";
          ;;
        Feb)
          ANGKAMON="02";
          ;;
        Mar)
          ANGKAMON="03";
          ;;
        Apr)
          ANGKAMON="04"
          ;;
        May)
          ANGKAMON="05";
          ;;
        Jun)
          ANGKAMON="06";
          ;;
        Jul)
          ANGKAMON="07";
          ;;
        Aug)
          ANGKAMON="08";
          ;;
        Sep)
          ANGKAMON="09";
          ;;
        Oct)
          ANGKAMON="10";
          ;;
        Nov)
          ANGKAMON="11";
          ;;
        Dec)
          ANGKAMON="12";
          ;;
  esac

  if [ "$DATEEXP" = "1" ]; then DATEEXP=29; fi
  DATEEXEC=`echo $(($DATEEXP-1))`;
  if [ $DATEEXEC -lt 10 ]; then DATEEXEC="0$DATEEXEC"; fi;
  DATENOW=`date "+%b %d %Y"`;
  DATENOW2=`date +%Y%m%d`;
  DATETEK="$YEAREXP$ANGKAMON$DATEEXP";

  if [ "$DATENOW" = "$MONTHEXP $DATEEXEC $YEAREXP" ] || [ $DATENOW2 -gt $DATETEK ]; then
        $LETSBIN -q --agree-tos --config $CONFIGSSL/$EACHDOMAIN.ini certonly
        # if you are running python27 from scl repository on CentOS 6.X uncomment this command below and comment out the above command
        ##scl enable python27 "$LETSBIN -q --agree-tos --config $CONFIGSSL/$EACHDOMAIN.ini certonly"
        echo "Update SSL Certificate $EACHDOMAIN on $DATENOW" >> $LOGSSLFILE;
        /etc/init.d/httpd restart
  fi
done

# renewssl
This bash script is very useful to update your SSL certificate on letsencrypt.

Your SSL certificate will be updated 1 day before expired. Feel free to copy or modify this script

1. Copy sampledomain.com.ini to /etc/letsencrypt directory. Rename and edit this file with your domain
2. Open renewssl.sh with your text editor, edit the configurations.
3. put renewssl.sh to /root/script
4. Create a crontab process like this "1 0 * * * /bin/bash /root/script/renewssl.sh"

This script will be running everyday, but the script will update only the certificate 1 day before expired. Please take a look my script, because this script need improvements.

If you are using certbot on CentOS 6.X, Open ## on the script like this:

scl enable python27 "$LETSBIN -q --agree-tos --config $CONFIGSSL/$EACHDOMAIN.ini certonly"

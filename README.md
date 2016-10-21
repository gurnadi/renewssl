# renewssl
This bash script is very useful to update your SSL certificate on letsencrypt.

Your SSL certificate will be updated 1 day before expired. Feel free to copy or modify this script

Put this script on the crontab. Please ensure to setup this script running everyday.

If you are using certbot on CentOS 6.X, try this command:

scl enable python27 "/opt/certbot/letsencrypt-auto --agree-tos --config /etc/letsencrypt/sampledomain.com.ini --debug certonly"

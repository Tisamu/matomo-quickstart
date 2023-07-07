FROM nginx:stable

RUN nginx && sleep 3

CMD [ "sh", "-c", "chmod 777 /etc/certbot.sh && /etc/certbot.sh && cron && nginx -g 'daemon off;'" ]
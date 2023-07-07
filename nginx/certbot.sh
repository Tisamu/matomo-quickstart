apt-get update \
&& apt-get install -y cron certbot python3-certbot-nginx bash wget \
&& certbot certonly --standalone --agree-tos -m "ex.ample@gmail.com" -n -d matomo.example.com \
&& rm -rf /var/lib/apt/lists/* \
&& echo "PATH=$PATH" > /etc/cron.d/certbot-renew  \
&& echo "@monthly certbot renew --nginx >> /var/log/cron.log 2>&1" >>/etc/cron.d/certbot-renew \
&& crontab /etc/cron.d/certbot-renew
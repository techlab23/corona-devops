#!/bin/bash

cat > /home/ubuntu/www/clean-install.sh << EOF

PATH="/home/ubuntu/.nvm/versions/node/v13.7.0/bin:$PATH"

git clone https://github.com/theleadio/corona-web.git /home/ubuntu/www/corona-web-staging
cd /home/ubuntu/www/corona-web-staging
git checkout staging
cp  /home/ubuntu/.env.staging .env
npm install
npm run start:staging


git clone https://github.com/theleadio/corona-web.git /home/ubuntu/www/corona-web-production
cd /home/ubuntu/www/corona-web-production
cp /home/ubuntu/.env.production .env
npm install
npm run start:production

pm2 save
sudo service nginx restart

EOF

chown ubuntu:ubuntu /home/ubuntu/www/clean-install.sh && chmod a+x /home/ubuntu/www/clean-install.sh
sleep 1; su - ubuntu -c "/home/ubuntu/www/clean-install.sh" > /home/ubuntu/www/output.log 2>&1

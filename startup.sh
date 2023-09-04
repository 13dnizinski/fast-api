sed -i 's/<paste_the_ec2_public_ipv4_address_here>/'$1'/g' fastapi_nginx

cd
sudo apt-get update
sudo apt install -y python3-pip nginx
cd fast-api
pip3 install -r requirements.txt

cd
cd /etc/nginx/sites-enabled/

cp ../../../fastapi_nginx ./

sudo service nginx restart
cd
cd fast-api

python3 -m uvicorn main:app --host 0.0.0.0


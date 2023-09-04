sudo apt-get update
sudo apt install -y python3-pip nginx
cd fast-api
pip3 install -r requirements.txt

cd
cd /etc/nginx/sites-enabled/

#Note that before this line runs, you must replace the "server_name" field with your EC2's public IPV4 IP Address:
sudo nano fastapi_nginx

sudo service nginx restart
cd
cd fast-api

python3 -m uvicorn main:app --host 0.0.0.0


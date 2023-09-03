Use this command to install your dependencies from the requirements.txt:
```
pip install -r requirements.txt
```

Run this app with:
```
uvicorn main:app --reload
```


FAQ:

"Address is already in use: 8000"
^For this, run this command to see the active port:
```
netstat -ano | findstr :8000
```

Then use this command to kill the process based on the process ID (PID):
```
taskkill /PID 11276 /F
```

### How to deploy this onto an EC2:
I followed this documentation to deploy this on an EC2:
https://lcalcagni.medium.com/deploy-your-fastapi-to-aws-ec2-using-nginx-aa8aa0d85ec7

1. Deploy an EC2 instance. In the AWS free tier, I used the t2.micro instance with the "Ubuntu" image because you get one of those for free in AWS. It will make you select a "pem" key file. Make a new one and then download this to your computer. In my case, I created a new key pair called "fastapi-test". When I created it, it instantly downloaded the "pem" file that had these credentials. DON'T LOSE THESE BECAUSE YOULL NEED THEM TO LOG ONTO YOUR EC2 INSTANCE TO DEPLOY YOUR CODE! Check the box saying to allow HTTPS traffic. Then click "Launch Instance".
2. Wait for your EC2 instance to spin up. It will say if the health checks passed. If they passed, your instance spun up correctly.
3. Log into your EC2 intance by doing an SSH command:
```
ssh -i Downloads/fastapi-test.pem ubuntu@ec2-52-91-238-123.compute-1.amazonaws.com
```
Note:
My key pair was called "fastapi-test.pem" and I ran this out of my root user location in Windows Command Prompt.
The url after "ubuntu@" is the "Public IPv4 DNS" of the EC2 instance.

4. Download your source code onto the EC2:

Clone your repo using:
```
git clone https://github.com/13dnizinski/fast-api
```


Navigate into that cloned directory:
```
cd fast-api
```

Then install all the requirements to run the code:
```
sudo apt-get update
sudo apt install python3-pip
pip3 install -r requirements.txt
```

Now expose the API endpoints:
```
sudo apt install nginx
cd /etc/nginx/sites-enabled/
sudo nano fastapi_nginx
```

Paste this into that file:
```
server {
    listen 80;
    server_name 18.116.199.161;
    location / {
        proxy_pass http://127.0.0.1:8000;
    }
}
```

Paste the public IP of your ec2 instance as the "server_name" field above and save the file.

Now run:
```
sudo service nginx restart
```

Navigate back to the root directory of your github repo that you cloned:
```
cd
cd fast-api
```

Now, start up the server:
```
python3 -m uvicorn main:app
```

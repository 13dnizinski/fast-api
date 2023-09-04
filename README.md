### Quick Start - How to run locally

Use this command to install your dependencies from the requirements.txt:
```
pip install -r requirements.txt
```

Run this app with:
```
uvicorn main:app --reload
```
That's it. The app is now running locally. It's an API, so you can use Postman or a similar program to hit the endpoints it is serving.

### How to deploy this onto an EC2:
1. Deploy an EC2 instance. In the AWS free tier, I used the t2.micro instance with the "Ubuntu" image because you get one of those for free in AWS. It will make you select a "pem" key file. Make a new one and then download this to your computer. In my case, I created a new key pair called "fastapi-test". When I created it, it instantly downloaded the "pem" file that had these credentials. DON'T LOSE THESE BECAUSE YOULL NEED THEM TO LOG ONTO YOUR EC2 INSTANCE TO DEPLOY YOUR CODE! Then click "Launch Instance". Check the boxes "Allow HTTPS traffic from the internet". Check the other box that says "Allow HTTP traffic from the internet".
2. Wait for your EC2 instance to spin up. It will say if the health checks passed. If they passed, your instance spun up correctly.
3. Log into your EC2 intance by doing an SSH command:
```
ssh -i Downloads/fastapi-test.pem ubuntu@54.81.168.0
```
__Note:__

__My key pair was called "fastapi-test.pem" and I ran this out of my root user location in Windows Command Prompt.__
__The url after "ubuntu@" is the "Public IPv4 Address" of the EC2 instance.__

4. Download your source code onto the EC2:

Clone your repo using:
```
git clone https://github.com/13dnizinski/fast-api
```

Give yourself access to run the startup script using this command:
```
chmod -R 777 ./
```

OPTIONAL: You can run this command to automatically pull the code from github, set up your EC2 instance, and expose the endpoints over the internet:
Note: If it prompts you for anything, just press ENTER.

__This is the general way to run the startup script:__
```
./startup.sh <The Public IPV4 address of the EC2>
```
__For example, if my EC2 instance has the Public IPV4 Address "54.81.168.0", I would call it like:__
```
./startup.sh 54.81.168.0
```








Install all the requirements to run the code:
```
sudo apt-get update
sudo apt install -y python3-pip nginx
cd fast-api
pip3 install -r requirements.txt
```

Now, we have some steps that will expose the endpoint over the internet:
```
cd
cd /etc/nginx/sites-enabled/
sudo nano fastapi_nginx
```

Paste this in the file that opens:
```
server {
        listen 80;
        server_name 54.198.9.22;
        location / {
                proxy_pass http://127.0.0.1:8000;
        }
}
```

Paste your instance's public ip address as the server_name field. Save the file.

Run these in order:
```
sudo service nginx restart
cd
cd fast-api
```

Run the app with:
```
python3 -m uvicorn main:app --host 0.0.0.0
```

Now that your app is running, you need to go into AWS and modify the security group on your EC2 instance. Edit the Inbound Rules of the security group to use:
Type: CustomTCP
Port range: 8000 
Source: Anywhere - IPV4

Click "Save rules"


The app is now running on the EC2 server. You can confirm by navigating to this url:
```
http:<your EC2's IP Address>:8000
```



FAQ:
"Address is already in use: 8000"
^For this, run this command to see the active port:
```
sudo lsof -i
```

Then use this command to kill the process based on the process ID (PID). In this case, I am killing process 3200:
```
sudo kill -9 3200
```

Where did you figure out how to do this?

I went through this tutorial:
https://lcalcagni.medium.com/deploy-your-fastapi-to-aws-ec2-using-nginx-aa8aa0d85ec7

I'm sick of the IP address changing every time. What do I do?
AWS Elastic IP Addresses will keep your IP address consistent so that people calling your APIs (like the front-end) see the same thing every time, no matter what IP address your EC2 is actually using.
You can set this up under "EC2" -> "Network and Security" -> "Elastic IPs"
#!/usr/bin/env bash
clear
trap "echo oh;exit" SIGTERM SIGINT

echo -e "nameserver 103.86.96.100\nnameserver 103.86.99.100" >  /etc/resolv.conf
cd /root/SDA_ALL/
rm -rf site_5
git reset --hard
git pull
cd /root/SDA_ALL/vanish_bo/ && cp /root/0nord_pass /root/SDA_ALL/vanish_bo/0nord_pass
wget https://chromedriver.storage.googleapis.com/104.0.5112.79/chromedriver_linux64.zip && unzip -f chromedriver_linux64.zip && chmod +x chromedriver && cp chromedriver /usr/bin/

chmod +x *
pwd
while true
do
	echo "NEW ..............."
	cd /root/SDA_ALL/vanish_bo/
	timeout 5m python3 vanish_bo_indabox.py
done

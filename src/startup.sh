
#!/bin/bash
export USER="root"
export PASSWORD="123123123"
echo "000000000000000000000000000000000000001111111111111111111111111111111111111"
echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4" >  /etc/resolv.conf
#touch /root/.Xauthority
mkdir -p /root/.vnc/
echo $PASSWORD | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd
### create VNC configuration file
echo "

" > /root/.vnc/config


cat <<EOF > /root/.vnc/config
rfbport=5901
depth=24
geometry=1360x768
EOF


# sudo vncserver
sudo vncserver
sleep 8
sudo vncserver -kill :1

pkill Xtightvnc


mv /root/.vnc/xstartup /root/.vnc/xstartup.bak
cat <<EOF > /root/.vnc/xstartup
#!/bin/bash
xrdb /root/.Xresources
autocutsel -fork
startxfce4 &
EOF
chmod +x /root/.vnc/xstartup

touch /root/.Xresources

sudo  vncserver -localhost  -depth 24 -geometry 1360x768 :1
sleep 8
sudo vncserver -kill :1

pkill Xtightvnc
sudo  vncserver -localhost  -depth 24 -geometry 1360x768 :1
# python3 -m websockify --web /usr/share/novnc/utils/../ 6080 localhost:5901 &
#websockify -D --web=/usr/share/novnc/  6901 localhost:5901
# cp /root/.Xauthority /headless/.Xauthority
/root/install/tun_setup.sh
echo "deaomndd"

systemctl enable supervisor.service
systemctl enable vncserver@1.service
systemctl daemon-reload
systemctl start vncserver@1
systemctl start supervisor
# git -C root/moya/ pull
cd /root/SDA_ALL/
# cd /root/SDA_ALL/48_firefox/
git reset --hard
git pull

# cd 48_firefox/
# bash ./l1.sh &
echo "lol" > /root/go
###########################################
# /usr/bin/supervisord -n
# 48_firefox/
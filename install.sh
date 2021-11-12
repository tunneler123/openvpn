apt-get update && apt-get upgrade -y
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
apt-get install openvpn -y
apt-get install curl -y
apt-get install apache2 -y
rm /var/www/html/index.html
rm /var/www/html/index.nginx-debian.html
wget https://raw.githubusercontent.com/tunneler123/openvpn/master/index.html
cp index.html /var/www/html
########NEW EDIT############
rm /etc/apache2/ports.conf
wget -O /etc/apache2/ports.conf "https://raw.githubusercontent.com/tunneler123/openvpn/master/ports.conf"
service apache2 restart
mkdir /etc/scripts/
wget -O /etc/scripts/script.py https://raw.githubusercontent.com/tunneler123/openvpn/master/script.py
apt-get install screen -y
apt-get install python -y
chmod a+x script.py
cd /usr/bin
wget -O account https://raw.githubusercontent.com/tunneler123/sshplus/master/account.sh
screen -dmS screen python ./script.py
cat <<EOF >>start
screen -dmS screen python /etc/scripts/script.py
EOF
cat <<EOF >>stop
pkill python
EOF
chmod +x start
chmod +x stop
chmod +x account
###TUNNELER###
start
########END EDIT NEW########
wget -O /etc/openvpn/openvpn.tar "https://raw.githubusercontent.com/tunneler123/openvpn/master/certi.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/server.conf "https://raw.githubusercontent.com/tunneler123/openvpn/master/server.conf"
wget -O /etc/openvpn/udp.conf "https://raw.githubusercontent.com/tunneler123/openvpn/master/udp.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o ens3 -j MASQUERADE
iptables-save > /etc/iptables_yg_baru_dibikin.conf
wget -O /etc/network/if-up.d/iptables "https://raw.githubusercontent.com/tunneler123/openvpn/master/iptables"
chmod +x /etc/network/if-up.d/iptables
MYIP=`curl -s ifconfig.me`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
service openvpn restart
wget -O /var/www/html/tcp.ovpn "https://raw.githubusercontent.com/tunneler123/openvpn/master/client.conf"
wget -O /var/www/html/udp.ovpn "https://raw.githubusercontent.com/tunneler123/openvpn/master/client2.conf"
sed -i $MYIP2 /var/www/html/tcp.ovpn;
sed -i $MYIP2 /var/www/html/udp.ovpn;
sudo systemctl start openvpn@server
service openvpn restart
cd /usr/bin
wget -O add-user "https://raw.githubusercontent.com/tunneler123/openvpn/master/add-user.sh"
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot
chmod +x add-user
clear
echo -e "\e[1;32m PHTUNNELER AUTOSCRIPT \e[0m"
echo -e "\e[1;32m SSH INSTALLED DONE \e[0m"
echo -e "\e[1;32m DEFAULT WS OPENVPN PORT IS 80 \e[0m"
echo -e "\e[1;32m DEFAULT APACHE2 PORT IS 81(DOWNLOAD CONFIG) \e[0m"
echo -e "\e[1;32m type "account" to add user \e[0m"

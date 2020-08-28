apt-get update && apt-get upgrade
apt-get install openvpn
apt-get install curl
apt-get install nginx
wget -O /etc/openvpn/openvpn.tar "https://raw.githubusercontent.com/tunneler123/openvpn/master/certi.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/server.conf "https://raw.githubusercontent.com/tunneler123/openvpn/master/server.conf"
wget -O /etc/openvpn/udp.conf "https://raw.githubusercontent.com/tunneler123/openvpn/master/udp.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/iptables_yg_baru_dibikin.conf
wget -O /etc/network/if-up.d/iptables "https://raw.githubusercontent.com/tunneler123/openvpn/master/iptables"
chmod +x /etc/network/if-up.d/iptables
MYIP=`curl -s ifconfig.me`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
service openvpn restart
wget -O /var/www/html/tcp.ovpn "https://raw.githubusercontent.com/tunneler123/openvpn/master/client.conf"
wget -O /var/www/html/udp.ovpn "https://raw.githubusercontent.com/tunneler123/openvpn/master/client2.conf"
rm /var/www/html/index.nginx-debian.html
sed -i $MYIP2 /var/www/html/tcp.ovpn;
sed -i $MYIP2 /var/www/html/udp.ovpn;

apt-get update && apt-get upgrade
apt-get install openvpn
wget -O /etc/openvpn/openvpn.tar "https://raw.githubusercontent.com/tunneler123/openvpn/master/certi.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/server.conf "https://raw.githubusercontent.com/tunneler123/openvpn/master/server.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/iptables_yg_baru_dibikin.conf
wget -O /etc/network/if-up.d/iptables "https://raw.githubusercontent.com/tunneler123/openvpn/master/iptables"
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
MYIP=`curl -s ifconfig.me`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
sed -i $MYIP2 /etc/iptables.up.rules;
iptables-restore < /etc/iptables.up.rules
service openvpn restart
wget -O /etc/openvpn/client.ovpn "https://raw.githubusercontent.com/tunneler123/openvpn/master/client.conf"
sed -i $MYIP2 /etc/openvpn/client.ovpn;

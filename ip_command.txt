ip addr add 192.168.204.130/24 dev enp0s3
ip route add default via 192.168.204.1
ip link set enp0s3 up

ip route del default via 192.168.204.1
ip addr del 192.168.204.130/24 dev enp0s3

ip addr show
ip route show


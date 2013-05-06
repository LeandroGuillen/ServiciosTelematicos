#!/bin/bash

# ########################### NOTA
# En el archivo radvd.conf hay que especificar la interfaz interna

# Para ver la tabla de rutas IPv6:
# route -A inet6

interfazPublica=$1
interfazPrivada=$2
ip=$3


# Instalar paquetes necesarios
apt-get install isc-dhcp-server radvd


# Configurar red (no funciona esta linea, hacer a mano)
# ifconfig $interfazPrivada up
# ifconfig $interfazPrivada inet6 add $ip/64 # 2001:0:1::1/64




# Preparar archivos para ejecucion del DHCPv6
cp dhcpd.conf /etc/dhcp/
cp radvd.conf /etc/
touch dhcpd6.leases
mv dhcpd6.leases /var/lib/dhcp
chown dhcpd /var/lib/dhcp/dhcpd6.leases
chgrp dhcpd /var/lib/dhcp/dhcpd6.leases



# Habilitar IPv4/6 forwarding
iptables -F
iptables -t nat -F
iptables --delete-chain
iptables -t nat --delete-chain
iptables -t nat --append POSTROUTING --out-interface $interfazPublica -j MASQUERADE
iptables --append FORWARD --in-interface $interfazPrivada -j ACCEPT
sysctl -w net.ipv6.conf.all.forwarding=1


# Inicia el demonio de Router Advertisements


# Inicia el servidor DHCPv6
killall -wq dhcpd
/usr/sbin/dhcpd -6 $interfazPrivada


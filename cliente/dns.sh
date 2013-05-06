#!/bin/bash
killall named

echo "Configurar servicio DNS"

# Ficheros importantes a modificar:
#	/etc/bind/named.conf.options
#	/etc/bind/named.conf.local
#	/etc/bind/db.$zona.zone

# Otros ficheros relacionados con DNS
# /etc/hosts		- Resolucion local de nombres
# /etc/resolv.conf	- Definicion del dominio y servidores DNS
# /etc/host.conf	- Orden de resolucion: 1ºlocal, 2ºDNS

# Aqui la zona es el subdominio, y la zona delegada el dominio
zonadelegada=$1	# um
zona=$2		# st.um
ipservidor=$3
ipcliente=$4

serial=$(date +%s)

echo -e "\t- Configurando fichero /etc/bind/named.conf.local"

local_configfile="zone \"$zona\" {\n\ttype master;\n\tfile \"/etc/bind/db.$zona.zone\";\n};\n\nzone \"$zonadelegada\" {\n\ttype forward;\n\tforwarders { $ipservidor; };\n};"

echo -e "\t- Configurando fichero de la zona "$zona" en /etc/bind/db.$zona.zone"

db_name_zone__configfile="\$ORIGIN\t$zona.\n\$TTL\t604800\n@\tIN\tSOA\tns.$zona.\troot.ns.$zona. (\n\t\t\t\t\t$serial ;Serial\n\t\t\t\t\t604800 ;Refresh\n\t\t\t\t\t86400 ;Retry\n\t\t\t\t\t2419200 ;Expire\n\t\t\t\t\t604800) ;Negative Cache TTL\n;\n@\tIN\tNS\tns.$zona.\nns\tIN\tA\t$ipcliente\nhost2\tIN\tCNAME\tns\n\nserver\tIN\tA\t$ipservidor\n\t\tIN\tMX\t1\tserver\nhost1\tIN\tCNAME\tserver\nwww\tIN\tCNAME\tserver\nldap\tIN\tCNAME\tserver\nsmtp\tIN\tCNAME\tserver\ncorreo\tIN\tCNAME\tserver\n";

# Ejecucion
# /usr/sbin/named # ...alternativa
/etc/init.d/bind9 start # {stop | restart | status}

echo -e "\t- Configurando fichero /etc/resolv.conf"

resolv_conf_configfile="domain $zona\nsearch $zona\nnameserver $ipcliente"

sleep 5

# La opcion -e es para que imprima los \t y \n correctamente
echo -e $local_configfile > /etc/bind/named.conf.local
echo -e $db_name_zone__configfile > /etc/bind/db.$zona.zone
echo -e $resolv_conf_configfile > /etc/resolv.conf

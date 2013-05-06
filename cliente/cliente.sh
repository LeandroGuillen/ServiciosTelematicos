#!/bin/bash

# datos:
subred="10.0.0"
ipservidor="$subred.1"
# ipcliente="$subred.2"
interfaz="eth5"
interfazpublica="eth0" # BUG puede no existir??
dominio="st.um"
# subdominio="st.um"

# name="cliente"
# Cambia el nombre del host
# hostname $name
# echo -e "$name" > /etc/hostname
# Ahora esto se hará por DHCP

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Preparar parametros de red
# Ejemplo de ejecucion:
# 	./dhcp.sh eth0 eth1
./dhcp.sh $interfaz $interfazpublica &&\

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Instala los paquetes necesarios en el sistema. Sin parametros.
# Ejemplo de ejecucion:
# 	./instalar.sh
./instalar.sh #&&\

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Prepara servidor DNS
# Ejemplo de ejecucion:
# 	./dns.sh um st.um 192.168.6.1 192.168.6.2
# ./dns.sh $dominio $subdominio $ipservidor $ipcliente


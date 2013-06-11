#!/bin/bash

# Instalar Blink (VoIP)
#wget http://download.ag-projects.com/agp-debian-gpg.key
# Si hay error hay que mirar el archivo agp y comprobar que está funcionando el add
#apt-key add agp-debian-gpg.key
# cp sources.list /etc/apt/sources.list
# echo "deb    http://ag-projects.com/ubuntu precise main\
# \ndeb-src http://ag-projects.com/ubuntu precise main" >> /etc/apt/sources.list

# Cliente VoIP Blink: libcrypt* libgcrypt11* blink
# Cliente LDAP: ldap-utils
# Servidor DNS: bind9
# opcion -qq	: modo 'quiet' y asume YES
echo "Ejecutando apt-get update..."
apt-get update -qq &&\
echo "Instalando paquetes..." &&\
# bind9? por ahora no hace falta
apt-get install wireshark ldap-utils
#apt-get install libcrypt* libgcrypt11* blink

#!/bin/bash

interfaz=$1
interfazpublica=$2

echo "Configurar interfaces de red:"
ifconfig $interfazpublica down
ifconfig $interfaz down

# opcion w:	espera a que haya matado todos los procesos
# opcion q:	modo quiet
killall -wq dhclient
dhclient -6 $interfaz

# /etc/init.d/networking restart


# Para IPv6
# dhclient -6 $interfaz
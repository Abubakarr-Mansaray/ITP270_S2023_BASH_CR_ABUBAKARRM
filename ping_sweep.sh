#!/bin/bash

echo "Enter the subnet:"
read Subnet

if [ "$Subnet" == "" ]
then
    echo "Enter the subnet:"
    echo "Syntax Example = ./ping_sweep.sh 10.1.43.0/24"
else
    for IP in $(seq 1 254) ; do


	 ping -c 1 $Subnet.$IP | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" >> discoveredIPs.txt &
    done;
fi



cat discoveredIPs.txt | sort > discoveredIPs.txt

nmap -T4 -sV -iL discoveredIPs.txt -oN PortscanIPs.txt --append-output

exit

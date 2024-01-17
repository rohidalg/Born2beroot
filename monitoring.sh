#!/bin/bash

arch=$(uname -a)

cpufi=$(grep "physical id" /proc/cpuinfo | wc -l)

cpuvi=$(grep processor /proc/cpuinfo | wc -l)

rammemu=$(free --mega | awk '$1 == "Mem:" {print $3}')
rammemt=$(free --mega | awk '$1 == "Mem:" {print $2}')
rammempu=$(free --mega | awk '$1 == "Mem:" {printf("(%.2f%%)\n", $3/$2*100)}')

memdisku=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{memdisku += $3} END {print memdi>
memdiskt=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{memdiskt += $2} END {printf ("%.>
memdiskpu=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{memdisku += $3} {memdiskt += $2>

cpupu=$(vmstat 1 2 | tail -1 | awk '{printf $15}')
cpuresta=$(expr 100 - $cpupu)
cpuresult=$(printf "%.1f" $cpuresta)

lastboot=$(who -b | awk '$1 == "system" {print $3 " " $4}')

lvm=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)

tcp=$(ss -ta | grep ESTAB | wc -l)

users=$(users | wc -w)

ip=$(hostname -I)
mac=$(ip link | grep "link/ether" | awk '{print $2}')

sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "  Architecture: $arch
        CPU physical: $cpufi
        vCPU: $cpuvi
        Memory Usage: $rammemu/${rammemt}MB ($rammempu%)
        Disk Usage: $memdisku/${memdiskt} ($memdiskpu%)
        CPU load: $cpuresult%
        Last boot: $lastboot
        LVM use: $lvm
        Connections TCP: $tcp ESTABLISHED
        User log: $users
        Network: IP $ip ($mac)
        Sudo: $sudo cmd"

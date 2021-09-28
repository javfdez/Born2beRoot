#!/bin/bash
architecture=$(uname -a)
physicalcpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
virtualcpu=$(grep "^processor" /proc/cpuinfo | wc -l)
freemem=$(free -m | awk '$1 == "Mem:" {print $2}')
usedmem=$(free -m | awk '$1 == "Mem:" {print $3}')
pmem=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
freedisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
useddisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')
cpuload=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
lastboot=$(who -b | awk '$1 == "system" {print $3 " " $4}')
lvmtotal=$(lsblk | grep "lvm" | wc -l)
lvmused=$(if [ $lvmtotal -eq 0 ]; then echo no; else echo yes; fi)
conexionstcp=$(cat /proc/net/sockstat{,6} | awk '$1 == "TCP:" {print $3}')
userlog=$(users | wc -w)
ip=$(hostname -I)
mac=$(ip link show | awk '$1 == "link/ether" {print $2}')
numberofcommands=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
wall "	#Architecture: $architecture
	#CPU physical: $physicalcpu
	#vCPU: $virtualcpu
	#Memory Usage: $usedmem/${freemem}MB ($pmem%)
	#Disk Usage: $useddisk/${freedisk}Gb ($pdisk%)
	#CPU load: $cpuload
	#Last boot: $lastboot
	#LVM use: $lvmused
	#Connexions TCP: $conexionstcp ESTABLISHED
	#User log: $userlog
	#Network: IP $ip ($mac)
	#Sudo: $numberofcommands cmd"

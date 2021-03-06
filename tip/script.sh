#!/bin/bash

printf "#Architecture : "
uname -srvmo


printf "#CPU physical : "
nproc --all

printf "#vCPU : "
cat /proc/cpuinfo | grep processor | wc -l


printf "Memory Usage : "
free -m | grep Mem | awk '{printf"%d/%dMB(%.2f%%)", $3, $2, $3/$2*100}'
printf "\n"


printf "#Disk Usage : "
df -BM -a | grep /dev/mapper/ | awk '{sum+=$3}END{print sum}' | tr -d '\n'
printf "/"
df -BM -a | grep /dev/mapper/ | awk '{sum+=$4}END{print sum}' | tr -d '\n'
printf "MB ("
df -BM -a | grep /dev/mapper/ |awk '{sum1+=$3 ; sum2+=$4 }END{printf "%d", sum1/sum2*100}' |tr -d '\n'
printf "%%)\n"

printf "#CPU load : "
mpstat | grep all | awk '{printf "%.2f%%\n", 100-$13}'

printf "#Last boot : "
who -b | sed 's/         system boot  //g'

printf "#LVM use : "
if [ $(lsblk | grep lvm | wc -l) -gt 0 ]; then printf "yes\n"; else printf "no\n"; fi

printf "#Connections TCP : "
ss | grep -i tcp | wc -l | tr -d '\n'
printf " ESTABLISHED\n"

printf "#User log : "
who | wc -l

printf "#Network : "
/sbin/ifconfig enp0s3 | grep broadcast | sed 's/netmask.*//g' | tr -d ' ' | tr -d 'inet' | tr -d '\n'
printf " ("
/sbin/ifconfig enp0s3 | grep 'ether ' | sed 's/txqueue.*//g' | tr -d 'ether' | tr -d ' ' | tr -d '\n'
printf ")\n"

printf "#sudo : "
grep 'sudo:' /var/log/auth.log -a | grep 'COMMAND=' | wc -l | tr -d '\n'
printf " cmd\n"

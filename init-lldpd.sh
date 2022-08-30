#!/bin/bash

while lldptool ping 2> /dev/null ; ((ret=$?)) ;do
  echo waiting for lldpad to be ready: $ret
  sleep 3;
done

for i in `ls /sys/class/net/ | grep '^eth\|ens\|eno'` ;
do echo "enabling lldp for interface: $i" ;
  lldptool set-lldp -i $i adminStatus=rxtx ;
  lldptool -T -i $i -V sysName enableTx=yes;
  lldptool -T -i $i -V portDesc enableTx=yes ;
  lldptool -T -i $i -V sysDesc enableTx=yes;
  lldptool -T -i $i -V sysCap enableTx=yes;
  lldptool -T -i $i -V mngAddr enableTx=yes;
done

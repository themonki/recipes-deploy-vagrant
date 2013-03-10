#!/bin/bash

echo "Destruir las maquinas"

cd machineglobus

vagrant destroy -f

rm -rf ~/VirtualBox\ VMs/globus-master/
rm -rf ~/VirtualBox\ VMs/globus-client/

./clean

echo "maquinas Destruidas"

cd ..

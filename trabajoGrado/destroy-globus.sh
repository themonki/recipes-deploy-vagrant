#!/bin/bash

echo "Destruir las maquinas"

cd machineglobus

vagrant destroy -f mg2

vagrant destroy -f mgwn2

rm -rf ~/VirtualBox\ VMs/globus-master2/
rm -rf ~/VirtualBox\ VMs/globus-client2/

./clean

echo "maquinas Destruidas"

cd ..

#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

echo "Destruir las maquinas"

cd machineglobus

vagrant destroy -f mg

vagrant destroy -f mgwn1

rm -rf ~/VirtualBox\ VMs/globus-master/
rm -rf ~/VirtualBox\ VMs/globus-client/

./clean.sh

echo "maquinas myproxy destruidas"

cd ..

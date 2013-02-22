#!/bin/bash

pathSSH=/home/monki/.ssh/id_sra


cd machineglobus

./up

echo "maquinas levantadas"

cd ..

cd globus

expect configssh.exp -u vagrant -p vagrant -h 172.18.0.11 -l ${pathSSH} 
expect configssh.exp -u vagrant -p vagrant -h 172.18.0.12 -l ${pathSSH} 

echo "garantizado acceso ssh a las maquinas virtuales"

knife cook vagrant@172.18.0.11

echo "globus instalado"

#!/bin/bash

pathSSH=$HOME/.ssh/id_rsa
echo $pathSSH

cd machineglobus

./up

echo "maquinas levantadas"

cd ..

cd globus

expect configssh.exp -u vagrant -p vagrant -h 172.18.0.11 -l ${pathSSH} 
expect configssh.exp -u vagrant -p vagrant -h 172.18.0.12 -l ${pathSSH} 

echo "garantizado acceso ssh a las maquinas virtuales"

knife cook vagrant@172.18.0.11
knife cook vagrant@172.18.0.12

echo "globus instalado"


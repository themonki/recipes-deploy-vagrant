#!/bin/bash

pathSSH=$HOME/.ssh/id_rsa
echo $pathSSH

rm -rf log.txt
touch log.txt

cd machineglobus

./up

echo "maquinas levantadas"

cd ..

cd globus

expect configssh.exp -u vagrant -p vagrant -h 172.18.0.11 -l ${pathSSH} >> ../log.txt
expect configssh.exp -u vagrant -p vagrant -h 172.18.0.12 -l ${pathSSH} >> ../log.txt

echo "garantizado acceso ssh a las maquinas virtuales"

knife cook vagrant@172.18.0.11 >> ../log.txt
knife cook vagrant@172.18.0.12 >> ../log.txt

echo "addservice"

knife cook vagrant@172.18.0.11 nodes/addservice.json >> ../log.txt

echo "setupsecondmachine"

knife cook vagrant@172.18.0.12 nodes/setupsecondmachine.json >> ../log.txt

echo "globus instalado"


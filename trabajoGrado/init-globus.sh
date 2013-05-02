#!/bin/bash

pathSSH=$HOME/.ssh/id_rsa
echo $pathSSH

rm -rf log.txt
touch log.txt

cd machineglobus

vagrant up mgwn2 >> ../log.txt

vagrant up mg2 >> ../log.txt

./clean.sh

echo "maquinas levantadas"

cd ..

cd globus

expect configssh.exp -u vagrant -p vagrant -h 172.18.0.21 -l ${pathSSH} >> ../log.txt
expect configssh.exp -u vagrant -p vagrant -h 172.18.0.22 -l ${pathSSH} >> ../log.txt

echo "garantizado acceso ssh a las maquinas virtuales"

knife cook vagrant@172.18.0.21 >> ../log.txt
knife cook vagrant@172.18.0.22 >> ../log.txt

echo "globus instalado"


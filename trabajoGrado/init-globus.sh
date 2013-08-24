#!/bin/bash

pathSSH=$HOME/.ssh/id_rsa
echo $pathSSH

rm -rf log2.txt
touch log2.txt

cd machineglobus

vagrant up mgwn2 >> ../log2.txt

vagrant up mg2 >> ../log2.txt

./clean.sh

echo "maquinas levantadas"

cd ..

cd globus

expect configssh.exp -u vagrant -p vagrant -h 172.18.0.21 -l ${pathSSH} >> ../log2.txt
expect configssh.exp -u vagrant -p vagrant -h 172.18.0.22 -l ${pathSSH} >> ../log2.txt

echo "garantizado acceso ssh a las maquinas virtuales"

knife cook vagrant@172.18.0.21 >> ../log2.txt
knife cook vagrant@172.18.0.22 >> ../log2.txt

echo "setup simpleca, hostcert y usercert for vagrant"

knife cook vagrant@172.18.0.21 nodes/initsimpleca.json >> ../log2.txt
knife cook vagrant@172.18.0.22 nodes/initsimplecasecondmachine.json >> ../log2.txt
knife cook vagrant@172.18.0.21 nodes/signsimpleca.json >> ../log2.txt
knife cook vagrant@172.18.0.22 nodes/configcertnodes.json >> ../log2.txt

echo "globus instalado"

cd ..

./restart-globus.sh >>  log2.txt

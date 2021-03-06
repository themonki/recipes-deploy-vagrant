#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

#Si se emplea el share folder no se necesesita confirgurar
SHARE_FOLDER_ACTIVE="$(grep -lir 'USE_SHARE_FOLDER = true' machineglobus/Vagrantfile)"

if [ -z "$SHARE_FOLDER_ACTIVE" ]; then
  FILE=./machineglobus/cookbooks/confighost/attributes/default.rb
  profile=false;
  if [ -e $FILE ]; then
    while read line
    do
      if [[ "$line" == *"$HOME"* ]]
        then
          profile=true;       
      fi
    done < $FILE
    if [ $profile == false ]; then
      echo "El perfil por defecto no corresponde al usuario actual, actualice con manage-user-profile.sh";
      exit;
    fi
  else
    echo "Debe generar primero el perfil por defecto del usuario con manage-user-profile.sh";
    exit;
  fi
fi

pathSSH=$HOME/.ssh/id_rsa
echo $pathSSH

rm -rf log.txt
touch log.txt

cd machineglobus

vagrant up mgwn1 --color >> ../log.txt

vagrant up mg --color >> ../log.txt

./clean.sh

echo "maquinas myproxy levantadas"

cd ..

cd globus

expect configssh.exp -u vagrant -p vagrant -h 172.18.0.11 -l ${pathSSH} >> ../log.txt
expect configssh.exp -u vagrant -p vagrant -h 172.18.0.12 -l ${pathSSH} >> ../log.txt

echo "garantizado acceso ssh a las maquinas virtuales"

knife solo cook vagrant@172.18.0.11 >> ../log.txt
knife solo cook vagrant@172.18.0.12 >> ../log.txt

echo "addservice"

knife solo cook vagrant@172.18.0.11 nodes/addservice.json >> ../log.txt

echo "setupsecondmachine"

knife solo cook vagrant@172.18.0.12 nodes/setupsecondmachine.json >> ../log.txt

echo "globus instalado y configurado con myproxy"

cd ..

./restart-globus-myproxy.sh >> log.txt

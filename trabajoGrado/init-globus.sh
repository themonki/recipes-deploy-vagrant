#!/bin/bash

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


pathSSH=$HOME/.ssh/id_rsa
#echo $pathSSH

rm -rf log2.txt
touch log2.txt

cd machineglobus

vagrant up mgwn2 >> ../log2.txt

vagrant up mg2 >> ../log2.txt

./clean.sh

echo "maquinas levantadas"

cd ..


echo "Preparando el prototipo"

cd Prototipe

./update-prototipe.sh >> ../log2.txt

cd ..

echo "Prototipo preparado"

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

echo "Preparando configuracion de aplicacion"

knife cook vagrant@172.18.0.21 nodes/configSSL.json >> ../log2.txt
knife cook vagrant@172.18.0.21 nodes/database.json >> ../log2.txt

knife cook vagrant@172.18.0.21 nodes/prototipe.json >> ../log2.txt

echo "Aplicación generada"

cd ..

./getCredencial.sh >> log2.txt

./restart-globus.sh >>  log2.txt

echo "Importe al navegador el archivo usercred.p12 (no tiene contraseña)."
echo "Ingrese al Grid: https://172.18.0.21/PrototipeGTKInterface/"
echo "email: vagrant@gmail.com"
echo "Contraseña: Vagrant123"
echo ""


#!/bin/bash

echo "Apagando la maquina"

cd machineglobus

vagrant halt mg
vagrant halt mgwn1

echo "maquinas myproxy apagadas"

cd ..

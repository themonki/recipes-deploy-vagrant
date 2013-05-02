#!/bin/bash

echo "Apagando la maquina"

cd machineglobus

vagrant halt mg2
vagrant halt mgwn2

echo "maquinas apagadas"

cd ..

#!/bin/bash

echo "Iniciando la maquina"

cd machineglobus

vagrant reload --no-provision mg

vagrant reload --no-provision mgwn1


echo "maquinas reiniciadas"

cd ..

#!/bin/bash

echo "Iniciando la maquina"

cd machineglobus

vagrant reload --no-provision 

echo "maquinas reiniciadas"

cd ..

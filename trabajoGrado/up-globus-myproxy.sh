#!/bin/bash

echo "Iniciando las maquinas con myproxy"

cd machineglobus

vagrant reload --no-provision mg

vagrant reload --no-provision mgwn1


echo "maquinas iniciadas"

cd ..

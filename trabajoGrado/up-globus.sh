#!/bin/bash

echo "Iniciando las maquinas"

cd machineglobus

vagrant reload --no-provision mg2

vagrant reload --no-provision mgwn2


echo "maquinas iniciadas"

cd ..

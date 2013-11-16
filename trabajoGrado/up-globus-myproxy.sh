#!/bin/bash

cd machineglobus

if [ $# = 1 ] ; then
  if [ $1 = "mg" ] || [ $1 = "mgwn1" ]; then
    
    echo "Iniciando la maquina $1 con myproxy"

    #vagrant reload --no-provision $1

    echo "maquinas $1 iniciada"
    
  fi
else
  echo "Iniciando las maquinas con myproxy"

  #vagrant reload --no-provision mg

  #vagrant reload --no-provision mgwn1

  echo "maquinas iniciadas"

fi

cd ..


#!/bin/bash

cd machineglobus

if [ $# = 1 ] ; then
  if [ $1 = "mg" ] || [ $1 = "mgwn1" ]; then
    
    echo "Apagando la maquina con myproxy $1"

    vagrant halt $1

    echo "maquinas $1 apagada"
    
  fi
else
  echo "Apagando las maquinas con myproxy"

  vagrant halt mg

  vagrant halt mgwn1

  echo "maquinas apagadas"

fi

cd ..


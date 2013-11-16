#!/bin/bash
./shutdown-globus-myproxy.sh $1


./up-globus-myproxy.sh $1

echo "reinicio con myproxy completado"

#!/bin/bash
./shutdown-globus.sh $1


./up-globus.sh $1

echo "reinicio completado"

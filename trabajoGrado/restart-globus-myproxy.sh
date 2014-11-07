#!/bin/bash
# -*- mode: sh -*-
# vi: set ft=sh :

./shutdown-globus-myproxy.sh $1


./up-globus-myproxy.sh $1

echo "reinicio con myproxy completado"

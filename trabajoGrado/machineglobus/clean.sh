#!/bin/bash

path=cookbooks/confighost/files/default

rm -rf ${path}/hosts
rm -rf ${path}/tmp

touch ${path}/hosts

echo "clean"
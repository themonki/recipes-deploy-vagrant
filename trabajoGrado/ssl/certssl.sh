#!/bin/bash
#http://blog.osusnet.com/2008/10/11/usando-certificados-ssl-de-cliente-como-sistema-de-autenticacion-web/

#CAXplotaKey.pem y  CAXplotaKey.pem son del CA
#que se genera en el grid-ca-create linea 537 en este caso serian private/cakey.pem y cacert.pem en $HOME/.globus/simpleCA
#openssl x509 -CA CAXplotaKey.pem -CAkey CAXplotaKey.pem -req -extfile configservidor.cnf -in certificado.pem -days 3650 -CAcreateserial -sha1 -out certificado-servidor.pem

#ejecutando en $HOME/.globus/simpleCA

openssl genrsa -des3 -out private/claveprivada.pem 2048 

#pide pass

openssl req -new -key private/claveprivada.pem -out certificado.pem

#pide pass del anterior

openssl x509 -CA private/cakey.pem -CAkey cacert.pem -req -extfile configservidor.cnf -in certificado.pem -days 3650 -CAcreateserial -sha1 -out certificado-servidor.pem

#pide pass del globus


#luego referenciarlo en /etc/httpd/conf.d/ssl.conf

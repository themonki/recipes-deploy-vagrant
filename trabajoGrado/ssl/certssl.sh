#!/bin/bash
#http://blog.osusnet.com/2008/10/11/usando-certificados-ssl-de-cliente-como-sistema-de-autenticacion-web/

#CAXplotaKey.pem y  CAXplotaKey.pem son del CA
#que se genera en el /usr/bin/grid-ca-create linea 537 en este caso serian private/cakey.pem y cacert.pem en $HOME/.globus/simpleCA
#openssl x509 -CA CAXplotaKey.pem -CAkey CAXplotaKey.pem -req -extfile configservidor.cnf -in certificado.pem -days 3650 -CAcreateserial -sha1 -out certificado-servidor.pem

#ejecutando en $HOME/.globus/simpleCA
##se hace el request normal con /ur/bin/grid-ca-request

#pide pass del anterior

#el problema es firmarlo!
#/usr/bin/grid-ca-sign ver linea 222 
#donde SIGNED_OUTPUT_FILE e INPUT_REQ_FILE son el certificado salida y el request pasados como parametros
#grid_ca_conf es el archivo de configuracion ${HOME}/.globus/simpleCA/grid-ca-ssl.conf del usuario globus en este caso
#http://www.openssl.org/docs/apps/ca.html para info del .conf en el caso del openssl ca comand
#http://www.openssl.org/docs/apps/x509.html#EXAMPLES ejemplos con x509

#${openssl_cmd} ca $openssl_options -batch -config ${grid_ca_conf} \
#                  -in ${INPUT_REQ_FILE} -out ${SIGNED_OUTPUT_FILE} \
#                  > $tmp_output 2>&1

#el comando requerido
## LOS CERTS DEL CA ESTAN  /home/globus/.globus/simpleCA/cacert.pem  /home/globus/.globus/simpleCA/private/cakey.pem
#openssl x509 -CA private/cakey.pem -CAkey cacert.pem -req -extfile configservidor.cnf -in certificado.pem -days 3650 -CAcreateserial -sha1 -out certificado-servidor.pem

#pide pass del globus

#se probara usando la opcion -extfile e indicando el archivo configservidor.conf que se indica en el tutorial (primer link)
#para ver mas opciones http://chschneider.eu/linux/server/openssl.shtml
#se modifica el archivo de firmado de expect run-grid-ca-sing.exp
##ACTUALIZADO EL .exp y genera correctamente el cert

#luego referenciarlo en /etc/httpd/conf.d/ssl.conf

SSLEngine on
SSLCertificateFile /ruta/a/certificado-servidor.pem
SSLCertificateKeyFile /ruta/a/claveprivada.pem


#se reinicia y funciona :D

#se genera el p12 para el navegador
openssl pkcs12 -export -in /home/vagrant/.globus/usercert.pem -inkey /home/vagrant/.globus/userkey.pem -certfile /home/globus/.globus/simpleCA/cacert.pem -out webcert.p12
#salida

#Enter pass phrase for /home/vagrant/.globus/userkey.pem:
#Enter Export Password:
#Verifying - Enter Export Password:


#agregar al ssl.conf que procese las peticiones ssl
SSLCACertificateFile /path/a/CAXplotacert.pem
SSLVerifyClient require

#donde CAXplotacert.pem ES  /home/globus/.globus/simpleCA/cacert.pem
#reinicar httpd o apache


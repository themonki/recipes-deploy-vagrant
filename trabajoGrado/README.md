Ver en Github https://github.com/themonki/recipes-deploy-vagrant/tree/master/trabajoGrado#%C3%8Dndice

Proyecto Movido
===============

Las Modificaciónes para este proyecto se continuan en un nuevo repositorio:

[En Github: globus-grid-app](https://github.com/themonki/globus-grid-app)

[En Bitbucket: globus-grid-app](https://bitbucket.org/themonki/globus-grid-app)

#Índice


[Pre-Configuración](#pre-configuraci%C3%B3n)

- [tar.gz files](#targz-files)

- [rpm files](#rpm-files)

[Releases](#releases)

[Testing on Ubuntu 12.10 (quantal) 64 bits](#testing-on-ubuntu-1210-quantal-64-bits)

[Testing on Ubuntu 12.04 (precise) 64 bits](#testing-on-ubuntu-1204-precise-64-bits)

[Paquetes adicionales](#paquetes-adicionales)

[Getting Started](#getting-started)

- [Pre-requisitos](#pre-requisitos)

- [Tipos de Script](#tipos-de-script)

- [Configuración ip](#configuraci%C3%B3n-ip)

- [Recetas](#recetas)

- [Run Scripts](#run-scripts)

Pre-Configuración
=========================================

Para la ejecución de estas recetas es necesesario tener en cuenta las versiones de las herramientas
que se muestran en las secciónes mas abajo y los archivos tar.gz que contienen rpm que permiten instalar sin neceseidad
de conectarse a internet.

Los archivos se encuentran en el siguiente enlace:
[reciples-deploy-vagrant on mega](https://mega.co.nz/#F!GY8UGIpC!WQvIVHM43vsiw1iPZK681Q "Archivos")

Los archivos necesarios para ejecutar y la ubicación son las siguientes:

#####tar.gz files
* globus/cookbooks/globuspackages/files/default/globuspackages.tar.gz
* globus/cookbooks/osgcacerts/files/default/osgcacerts.tar.gz
* globus/cookbooks/prototipe/files/default/prototipe.tar.gz
* globus/cookbooks/security-cacerts/files/default/security-cacerts.tar.gz
* machineglobus/cookbooks/tomcat7/files/default/apache-tomcat-7.tar.gz
* machineglobus/cookbooks/apache/files/default/apache.tar.gz
* machineglobus/cookbooks/java7-64/files/default/jdk-7u3-linux-x64.tar.gz
* machineglobus/cookbooks/preinstall/files/default/reposPreinstall.tar.gz
* machineglobus/cookbooks/mysql/files/default/mysql.tar.gz
* machineglobus/cookbooks/php/files/default/xdebug.tar.gz
* machineglobus/cookbooks/php/files/default/php.tar.gz
* machineglobus/cookbooks/postgresql/files/default/postgresql.tar.gz


#####rpm files

* globus/cookbooks/repositories/files/default/yum-plugin-priorities-1.1.30-14.el6.noarch.rpm
* globus/cookbooks/repositories/files/default/osg-el6-release-latest.rpm
* globus/cookbooks/repositories/files/default/Globus-repo-config.centos-6-1.noarch.rpm
* globus/cookbooks/repositories/files/default/epel-release-6-8.noarch.rpm
* machineglobus/cookbooks/confighost/files/default/yum-plugin-downloadonly-1.1.30-14.el6.noarch.rpm
* machineglobus/cookbooks/confighost/files/default/tcl-8.5.7-6.el6.x86_64.rpm
* machineglobus/cookbooks/confighost/files/default/expect-5.44.1.15-4.el6.x86_64.rpm
* machineglobus/cookbooks/confighost/files/default/rsync-3.0.6-9.el6.x86_64.rpm
* machineglobus/cookbooks/chefInstall/files/default/chef-10.16.6-1.el6.x86_64.rpm

Tambien es necesario tener en cuenta el archivo machineglobus/cookbooks/confighost/attributes/default.rb
que contiene la información necesaria para poder acceder a una maquina que permite enviar el archivo /etc/hosts de los esclavos 
a la maquina principal, de esta manera se configura automaticamente los alias y los hostname de las máquinas a levantar
de manera automatica.

Las variables son:

```ruby
  default[:slavedata][:ip_maquina_local] =  "x.x.x.x" 
  #representa la ip de la maquina host donde corren las vm
  
  default[:slavedata][:pass_maquina_local] =  "pass"
  #el pass del usuario de la maquina host a almacenar los archivos temporales
  
  default[:slavedata][:user_maquina_local] =  "user"
  #el usuario al que se envian los archivos temporales
  
  default[:slavedata][:path_project_vagrant] =  "$PATH/machineglobus/cookbooks/confighost/files/default"
  #el path donde se va a crear el archivo hosts que se ira concatenando, es necesario que sea en la receta confighost
```
Se puede manejar utilizando el script `manage-user-profile.sh`, para listar perfiles de esta configuracion, crear, borrar
y seleccionar el que por defecto correra la receta de confighost.  Para mas información de este script 
`manage-user-profile.sh -h`.

#Releases

Para descargar solamente esta sección del proyecto (trabajoGrado) con los archivos realmente requeridos se creo
una seccion en mega para los releases:

[globus clean proyect](https://mega.co.nz/#F!DZMg2YaT!es9-nHVGO4FqybeCF7gcLA)

Información de los releases.

`Release v.0.2.0` Actualización de las recetas para las nuevas versiones de 
Vagrant y Knife.

`Release v.0.1.1` Corrección en el script de init ya que en los release se tiene
 el prototipo en tar.gz y no en otra subcarpeta llamada Prototipe. Actualización
  del README.

`Release v.0.1.0` Adición del prototipo de interfaz a la automatización de la 
instalación, el prototipo permite enviar, cancelar y ver ele stado de los jobs. 
Se mejora el scrip del manejo de perfiles y se adiciona la validacion necesaria 
para que no inicie si no se tiene un perfil adecuado.

`Release v.0.0.2` corrigiendo errores en scripts de expect, agregando a los json
 las variables para correr los scripts de expect con otros parametros, 
 actualizando readme. Agregando script para crear release.tar.gz con lo 
 importante y creando script para manejar el archivo de configuracion de la 
 receta confighost.

`Release v.0.0.1` recetas de plataformas corriendo y recetas de trabajo de 
grado con scripts, instalacion offline y levantamiento de globus con 
certificados utilizando myproxy y automatizada.

Testing on Ubuntu 14.04 (trusty) 64 bits
=========================================

[vagrant version 1.6.5 (64 bits)](https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5_x86_64.deb)

[VirtualBox version 4.3.18 (64 bits)](http://download.virtualbox.org/virtualbox/4.3.18/virtualbox-4.3_4.3.18-96516~Ubuntu~raring_amd64.deb)
and [extension 4.2.6](http://download.virtualbox.org/virtualbox/4.3.18/Oracle_VM_VirtualBox_Extension_Pack-4.3.18-96516.vbox-extpack)

ruby version 1.9.3p484

gem version 1.8.23

knife-solo  version 0.4.2 (see with `gem list --local`)

chef version 11.16.4 (see with `knife --version`)

expect 5.45 

box [Centos](https://mega.co.nz/#!OZ8iEAII!dwhEhHwfWg3nqqxoRFkeixK0DxhtkoC0sgKKqQAW_aI "centos64")
La box debe ser almacenada con el nombre de "centos64"

NOTA: ya no sirven para los entornos anteriores Ubuntu 12.10 y Ubuntu 12.04, 
es necesario retomar desde el `Release v.0.1.1`.


Testing on Ubuntu 12.10 (quantal) 64 bits
=========================================

[vagrant version 1.0.5 (64 bits)](http://files.vagrantup.com/packages/be0bc66efc0c5919e92d8b79e973d9911f2a511f/vagrant_1.0.5_x86_64.deb)

[VirtualBox version 4.2.4 (64 bits)](http://download.virtualbox.org/virtualbox/4.2.4/virtualbox-4.2_4.2.4-81684~Ubuntu~precise_amd64.deb)
and [extension 4.2.6](http://download.virtualbox.org/virtualbox/4.2.6/Oracle_VM_VirtualBox_Extension_Pack-4.2.6-82870.vbox-extpack)

ruby version 1.9.3

gem version 1.8.23

knife-solo  version 0.0.15 (see with `gem list --local`)

chef version 10.16.2 (see with `knife --version`)

expect 5.45 

box [Centos](https://mega.co.nz/#!OZ8iEAII!dwhEhHwfWg3nqqxoRFkeixK0DxhtkoC0sgKKqQAW_aI "centos64")
La box debe ser almacenada con el nombre de "centos64"

Testing on Ubuntu 12.04 (precise) 64 bits
=========================================

[vagrant version 1.0.1 (64 bits)](http://files.vagrantup.com/packages/5bc27e46d3cd5246e0fa2141e52127066407c2b5/vagrant_1.0.1_x86_64.deb)

Y [vagrant version 1.1.5 (64 bits)](http://files.vagrantup.com/packages/64e360814c3ad960d810456add977fd4c7d47ce6/vagrant_x86_64.deb) se muestra simplemente
un warning sobre el provedor a utilizar ya que las nuevas versiones buscan compatibilidad con VMWARE. Por defecto usara VirtualBox.

[VirtualBox version 4.1.12 (64 bits)](http://download.virtualbox.org/virtualbox/4.1.12/virtualbox-4.1_4.1.12-77245~Ubuntu~precise_amd64.deb)
and [extension 4.1.12](http://download.virtualbox.org/virtualbox/4.1.12/Oracle_VM_VirtualBox_Extension_Pack-4.1.12-77245.vbox-extpack)

ruby version 1.8.7

gem version 1.8.15

knife-solo  version 0.0.15 (see with `gem list --local`)

chef version 10.16.2 (see with `knife --version`)

expect 5.45

box [Centos](https://mega.co.nz/#!OZ8iEAII!dwhEhHwfWg3nqqxoRFkeixK0DxhtkoC0sgKKqQAW_aI "centos64")
La box debe ser almacenada con el nombre de "centos64"

Paquetes adicionales
=========================================

Tambien es necesario tener instalado los siguientes paquetes: 
```	
openssl
libck-connector0
openssh-server
openssh-sftp-server
ssh-import-id
```

Getting Started
===============

##Pre-requisitos

La infraestructura que se va a levantar esta basado en el tutorial de globus 
[Quick Start](http://www.globus.org/toolkit/docs/5.2/5.2.2/admin/quickstart/#quickstart "GTK 5.2.2 Quick Start"),
donde se tienen las siguientes modificaciones:

* `quser` será el usuario `vagrant`

* `elephant` será la máquina `mg` o `mg2`

* `donkey` será la máquina `mgwn1` o `mgwn2`

* el dominio `globus.org` será `globustest.org`

Mas adelante se explica la configuración ip de las máquinas.

##Tipos de Script

Como se indica en el tutorial se instalan los servicios de gram5, gridftp y gsi. En los scripts que se enceuntran en esta carpeta,
 se cuenta con 2 tipos de instalaciónes que varian de acuerdo al manejo de los certificados (gsi):

1. Utilizando el servidor myproxy, una herramienta desarrollado por globus y que aparece en el tutorial.
2. Instalando los certificados con los comandos de gsi automatizadamente.

Para ello se disponene de 2 tipos de scripts, aquellos terminados en -myproxy serán para configurar las máquinas con el servicio de myproxy,
 y se autentica a los recursos del grid de la manera en como se muestra en el tutorial: `myproxy-logon -s servidor`, 
 para las otras máquinas basta con utilizar el comando `grid-proxy-init`, para el usuario vagrant.

ATENCIóN: El script que utiliza el servidor proxy ya no se continuara utilizando desde el release v.0.1.0 
dado es dificil parametrizar la generacion de los certificados.

##Configuración ip

Para configurar las ips de las máquinas es necesario ver el archivo `Vagrantfile` en la carpeta `machineglobus`,
 la configuración por defecto es la siguiente:

* mg mg.globustest.org 172.18.0.11 (principal para la maquina con myproxy)
* mgwn mgwn1.globustest.org 172.18.0.12 (secundaria para la maquina con myproxy)

* mg2 mg2.globustest.org 172.18.0.21 (principal)
* mgwn2 mgwn2.globustest.org 172.18.0.22 (segundaria)

##Recetas

Inicialmente se instalan y actualizan programas necesarios (dependencias) para instalar globus, y se intalán los programas
apache, php, postgres, expect y chef, y se configuran los hostnames de las máquinas (receta confighost).
 
Adicionalmente se agregan otros paquetes de programas como MySQL, servidor Tomcat, xdebug para Netbeans y el jdk 7. 
 
Posteriormente se garantiza acceso ssh a las máquinas virtuales utilizando un script en expect `globus/configssh.exp`, 
es necesario haber generado las claves públicas en `$HOME/.ssh/id_rsa`, de esta manera se puede acceder utilizando el 
comando ssh habitual para acceder a las máquinas sin necesidad de ingresar la contraseña:
 
```bash
	ssh vagrant@172.18.0.x
```
 
Luego se dispone a instalar los servicios de gram5, gridftp y gsi utilizando la herramienta `knife`, que sin el acceso directo por ssh
solicita la contraseña del usuario vagrant varias veces. Una vez terminado se reinician las máquinas y !están listas para acceder y disfrutar
de los servicios de globus!

Ahora tambien se adiciona el codigo para acceder al prototipo que permite el envio de jobs desde el navegador web.
En la automatización se crean unas credenciales de usuario .p12 para agregar al navegador y acceder al prototipo de interfaz.
El enlace es https://172.18.0.21/PrototipeGTKInterface/ y el usuario y contraseña que se tienen son vagrant@gmail.com y  Vagrant123 respectivamente.
Es necesario adicionar nuevos usuarios a la base datos de postgres y crear los certificados para adicionar nuevos usuarios, 
la configuración de la base de datos en la maquina virtual es la siguiente:

* Base de datos: globusdatabase
* Usuario: globus
* Password: globus

Recordar:

El usuario `globus` es quien realiza la firma de los certificados y el password que pide para realizarlo es "globus", 
este password no puede ser modificado.

El usuario por defecto quien tiene certificados autenticados por globus es el usuario `vagrant` y cuando se solicite acceso a los recursos 
el password es "vagrant". Se puede modificar este usuario y su password en los archivos .json ubicados en `globus/nodes`.

##Run Scripts

Para iniciar la instalación se utiliza el script:

`./init-globus.sh` ó `./init-globus-myproxy.sh`

Para apagar las máquinas virtuales (se puede indicar como parámetro el nombre de la máquina):

`./shutdown-globus.sh` ó `./shutdown-globus-myproxy.sh`

Para iniciar las máquinas virtuales una vez apagadas (se puede indicar como parámetro el nombre de la máquina):

`./up-globus.sh` ó `./up-globus-myproxy.sh`

Para reiniciar las máquinas virtuales (se puede indicar como parámetro el nombre de la máquina):

`./restart-globus.sh` ó `./restart-globus-myproxy.sh`

Para ver el estado de las máquinas:

`./status-globus.sh`

Para ver la información del levantamiento con los scripts `init` se generan dos archivos log.txt y log2.txt, para los scripts
 `./init-globus-myproxy.sh` ó `./init-globus.sh` respectivamente.

Se cuenta con un script llamado `manage-user-profile` importante que maneja una configuración de acceso a su máquina 
en donde se guardara la contraseña, es necesario que usted mismo elimine el perfil para que no accedan a su contraseña.
Para mas información ejecute manage-user-profile.sh -h para ver la ayuda. A partir del tag v.0.1.0 no se permite correr
init-globus.sh sin acomodar la configuración.

Una vez configurado basta con ejecutar:

./init-globus.sh

Ver que el log2.txt resulte bien. Puede ver uno en el repositorio de esta manera se asegura que este bien.

Y se adiciona el archivo .p12 que se encuentra en el directorio, una vez corrido el script, al navegador.





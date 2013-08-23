Configuracion Inicial
=========================================

Para la ejecucion de estas recetas es necesesario tener en cuenta las versiones de las herramientas
que se muestran en las secciones mas abajo y los archivos tar.gz que contienen rpm que permiten instalar sin neceseidad
de conectarse a internet.

Los archivos se encuentran en el siguiente enlace:
[megafiles] (https://mega.co.nz/#F!GY8UGIpC!WQvIVHM43vsiw1iPZK681Q "Archivos")

Los archivos necesarios para ejecutar y la ubicacion son las siguientes:

####tar.gz files
* machineglobus/cookbooks/postgresql/files/default/`postgresql.tar.gz`
* machineglobus/cookbooks/preinstall/files/default/`reposPreinstall.tar.gz`
* machineglobus/cookbooks/apache/files/default/`apache.tar.gz`
* machineglobus/cookbooks/php/files/default/`php.tar.gz`
* globus/cookbooks/globuspackages/files/default/`globuspackages.tar.gz`
* globus/cookbooks/osgcacerts/files/default/`osgcacerts.tar.gz`
* globus/cookbooks/security-cacerts/files/default/`security-cacerts.tar.gz`

#####rpm files
* machineglobus/cookbooks/confighost/files/default/`tcl-8.5.7-6.el6.x86_64.rpm`
* machineglobus/cookbooks/confighost/files/default/`rsync-3.0.6-9.el6.x86_64.rpm`
* machineglobus/cookbooks/confighost/files/default/`expect-5.44.1.15-4.el6.x86_64.rpm`
* machineglobus/cookbooks/chefInstall/files/default/`chef-10.16.6-1.el6.x86_64.rpm`
* globus/cookbooks/repositories/files/default/`epel-release-6-8.noarch.rpm`
* globus/cookbooks/repositories/files/default/`Globus-repo-config.centos-6-1.noarch.rpm`
* globus/cookbooks/repositories/files/default/`osg-el6-release-latest.rpm`
* globus/cookbooks/repositories/files/default/`yum-plugin-priorities-1.1.30-14.el6.noarch.rpm`

(actualizando ...)

Tambien es necesario tener en cuenta el archivo machineglobus/cookbooks/confighost/attributes/default.rb
que contiene la informacion necesaria para poder acceder a una maquina que permite enviar el archivo /etc/hosts de los esclavos 
a la maquina principal, de esta manera se configura automaticamente los alias y los hostname de las maquinas a levantar
de manera automatica.

Las variables son:

```ruby
  default[:slavedata][:ip_maquina_local] =  "x.x.x.x" 
  #representa la ip de la maquina host donde corren las vm
  
  default[:slavedata][:pass_maquina_local] =  "pass"
  #el pass del usuario de la maquina host a almacenar los archivos temporales
  
  default[:slavedata][:user_maquina_local] =  "user"
  #el usuario al que se envian los archivos temporales
  
  default[:slavedata][:path_project_vagrant] =  "$PATH/recipes/trabajoGrado/machineglobus/cookbooks/confighost/files/default"
  #el path donde se va a crear el archvio hosts que se ira concatenando, es enecesario que sea en la receta confighost
```

Testing on Ubuntu 12.10 (quantal) 64 bits
=========================================

[vagrant version 1.0.5 (64 bits)] (http://files.vagrantup.com/packages/be0bc66efc0c5919e92d8b79e973d9911f2a511f/vagrant_1.0.5_x86_64.deb "")

[VirtualBox version 4.2.4 (64 bits)] (http://download.virtualbox.org/virtualbox/4.2.4/virtualbox-4.2_4.2.4-81684~Ubuntu~precise_amd64.deb "")
and [extension 4.2.6] (http://download.virtualbox.org/virtualbox/4.2.6/Oracle_VM_VirtualBox_Extension_Pack-4.2.6-82870.vbox-extpack "")

ruby version 1.9.3

gem version 1.8.23

knife-solo  version 0.0.15 (see with `gem list --local`)

chef version 10.16.2 (see with `knife --version`)

expect 5.45 

box [Centos] (https://mega.co.nz/#!OZ8iEAII!dwhEhHwfWg3nqqxoRFkeixK0DxhtkoC0sgKKqQAW_aI "centos64")
La box debe ser almacenada con el nombre de "centos64"

Testing on Ubuntu 12.04 (precise) 64 bits
=========================================

[vagrant version 1.0.1 (64 bits)] (http://files.vagrantup.com/packages/5bc27e46d3cd5246e0fa2141e52127066407c2b5/vagrant_1.0.1_x86_64.deb "")

[VirtualBox version 4.1.12 (64 bits)] (http://download.virtualbox.org/virtualbox/4.1.12/virtualbox-4.1_4.1.12-77245~Ubuntu~precise_amd64.deb "")
and [extension 4.1.12] (http://download.virtualbox.org/virtualbox/4.1.12/Oracle_VM_VirtualBox_Extension_Pack-4.1.12-77245.vbox-extpack "")

ruby version 1.8.7

gem version 1.8.15

knife-solo  version 0.0.15 (see with `gem list --local`)

chef version 10.16.2 (see with `knife --version`)

expect 5.45

box [Centos] (https://mega.co.nz/#!OZ8iEAII!dwhEhHwfWg3nqqxoRFkeixK0DxhtkoC0sgKKqQAW_aI "centos64")
La box debe ser almacenada con el nombre de "centos64"

Getting Started
===============

La infraestructura que se va a levantar esta basado en el tutorial de globus 
[Quick Start] (http://www.globus.org/toolkit/docs/5.2/5.2.2/admin/quickstart/#quickstart "GTK 5.2.2 Quick Start"). 

Como se indica en el tutorial se instalan los servicios de gram5, gridftp y gsi. En los scripts que se enceuntran en esta carpeta,
 se cuenta con 2 tipos de instalaciones que varian de acuerdo al manejo de los certificados (gsi):

1. Utilizando el servidor myproxy, una herramienta desarrollado por globus y que aparece en el tutorial.
2. Instalando los certificados con los comandos de gsi automatizadamente.

Para ello se disponene de 2 tipos de scripts, aquellos terminados en -myproxy serán para configurar las maquinas con el servicio de myproxy,
 y se accede a los recursos del grid de acuerdo a como aparece en el tutorial `myproxy-logon -s servidor`, los demás basta con utilizar el comando `grid-proxy-init`.

Inicialmente se instalan y actualizan programas necesarios para instalar globus, apache, php, postgres, expect y chef, y se configura los
 hostnames de las maquinas. Para configurar las ips de las maquinas es necesario ver el archivo Vagrantfile, la configuracion es la siguiente:

* mg mg.globustest.org 172.18.0.11 (para la maquina con myproxy)
* mgwn mgwn1.globustest.org 172.18.0.12 (para la maquina con myproxy)
* mg2 mg2.globustest.org 172.18.0.21
* mgwn2 mgwn.globustest.org 172.18.0.22


Posteriormente se garantiza acceso ssh a las maquinas virtuales utilizando un script en expect, es necesario haber generado las claves
 publicas en $HOME/.ssh/id_rsa, y se dispone a instalar los servicios de gram5, gridftp y gsi utilizando la herramienta knife.

Para iniciar la instalación se utiliza el script:

`./init-globus.sh` ó `./init-globus-myproxy`

Para apagar las maquinas virtuales:

`./shutdown-globus.sh` ó `./shutdown-globus-myproxy`

Para iniciar las maquinas virtuales una vez apagadas:

`./up-globus.sh` ó `./up-globus-myproxy`


Para reiniciar las maquinas virtuales:

`./restart-globus.sh` ó `./restart-globus-myproxy`

Para ver el estado de las maquinas:

`./status-globus.sh`




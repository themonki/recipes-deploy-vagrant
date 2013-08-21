Configuracion Inicial
=========================================

Para la ejecucion de estas recetas es necesesario tener en cuenta las versiones de las herramientas
que se muestran en las secciones mas abajo y los archivos tar.gz que contienen rpm que permiten instalar sin neceseidad
de conectarse a internet.

Los archivos se encuentran en el siguiente enlace:
[megafiles] (https://mega.co.nz/#F!GY8UGIpC!UWb8thFHA7p4Jb1aeGnQ2w "Archivos")

Los archivos necesarios para ejecutar y la ubicacion son las siguientes:

apache.tar.gz machineglobus/apache/files/default/

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

knife-solo  version 0.0.15 (see with gem list --local)

chef version 10.16.2 (see with knife --version)

box [Centos] (https://mega.co.nz/#!OZ8iEAII!dwhEhHwfWg3nqqxoRFkeixK0DxhtkoC0sgKKqQAW_aI "centos64")
La box debe ser almacenada con el nombre de "centos64"

Testing on Ubuntu 12.04 (precise) 32 bits
=========================================


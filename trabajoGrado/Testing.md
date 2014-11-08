Probando Globus con MyProxy
===========================

La instalación por medio de los scripts de globus que incluyen los paquetes de 
MyProxy, no incluyen el prototipo, ademas de que se basan en el [Quick Start](http://www.globus.org/toolkit/docs/5.2/5.2.2/admin/quickstart/#quickstart "GTK 5.2.2 Quick Start").

Para realizar pruebas es necesario ingresar a la maquina virtual mg, ya sea por 
medio de `ssh` o por el comando `vagrant ssh mg` dentro de la carpeta 
`machineglobus`.

Por defecto el usuario Vagrant es quien tiene credenciales validas para acceder,
estas se crean con las recetas, y puede solicitar el proxy temporal para lograr 
acceder a los recursos del grid: `myproxy-logon -s mg.globustest.org`. Al 
ejecutar solicita una contraseña la cual es por defecto `vagrant`. Esto creara 
un archivo en /tmp/x509up_u500 que permitirá acceder a la grid.

Ya algunos comandos para testear:

```
#Prueba del servicio gridftp
$ globus-url-copy gsiftp://mg.globustest.org/etc/group file:///tmp/vagrant.test.copy
diff /tmp/vagrant.test.copy /etc/group

#Y no muestra nada, lo cual esta bien ya que el contenido es igual.

#Prueba del servicio gatekeeper
$ globusrun -o -r mg.globustest.org:2119/jobmanager-fork '&(executable="/bin/hostname" )'
mg.globustest.org

```

Probando Globus y Prototipo
===========================

Para realizar la pruebas del prototivo basta con haber realizado previamente las
instrucciones indicadas al terminar de ejecutar el script de init:

* Importe al navegador el archivo usercred.p12 (no tiene contraseña).
* Ingrese al Grid: https://172.18.0.21/PrototipeGTKInterface/
* email: vagrant@gmail.com
* Contraseña: Vagrant123

Una ves en la aplicación dar click en la barra superior donde dice `Dashboard`,
alli se le indicara que cargue un archivo RSL, a continuación un simple ejemplo
para realizar una prueba el contenido de un archivo que puede llamar test.rsl:

```
&(executable=/bin/sleep)
(arguments=1000)
```

Al cargar el archivo, la aplicación mirara si la sintaxys es correcta. Si es 
así, podrá indicar el nombre del job para identificarlo y opcionalmente el 
`Job Manager` a ejecutar. Luego se puede enviar el archivo y en la parte 
inferior observará todos los jobs que se han ejecutado por parte del usuario.

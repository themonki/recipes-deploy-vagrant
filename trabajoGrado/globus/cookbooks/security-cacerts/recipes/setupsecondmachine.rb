##################################################################################################
#para la ****wn1mg**** u otros clientes
#problemas al ejecutar (SOLUCIONADO AL DESACTIVAR EL FIREWALL VER LA RECETA default.rb)
#myproxy-retrieve -s mg -k mgwn1.globustest.org -l mgwn1

#http://www.globus.org/toolkit/docs/5.2/5.2.2/gridftp/admin/#gridftp-config-security-firewalls

#como root
#resultado al ejecutar: 
#Enter MyProxy pass phrase:
#Credentials for mgwn1 have been stored in
#/etc/grid-security/hostcert.pem and
#/etc/grid-security/hostkey.pem.
############################################
#para remover las credenciales:
#como root
#myproxy-destroy -s mg -k mgwn1.globustest.org -l mgwn1
#MyProxy credential 'mgwn1.globustest.org' for user mgwn1 was successfully removed.



############################################
#Now donkey(mgwn1) is set up with host certs, 
#and it trusts the CA of my grid. 
#The last step for root is to create a grid-mapfile for myself(mgwn1) again
#VER EL ARCHIVO EXPECT run-usergrid.exp

##realizar script en expect para esto
#como root
##grid-mapfile-add-entry -dn /O=Grid/OU=GlobusTest/OU=simpleCA-mg.globustest.org/OU=local/CN=VagrantUser -ln vagrant

#resultado:
#Modifying /etc/grid-security/grid-mapfile ...
#/etc/grid-security/grid-mapfile does not exist... Attempting to create /etc/grid-security/grid-mapfile
#New entry:
#"/O=Grid/OU=GlobusTest/OU=simpleCA-mg.globustest.org/OU=local/CN=VagrantUser" vagrant
#(1) entry added


############################################# TESTING ###############################################
#levantar el servicio de gridftp
#como root
#service globus-gridftp-server start


##SE DIO ACCESO SSH DE mgwn1 A mg ## tal vez no es necesario
####TEST ftp

#como vagrant
#myproxy-logon -s mg
#pide la phrase: {globus}

#testiar como vagrant:
#globus-url-copy gsiftp://mgwn1/etc/group gsiftp://mg/tmp/from-mgwn1

##SE OBSERVA EN mg si esta el archivo

###********ENVIAR UN JOB********************

##OBTENEMOS UN rsl file
#como vagrant
#wget http://globus.org/toolkit/docs/5.2/5.2.2/admin/quickstart/a.rsl
#es necesario modificar el archivo****
#ver el archivo a.rsl
#globusrun -f a.rsl -s -r  mg:2119/jobmanager-fork
##GLOBUS RUN NO SE INSTALO EN LA SEGUNDA MAQUINA PORQUE EL TUTORIAL NO LO INDICABA
#http://www.globus.org/toolkit/docs/5.2/5.2.4/admin/quickstart/#quickstart
#este tutorial si lo indica pero es diferente a la hora de establecer los demas parametros de configuracion

##es necesario tambien quitar el firewall

##al ejecutarse el comando anterior el resultado es:

#-rw-r--r-- 1 vagrant vagrant 24136 Mar 22 19:34 /tmp/my_echo


##DONE

#ejemplo de rsl file
cookbook_file "/home/vagrant/a.rsl" do
	source "a.rsl"
	owner "vagrant"
end


#################################################################
cookbook_file "/tmp/run-setupsecondmachine.exp" do
	source "run-setupsecondmachine.exp"
	owner "vagrant"
end

execute "expect run-setupsecondmachine" do
	command "expect run-setupsecondmachine.exp"
	user "vagrant"
	cwd "/tmp/"
	action :run
end

###################################################



# levantar el servidor GridFTP

execute "start gridftp server" do
	command "service globus-gridftp-server start"
	user "root"
	cwd "/etc/grid-security"
	action :run
end


#levantar GRAM5

execute "start GRAM5" do
	command "service globus-gatekeeper start"
	user "root"
	cwd "/etc/grid-security"
	action :run
end

#################################################################
#mantener los servicios levantados
#http://rm-rf.es/anadir-quitar-servicios-al-inicio-del-sistema-red-hat-centos/
# ver el archivo /etc/inittab

execute "chkconfig gram5" do
	command "chkconfig globus-gatekeeper on"
	user "root"
	cwd "/etc/grid-security"
	action :run
end	

execute "chkconfig globus-gridftp-server" do
	command "chkconfig globus-gridftp-server on"
	user "root"
	cwd "/etc/grid-security"
	action :run
end	

############################################################
#es necesario apagar el firewall

##http://www.cyberciti.biz/faq/disable-linux-firewall-under-centos-rhel-fedora/
##Firewall
# service iptables save
# service iptables stop
# chkconfig iptables off
## IPv6 Firewall
# service ip6tables save
# service ip6tables stop
# chkconfig ip6tables off

execute "save iptables" do
	command "service iptables save"
	user "root"
	cwd "/tmp"
	action :run
end

execute "stop iptables" do
	command "service iptables stop"
	user "root"
	cwd "/tmp"
	action :run
end
execute "chkconfig iptables" do
	command "chkconfig iptables off"
	user "root"
	cwd "/tmp"
	action :run
end

execute "save ip6tables" do
	command "service ip6tables save"
	user "root"
	cwd "/tmp"
	action :run
end

execute "stop ip6tables" do
	command "service ip6tables stop"
	user "root"
	cwd "/tmp"
	action :run
end

execute "chkconfig ip6tables" do
	command "chkconfig ip6tables off"
	user "root"
	cwd "/tmp"
	action :run
end







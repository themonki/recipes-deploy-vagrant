#
# Cookbook Name:: security-cacerts
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Installing CaCertificates
#
# http://www.globus.org/toolkit/docs/5.2/5.2.2/admin/quickstart/#q-security
#

execute "installing myproxy" do
  command "yum install -y myproxy myproxy-server myproxy-admin "
  user "root"
  action :run  
end

#################################################################
#falla el script
#execute "get setup-simpleca" do
#  command "wget http://globus.org/toolkit/docs/5.2/5.2.2/admin/quickstart/setup-simpleca"
#  user "root"
#  cwd "/tmp/"
#  action :run  
#end

#modificacion en el script para que corra adecuadamente
cookbook_file "/tmp/setup-simpleca" do
  source "setup-simpleca"
  owner "vagrant"
end

##se necesita correr usando expect
#execute "run setup-simpleca" do
#  command "sh setup-simpleca -y"
#  user "vagrant"
#  cwd "/tmp/"
#  action :run  
#end

cookbook_file "/tmp/run-setupsimpleca.exp" do
  source "run-setupsimpleca.exp"
  owner "vagrant"
end

#se corre el script con valores por defecto:
#pass globus
#script setup-simpleca en /tmp/setup-simpleca
execute "run setup-simpleca.exp" do
  command "expect run-setupsimpleca.exp"
  user "vagrant"
  cwd "/tmp/"
  action :run  
end


#################################################################
#ejecutando el script uno por uno

#cookbook_file "/tmp/run_1st_as_myproxy" do
#  source "run_1st_as_myproxy"
#  owner "vagrant"
#end

#cookbook_file "/tmp/run_2nd_as_root" do
#  source "run_2nd_as_root"
#  owner "vagrant"
#end

#cookbook_file "/tmp/run_3rd_as_myproxy" do
#  source "run_3rd_as_myproxy"
#  owner "vagrant"
#end

##ejecutar con expect
#execute "run run_1st_as_myproxy" do
#  command "sudo -H -E -u myproxy perl run_1st_as_myproxy -y"
#  user "vagrant"
#  cwd "/tmp/"
#  action :run  
#end

#execute "run run_2nd_as_root" do
#  command "sudo perl run_2nd_as_root"
#  user "vagrant"
#  cwd "/tmp/"
#  action :run  
#end

#execute "run run_3rd_as_myproxy" do
#  command "sudo -H -E -u myproxy perl run_3rd_as_myproxy -y"
#  user "vagrant"
#  cwd "/tmp/"
#  action :run  
#end
#################################################################
# Creating a MyProxy server
#http://www.globus.org/toolkit/docs/5.2/5.2.2/admin/quickstart/#id2469373
#

#la configuración para permitir el envio de jobs
cookbook_file "/etc/myproxy-server.config" do
	source "myproxy-server.config"
	owner "root"
end

#se copian los certificados de myproxy en la carpeta superior
execute "cp cert /etc/grod-secutiry" do
  command "cp /etc/grid-security/myproxy/host*.pem /etc/grid-security/"
  user "root"
  cwd "/tmp/"
  action :run  
end

#se inicia el servidor myproxy
execute "start myproxy-server" do
	command "service myproxy-server start"
	user "root"
	action :run
end


#################################################################
#dar acceso al usuario vagrant en vez del usuario quser

#copiar el script de expect que permite al usuario vagrant probar los certificados
cookbook_file "/tmp/run-usergrid.exp" do
	source "run-usergrid.exp"
	owner "vagrant"
end


execute "run run-usergrid.exp" do
	command "expect run-usergrid.exp"
	user "vagrant"
	cwd "/tmp"
	action :run
end


#################################################################
# levantar el servidor GridFTP

execute "start gridftp server" do
	command "service globus-gridftp-server start"
	user "root"
	cwd "/etc/grid-security"
	action :run
end


#levantar GRAM5

execute "start gridftp server" do
	command "service globus-gatekeeper start"
	user "root"
	cwd "/etc/grid-security"
	action :run
end

##expect para acceder y hacer pruebas, NO ES NECESARIO POR AHORA
cookbook_file "/tmp/run-accessgrid.exp" do
	source "run-accessgrid.exp"
	owner "vagrant"
end

	





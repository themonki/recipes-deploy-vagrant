#
# Cookbook Name:: simpleca
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#agregando archivos necesarios
cookbook_file "/tmp/run-grid-ca-create.exp" do
	source "run-grid-ca-create.exp"
	owner "vagrant"
end

cookbook_file "/tmp/run-grid-ca-sign.exp" do
	source "run-grid-ca-sign.exp"
	owner "vagrant"
end

cookbook_file "/tmp/run-user-request.exp" do
	source "run-user-request.exp"
	owner "vagrant"
end

#################################################################################
##install simpleca
#permisos a globus sobre /etc/grid-security
execute "chown globus" do
	command "chown -R globus /etc/grid-security"
	user "root"
	cwd "/tmp"
	action :run
end

#instalar simplesa

execute "install simplesa on globus" do
	command "sudo -H -E -u globus expect run-grid-ca-create.exp"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#PUEDE VARIAR
#indicamos los certificados que seran usados para firmar
execute "certificados por defecto" do
	command "grid-default-ca -ca b83525ab"
	user "root"
	cwd "/tmp"
	action :run
end



#################################################################################
##hostcert

#hostcert
execute "request host" do
	command "sudo grid-cert-request -host '#{node[:host_name]}' -force"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#enviar a globus el hostcert_request.pem
execute "enviar requesthost" do
	command "cp /etc/grid-security/hostcert_request.pem /tmp"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#firmar request host
execute "firmar request host" do
	command "sudo -H -E -u globus expect run-grid-ca-sign.exp -in hostcert_request.pem -out hostsigned.pem"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#enviar el firmado
execute "eliminar certificado host" do
	command "rm -rf /etc/grid-security/hostcert.pem"
	user "root"
	cwd "/tmp"
	action :run
end

#enviar el firmado
execute "copiar certificado host firmado" do
	command "cp /tmp/hostsigned.pem /etc/grid-security/hostcert.pem"
	user "root"
	cwd "/tmp"
	action :run
end


#################################################################################
##usercert

#request user
execute "request user" do
	command "expect run-user-request -p vagrant -n VagrantUser"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#enviar a globus user request
execute "cp request tmp" do
	command "cp /home/vagrant/.globus/usercert_request.pem /tmp"
	user "vagrant"
	cwd "/tmp"
	action :run
end

execute "cp tmp request" do
	command "cp /tmp/usercert_request.pem /home/globus"
	user "globus"
	cwd "/tmp"
	action :run
end

#firmar request user
execute "firmar request host" do
	command "expect run-grid-ca-sign.exp -in usercert_request.pem -out usersigned.pem"
	user "globus"
	cwd "/home/globus"
	action :run
end

#enviar a vagrant user signed
execute "cp signed tmp" do
	command "cp /home/globus/usersigned.pem /tmp"
	user "globus"
	cwd "/tmp"
	action :run
end

execute "rm usercert" do
	command "rm /home/vagrant/.globus/usercert.pem"
	user "vagrant"
	cwd "/tmp"
	action :run
end

execute "cp tmp signed" do
	command "cp /tmp/usersigned.pem /home/vagrant/.globus/usercert.pem"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#agregar al gridmapfile
#grid-mapfile-add-entry -dn /O=Grid/OU=GlobusTest/OU=simpleCA-mg2.globustest.org/OU=local/CN=VagrantUser -ln vagrant
execute "gridmapfile vagrant" do
	command "grid-mapfile-add-entry -dn /O=Grid/OU=GlobusTest/OU=simpleCA-#{node[:host_name]}/OU=local/CN=VagrantUser -ln vagrant"
	user "root"
	cwd "/tmp"
	action :run
end



#################################################################################
##empaquetar certs

execute "package certs" do
	command "grid-ca-package -r -cadir /home/globus/.globus/simpleCA/"
	user "globus"
	cwd "/home/globus"
	action :run
end

execute "cp rpm certs" do
	command "cp globus-simple-ca-*-1.0-1.el6.noarch.rpm"
	user "globus"
	cwd "/home/globus"
	action :run
end

#enviar el rpm a todos los esclavos
node[:slaves].each do |slave|
	execute "scp rpm certs #[slave]" do
		command "scp globus-simple-ca-*-1.0-1.el6.noarch.rpm vagrant@#[slave]:/tmp"
		user "vagrant"
		cwd "/home/vagrant"
		action :run
	end
end









#
# Cookbook Name:: simpleca
# Recipe:: second machine
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#agregando archivos necesarios
cookbook_file "/tmp/run-grid-ca-create.exp" do
	source "run-grid-ca-create.exp"
	owner "globus"
end

cookbook_file "/tmp/run-grid-ca-sign.exp" do
	source "run-grid-ca-sign.exp"
	owner "globus"
end

cookbook_file "/tmp/run-user-request.exp" do
	source "run-user-request.exp"
	owner "vagrant"
end

####################################################################################################
#example

template "/home/vagrant/a.rsl" do
          source "a.rsl.rb"
          mode 0755
          owner "vagrant"
          variables(
                  :host_name => "#{node[:host_name]}"
          )
  end

#################################################################################
#user cert

execute "mkdir .globus" do
	command "mkdir -p /home/vagrant/.globus"
	user "vagrant"
	cwd "/tmp"
	action :run
end

execute "mv usercert" do
	command "mv /home/vagrant/userkey.pem /home/vagrant/usercert.pem /home/vagrant/.globus/"
	user "vagrant"
	cwd "/home/vagrant"
	action :run
end


#################################################################################
#instalar certificados

execute "install certificates" do
	command "rpm -Uvh globus-simple-ca-b83525ab-1.0-1.el6.noarch.rpm"
	user "root"
	cwd "/tmp"
	action :run
end

#indicamos los certificados que seran usados para firmar
execute "certificados por defecto" do
	command "grid-default-ca -ca b83525ab"
	user "root"
	cwd "/tmp"
	action :run
end

#################################################################################
##hostcert2

#hostcert
execute "request host" do
	command "sudo grid-cert-request -host '#{node[:host_name]}' -force"
	user "vagrant"
	cwd "/tmp"
	action :run
end

#mover a tmp para que mg2 lo pueda recibir
execute "enviar requesthost" do
	command "cp /etc/grid-security/hostcert_request.pem /tmp"
	user "vagrant"
	cwd "/tmp"
	action :run
end
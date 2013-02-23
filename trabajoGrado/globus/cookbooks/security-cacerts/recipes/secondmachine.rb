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
  command "yum install -y myproxy"
  user "root"
  action :run  
end

#ususario que se le permitira acceder a la otra maquina
user "testing" do
  home "/home/testing"
  shell "/bin/bash"
  supports :manage_home => true
end


execute "installing myproxy" do
  command "yum install -y myproxy"
  user "root"
  action :run  
end


cookbook_file "/home/vagrant/get-file-server.exp" do
        source "get-file-server.exp"
        mode 0644
        owner "vagrant"
        #group "admin"
end

execute "copiando los certificados de mg" do
		    user "vagrant"
		    #group "admin"
		    cwd "/home/vagrant"
		    command "expect get-file-server.exp -u vagrant -p vagrant -h mg -s /etc/grid-security/certificates -l /tmp/certificates"
		    action :run
end

execute "copiando los certificados local" do
		    user "root"
		    #group "admin"
		    cwd "/tmp"
		    command "cp -r /tmp/certificates /etc/grid-security/certificates"
		    action :run
end

#dado que se ejcuta el setup-simpleca que usa el myproxy
#hacer un script como vagrant
#sudo -H -E -u myproxy myproxy-admin-addservice -c "mgwn1.globustest.org" -l mgwn1

#/O=Grid/OU=GlobusTest/OU=simpleCA-mg.globustest.org/OU=local/CN=mgwn1.globustest.org

#problemas al ejecutar
#myproxy-retrieve -s mg -k mgwn1.globustest.org -l mgwn1

#http://www.globus.org/toolkit/docs/5.2/5.2.2/gridftp/admin/#gridftp-config-security-firewalls


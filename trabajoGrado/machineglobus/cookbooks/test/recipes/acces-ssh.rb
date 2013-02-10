cookbook_file "/home/vagrant/configssh.exp" do
	source "configssh.exp"
	mode 0644
	owner "vagrant"
end


#se debe de cambiar depende de donde se esta corriendo y ejecutarlo desde el guest (centos) al host
#el comando seria el que se ejecute desde el host, dependiendo de la ip
#execute "send id_ssh" do
#        user "root"
#        cwd "/home/vagrant"
#        command "expect configssh.exp -u vagrant -p vagrant -o n -h #{node[:ipaddress]}"
#        action :run
#end


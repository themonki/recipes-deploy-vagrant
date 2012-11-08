#execute "install expect" do
#	user "root"
#	cwd "/tmp"
#	command "yum install -y expect"
#	action :run
#end

####################################################################
#modificacion del hostname de la red
execute "backup /etc/sysconfig/network" do
	user "root"
	cwd "/tmp"
	command "cp /etc/sysconfig/network /etc/sysconfig/network_backup"
	action :run
end

cookbook_file "/etc/sysconfig/network" do
	source "network"
	mode 0644
	owner "root"
end

###################################################################

#cambia el hostname
#template "/proc/sys/kernel/hostname" do
#	source "hostname.rb"
#	mode 0644
#	owner "root"
#	variables(
#		:host_name => "#{node[:host_name]}"
#	)
#end

execute "hostname update" do
	user "root"
	cwd "/tmp"
	command "hostname #{node[:host_name]}"
	action :run
end
##################################################################
#guarda la configuración anterior y actualiza los host conocidos para que sea siempre que se inicie el sistema
execute "backup /etc/hosts" do
	user "root"
	cwd "/tmp"
	command "cp /etc/hosts /etc/hosts_backup"
	action :run
end

template "/etc/hosts" do
	source "hosts.rb"
	mode 0755
	owner "root"
	variables(
		:host_name => "#{node[:host_name]}"
	)
end

#######################################################3

execute "install rsync" do
	user "root"
	cwd "/tmp"
	command "yum install -y rsync"
	action :run

end

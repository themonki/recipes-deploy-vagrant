#execute "install expect" do
#	user "root"
#	cwd "/tmp"
#	command "yum install -y expect"
#	action :run
#end

cookbook_file "/tmp/expect-5.44.1.15-4.el6.x86_64.rpm" do
	source "expect-5.44.1.15-4.el6.x86_64.rpm"
	mode 0644
	owner "root"
end

cookbook_file "/tmp/tcl-8.5.7-6.el6.x86_64.rpm" do
	source "tcl-8.5.7-6.el6.x86_64.rpm"
	mode 0644
	owner "root"
end

execute "instal tcl" do
	user "root"
	cwd "/tmp"
	command "yum install -y tcl*.rpm"
	action :run
end

execute "instal expect" do
	user "root"
	cwd "/tmp"
	command "yum install -y expect-*.rpm"
	action :run
end

####################################################################
#modificacion del hostname de la red
execute "backup /etc/sysconfig/network" do
	user "root"
	cwd "/tmp"
	command "cp /etc/sysconfig/network /etc/sysconfig/network_backup"
	action :run
end

#cookbook_file "/etc/sysconfig/network" do
#	source "network"
#	mode 0644
#	owner "root"
#end

template "/tmp/network" do
        source "network.rb"
        mode 0755
        owner "root"
        variables(
                :host_name => "#{node[:host_name]}",
		:ipgateway => "#{node[:ipgateway]}"
        )
end

execute "move network" do
	user "root"
	cwd "/tmp"
	command "mv network /etc/sysconfig/network"
	action :run
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
		:host_name => "#{node[:host_name]}",
		:ipaddress => "#{node[:ipaddress]}"
	)
end

##################################################################

execute "install rsync" do
	user "root"
	cwd "/tmp"
	command "yum install -y rsync"
	action :run

end
##################################################################
##instalando chef para evitar el prepare

cookbook_file "/tmp/chef-10.16.6-1.el6.x86_64.rpm" do
	source "chef-10.16.6-1.el6.x86_64.rpm"
	owner "root"
end

execute "install chef" do
	user "root"
	cwd "/tmp"
	command "rpm -Uvh chef-10.16.6-1.el6.x86_64.rpm"
	action :run

end


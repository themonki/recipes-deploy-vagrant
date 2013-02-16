#cookbook_file "/home/vagrant/archives.tgz" do
#	source "archives.tgz"
#	mode 0644
#	owner "vagrant"
#	#group "admin"
#end

#execute "tar" do
#	user "vagrant"
#	#group "admin"
#	cwd "/home/vagrant"
#	command "tar xfz archives.tgz"
#	action :run
#end

#execute "install package" do
#	user "root"
#	#group "admin"
#	cwd "/home/vagrant"
#	command "apt-get -o dir::cache=/home/vagrant install -y --force-yes libmpich1.0-dev libmpich-mpd1.0-dev libmpich-shmem1.0-dev mpich2 mpich2-doc john build-essential"
#	action :run
#end

##instalar expect

#ubuntu
#execute "install expect" do
#        user "root"
#        #group "admin"
#        cwd "/home/vagrant"
#        command "apt-get install -y --force-yes expect"
#        action :run
#end

cookbook_file "/home/vagrant/tcl8.5_8.5.11-1ubuntu1_amd64.deb" do
        source "tcl8.5_8.5.11-1ubuntu1_amd64.deb"
#cookbook_file "/home/vagrant/tcl8.5_8.5.11-1ubuntu1_i386.deb" do
#        source "tcl8.5_8.5.11-1ubuntu1_i386.deb"
        mode 0644
        owner "vagrant"
        #group "admin"				
end

cookbook_file "/home/vagrant/expect_5.45-2_i386.deb" do
        source "expect_5.45-2_i386.deb"
#cookbook_file "/home/vagrant/expect_5.45-2_i386.deb" do
#        source "expect_5.45-2_i386.deb"
        mode 0644
        owner "vagrant"
        #group "admin"
end

execute "install expect" do
        user "vagrant"
        #group "admin"
        cwd "/home/vagrant"
        #command "sudo dpkg -i tcl8.5_8.5.11-1ubuntu1_i386.deb"
				command "sudo dpkg -i tcl8.5_8.5.11-1ubuntu1_amd64.deb"
        action :run
				returns 1
end

execute "install expect" do
        user "vagrant"
        #group "admin"
        cwd "/home/vagrant"
        command "sudo dpkg -i expect_5.45-2_amd64.deb"
        #command "sudo dpkg -i expect_5.45-2_i386.deb"
        action :run
				returns 1
end

##enviando archivos de automatización de ips
template "/home/vagrant/send_host_local.exp" do
	source "send_host_local.exp.rb"
	mode 0644
	owner "vagrant"
	#group "admin"
	variables(
		:host_name => "#{node[:host_name]}",
		:ip_maquina_local => "#{node[:ip_maquina_local]}",
		:pass_maquina_local => "#{node[:pass_maquina_local]}",
		:user_maquina_local => "#{node[:user_maquina_local]}",
		:path_project_vagrant => "#{node[:path_project_vagrant]}"
	)
end

cookbook_file "/home/vagrant/configssh.exp" do
        source "configssh.exp"
        mode 0644
        owner "vagrant"
        #group "admin"
end


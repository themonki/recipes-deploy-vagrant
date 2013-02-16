#red hat centos
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

cookbook_file "/home/condor/configssh.exp" do
        source "configssh.exp"
        mode 0644
        owner "condor"
end

#dado que se desconocen no se puede realizar
#el user,host,pass es el de la maquina q se le quiere dar acceso (no la local)
#execute "get access ssh" do
#	user "condor"
#	cwd "/home/condor"
#	command	"expect configssh.exp -o y -h ip -u user -p pass"
#end

##instalar expect

#ubuntu
#execute "install expect" do
#        user "root"
#        group "admin"
#        cwd "/home/vagrant"
#        command "apt-get install -y --force-yes expect"
#        action :run
#end

#cookbook_file "/home/vagrant/tcl8.5_8.5.8-2_i386.deb" do
#        source "tcl8.5_8.5.8-2_i386.deb"
#        mode 0644
#        owner "vagrant"
#        group "admin"
#end

#cookbook_file "/home/vagrant/expect_5.45-2_i386.deb" do
#        source "expect_5.45-2_i386.deb"
#        mode 0644
#        owner "vagrant"
#        group "admin"
#end

#execute "install expect" do
#        user "vagrant"
#        group "admin"
#        cwd "/home/vagrant"
#        command "sudo dpkg -i tcl8.5_8.5.8-2_i386.deb"
#        action :run
#end

#execute "install expect" do
#        user "vagrant"
#        group "admin"
#        cwd "/home/vagrant"
#        command "sudo dpkg -i expect_5.45-2_i386.deb"
#        action :run
#end


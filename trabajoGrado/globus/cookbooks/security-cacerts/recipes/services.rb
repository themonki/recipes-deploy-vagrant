
#################################################################
#mantener los servicios levantados
#http://rm-rf.es/anadir-quitar-servicios-al-inicio-del-sistema-red-hat-centos/
# ver el archivo /etc/inittab

execute "chkconfig gram5" do
	command "chkconfig globus-gatekeeper on"
	user "root"
	cwd "/tmp"
	action :run
end	

execute "chkconfig globus-gridftp-server" do
	command "chkconfig globus-gridftp-server on"
	user "root"
	cwd "/tmp"
	action :run
end	

#execute "chkconfig globus-gridftp-sshftp" do
#	command "chkconfig globus-gridftp-sshftp on"
#	user "root"
#	cwd "/tmp"
#	action :run
#end	

#execute "chkconfig myproxy-server" do
#	command "chkconfig myproxy-server on"
#	user "root"
#	cwd "/tmp"
#	action :run
#end

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

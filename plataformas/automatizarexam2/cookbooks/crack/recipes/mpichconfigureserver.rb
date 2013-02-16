#se suben los archivos generados por los nodos con las ips respectivas

#template "/home/condor/.mpd.conf" do
#	source "mpd.conf.rb"
#	mode 0600
#	owner "condor"
#	variables(
#		:pass => "condor"
#	)
#end

#cookbook_file "/home/condor/mpd.hosts" do
#	source "mpd.hosts"
#	mode 0644
#	owner "condor"	
#end

cookbook_file "/etc/hosts" do
       source "hosts"
       mode 0755
       owner "root"
       #group "admin"
end

#####################################################
include_recipe "crack::getipadd"

##agregar a el hosts

execute "add hosts" do
        user "root"
        #group "admin"
        cwd "/home/vagrant"
        command "cat hosts >> /etc/hosts"
        action :run
end

##enviar el ssh a los nodos usando el script de expect configssh

#execute "send id pub" do
#        user "root"
#        #group "admin"
#        cwd "/home/vagrant"
#        command ""
#        action :run
#end


## enviar los archivos de hosts a los nodos 

#execute "send hosts" do
#        user "root"
#        #group "admin"
#        cwd "/home/vagrant"
#        command ""
#        action :run
#end

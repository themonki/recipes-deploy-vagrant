#se suben los archivos generados por los nodos con las ips respectivas

cookbook_file "/etc/hosts" do
       source "hosts"
       mode 0755
       owner "root"
       #group "admin"
end

#####################################################
include_recipe "confighost::getipadd"

##agregar a el hosts

execute "add hosts" do
        user "root"
        #group "admin"
        cwd "/home/vagrant"
        command "cat hosts >> /etc/hosts"
        action :run
end

## enviar los archivos de hosts a los nodos
cookbook_file "/home/vagrant/sendhostsssh.exp" do
       source "sendhostsssh.exp"
       mode 0755
       owner "vagrant"
       #group "admin"
end

node[:hostslaves].each do |slave|
		execute "send hosts" do
				    user "root"
				    #group "admin"
				    cwd "/home/vagrant"
				    command "expect sendhostsssh.exp -u vagrant -p vagrant -h #{slave}"
				    action :run
		end
end

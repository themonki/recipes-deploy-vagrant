#http://www.cyberciti.biz/faq/how-to-find-out-the-ip-address-assigned-to-eth0-and-display-ip-only/
#ifconfig eth2 | grep 'Direc. inet' | cut -d: -f2 | awk '{ print $1}'
#ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'

## se consulta la ip asignada
execute "get ip from ifconfig" do
	user "vagrant"
	#group "admin"
	cwd "/home/vagrant"
	command "/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}' >> ip"
	action :run
end
## se crea un archivo que contendra ip hostname alias (como el /etc/hosts)
execute "add ip" do
        user "vagrant"
        #group "admin"
        cwd "/home/vagrant"
        command 'cat ip >> hosts_tmp'
        action :run
end
execute "add hostname alias" do
        user "vagrant"
        #group "admin"
        cwd "/home/vagrant"
        command "echo  #{node[:host_name]} #{node[:alias]}  >> hosts_tmp"
        action :run
end

## se quitan saltos de linea
execute "quitar salos de linea" do
        user "vagrant"
        #group "admin"
        cwd "/home/vagrant"
        command "sed -n -e '1x;1!H;\${x;s-\\n- -gp}' hosts_tmp > hosts"
        action :run
end

###se crea para el archivo mpd.host

#execute "get cores" do
#        user "vagrant"
#        #group "admin"
#        cwd "/home/vagrant"
#        command "cat /proc/cpuinfo | grep processor | wc -l > core"
#        action :run
#end

#execute "combinar ip core" do
#        user "vagrant"
#        #group "admin"
#        cwd "/home/vagrant"
#        command "cat ip > mpd_host_tmp; echo : >> mpd_host_tmp ; cat core >> mpd_host_tmp"
#        action :run
#end

#execute "quitar espacios y saltos de linea" do
#        user "vagrant"
#        #group "admin"
#        cwd "/home/vagrant"
#        command "sed -n -e '1x;1!H;\${x;s-\\n- -gp}' mpd_host_tmp | sed -e 's: ::' | sed -e 's: ::' >> mpd.hosts"
#        action :run
#end

template "/home/condor/.mpd.conf" do
	source "mpd.conf.rb"
	mode 0600
	owner "condor"
	variables(
		:pass => "condor"
	)
end

cookbook_file "/home/condor/mpd.hosts" do
	source "mpd.hosts"
	mode 0644
	owner "condor"	
end

## agregar la ip a mpd.hosts

#http://www.cyberciti.biz/faq/how-to-find-out-the-ip-address-assigned-to-eth0-and-display-ip-only/
#ifconfig eth2 | grep 'Direc. inet' | cut -d: -f2 | awk '{ print $1}'
#ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'

## se consulta la ip asignada
execute "get ip from ifconfig" do
        user condor
        group admin
        pwd "/home/condor"
        command "ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}' > ip"
        action :run
end


execute "add cores" do
        user condor
        group admin
        pwd "/home/condor"
        command "echo ":2" >> ip"
        action :run
end

## se quitan saltos de linea y el espacio y se adiciona a mpd.hostsmpd.hosts
execute "quitar salos de linea" do
        user condor
        group admin
        pwd "/home/condor"
	command "sed -n -e '1x;1!H;${x;s-\n- -gp}' ip | sed -e 's: ::' >> mpd.hosts"
        action :run
end


##agregar a el hosts

execute "add hosts" do
        user root
        group admin
        pwd "/home/condor"
        command "cat hosts >> /etc/hosts"
        action :run
end

##enviar el ssh a los nodos usando el script de expect configssh

execute "send id pub" do
        user root
        group admin
        pwd "/home/condor"
        command ""
        action :run
end


## enviar los archivos de hosts a los nodos 

execute "send hosts" do
        user root
        group admin
        pwd "/home/condor"
        command ""
        action :run
end


##

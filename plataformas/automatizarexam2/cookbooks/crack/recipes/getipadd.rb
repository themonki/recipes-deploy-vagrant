#http://www.cyberciti.biz/faq/how-to-find-out-the-ip-address-assigned-to-eth0-and-display-ip-only/
#ifconfig eth2 | grep 'Direc. inet' | cut -d: -f2 | awk '{ print $1}'
#ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'

## se consulta la ip asignada
execute "get ip from ifconfig" do
	user condor
	group admin
	pwd "/home/condor"
	command "ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}' >> ip"
	action :run
end
## se crea un archivo que contendra ip hostname alias (como el /etc/hosts)
execute "add ip" do
        user condor
        group admin
        pwd "/home/condor"
        command 'cat ip >> hosts_tmp'
        action :run
end
execute "add hostname alias" do
        user condor
        group admin
        pwd "/home/condor"
        command 'echo " #{node[:host_name]} #{node[:alias]} " >> hosts_tmp'
        action :run
end

## se quitan saltos de linea
execute "quitar salos de linea" do
        user condor
        group admin
        pwd "/home/condor"
        command "sed -n -e '1x;1!H;${x;s-\n- -gp}' host_tmp > hosts"
        action :run
end

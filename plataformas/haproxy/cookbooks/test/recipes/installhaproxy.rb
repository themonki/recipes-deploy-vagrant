#instalar HAproxy
##http://www.leaseweblabs.com/2011/07/high-availability-load-balancing-using-haproxy-on-ubuntu-part-1/

#actualizar la lista de paquetes
execute "apt update" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "apt-get update"
	action :run
end

##instalar haproxy
execute "install-haproxy" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "apt-get install -y --force-yes haproxy"
	action :run
end

##mover el archivo de configuracion por defecto
execute "move cfg default" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "mv /etc/haproxy/haproxy.cfg /etc/haproxy/backup_haproxy.cfg"
	action :run
end

##mover el nuevo archivo de configuración
cookbook_file "/etc/haproxy/haproxy.cfg" do
	source "haproxy.cfg"
	mode 0644
	owner "root"
	group "admin"
end

##habilitar haproxy
##se quita la linea y se guarda en tmp
#execute "sed quitar #" do
#	user "root"
#	group "admin"
#	cwd "/tmp"
#	command "sed -e 's:#\(ENABLED=1\):\1:' /etc/default/haproxy > /tmp/haproxy"
#	action :run
#end
##se quita la linea y se guarda en tmp
execute "sed quitar #" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "sed -e 's:ENABLED=0:ENABLED=1:' /etc/default/haproxy > /tmp/haproxy"
	action :run
end
##se reemplaza
execute "mv haproxy" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "mv /tmp/haproxy /etc/default/haproxy"
	action :run
end

##iniciar el servicio
##se reemplaza
execute "start haproxy" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "/etc/init.d/haproxy start"
	action :run
end

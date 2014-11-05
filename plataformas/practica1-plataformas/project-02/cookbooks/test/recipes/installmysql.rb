execute "apt-get update" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "apt-get update"
	action :run
end


#
# https://help.ubuntu.com/community/ApacheMySQLPHP
#
# se adiciona la version porque intentaba descargar un paquete que ya no existe
#
package "mysql-server" do
	version '5.5.40-0ubuntu0.12.04.1'
	action :install
end


#
# https://help.ubuntu.com/8.04/serverguide/C/mysql.html
#
execute "sed" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "sed -e 's/^bind.*/bind-address = 172.18.0.2/' /etc/mysql/my.cnf > /tmp/my.cnf"
	action :run
end

execute "move my.cnf" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "mv /tmp/my.cnf /etc/mysql/my.cnf"
	action :run
end

execute "restart-mysql" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "/etc/init.d/mysql restart"
	action :run
end

cookbook_file "/tmp/script.sql" do
	source "script.sql"
	mode 0644
	owner "root"
	group "admin"
end

execute "init database" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "cat script.sql | mysql -u root"
	action :run
end


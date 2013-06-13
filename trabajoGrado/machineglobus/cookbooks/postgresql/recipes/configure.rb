#configuracion y levantamiento del servicio apache


execute "start psql" do
	command "service postgresql initdb"
	user "root"
	cwd "/tmp"
	action :run  
end

execute "chkconfig apache" do
	command "chkconfig postgresql on"
	user "root"
	cwd "/tmp"
	action :run  
end

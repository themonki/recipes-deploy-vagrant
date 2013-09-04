#configuracion y levantamiento del servicio apache

cookbook_file "/tmp/pass.sql" do
	source "pass.sql"
	owner "postgres"
end

cookbook_file "/tmp/changepasspsql.exp" do
	source "changepasspsql.exp"
	owner "root"
end

execute "initdb psql" do
	command "service postgresql initdb"
	user "root"
	cwd "/tmp"
	action :run  
end

execute "chkconfig postgresql" do
	command "chkconfig postgresql on"
	user "root"
	cwd "/tmp"
	action :run  
end

execute "start psql" do
	command "service postgresql start"
	user "root"
	cwd "/tmp"
	action :run  
end

execute "pass sql" do
	command "su postgres -c 'psql -f /tmp/pass.sql'"
	user "root"
	cwd "/tmp"
	action :run  
end

execute "pass psql" do
	command "expect changepasspsql.exp -p dbpsglobus2013"
	user "root"
	cwd "/tmp"
	action :run  
end

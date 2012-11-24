
user "condor" do
	not_if "id cluster"
	comment "condor user"
	uid 600
	gid "admin"
	home "/home/condor"
	password "$6$C2weA1pz$916p30.xjqp7xevuM74TOV5ypaz1xLQpKaMYIgHCYOb0GNRYK3KBLhCeKmD28F.QriqR48A7JLL7etQlj9kkz/" # "condor"
	shell "/bin/bash"
	supports :manage_home => true
end

execute "configure user" do
	user "root"
	group "admin"
	cwd "/tmp"
	command 'sudo su - condor -c "mkdir /home/condor/bin;export PATH=/home/condor/bin:$PATH"'
	action :run	
end

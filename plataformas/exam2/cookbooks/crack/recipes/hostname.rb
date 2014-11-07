cookbook_file "/etc/hosts" do
	source "hosts"
	mode 0755
	owner "root"
	group "admin"
end

execute "hostname-stop" do
	user "root"
	group "admin"
	command "service hostname stop"
	action :run
	# http://help.opscode.com/discussions/problems/732-bash-non-zero-exit-status
	returns 1
end

template "/etc/hostname" do
	source "hostname.rb"
	mode 0644
	owner "root"
	group "admin"
	variables(
		:host_name => "#{node[:host_name]}"
	)
end

execute "hostname-start" do
	user "root"
	group "admin"
	command "service hostname start"
	action :run
end

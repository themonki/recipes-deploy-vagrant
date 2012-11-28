cookbook_file "/tmp/id_rsa.pub" do
	source "id_rsa.pub"
	mode 0600
	owner "vagrant"
	group "vagrant"
end
execute "concat" do
	user "vagrant"
	group "vagrant"
	cwd "/tmp"
	command "cat id_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
	action :run
end

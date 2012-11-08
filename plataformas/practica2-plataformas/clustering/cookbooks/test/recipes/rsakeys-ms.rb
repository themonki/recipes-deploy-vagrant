cookbook_file "/home/vagrant/.ssh/id_rsa" do
	source "id_rsa"
	mode 0600
	owner "vagrant"
	group "vagrant"
end
cookbook_file "/home/vagrant/.ssh/id_rsa.pub" do
	source "id_rsa.pub"
	mode 0644
	owner "vagrant"
	group "vagrant"
end

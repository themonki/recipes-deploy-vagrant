directory "/var/tmp/parajava" do
	owner "vagrant"
	group "vagrant"
	mode "0755"
	action :create
end
cookbook_file "/var/tmp/parajava/pj.jar" do
	source "pj.jar"
	mode 0666
	owner "vagrant"
	group "vagrant"
end
cookbook_file "/var/tmp/parajava/scheduler.conf" do
	source "scheduler.conf"
	mode 0666
	owner "vagrant"
	group "vagrant"
end

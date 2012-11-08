include_recipe	 "test::settingupfiles"

execute "install worker" do
	user "root"
	group "admin"
	cwd "/tmp/condor"
	command "bash install.bash -t e -c master.cluster.org -p /usr -u condor -b -s"
	action :run
end


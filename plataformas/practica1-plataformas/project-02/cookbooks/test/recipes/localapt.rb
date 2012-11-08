execute "add line" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "echo '#Acquire::http::Proxy \"http:172.17.9.4:3128\";'>> /etc/apt/apt.conf"
	action :run
end

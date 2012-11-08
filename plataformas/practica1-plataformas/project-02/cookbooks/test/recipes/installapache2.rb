#
# https://help.ubuntu.com/community/ApacheMySQLPHP
#
#package "apache2" do
#	action :install
#end

execute "move gpg" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "mv /var/lib/apt/lists/*.gpg /tmp"
	action :run
end

execute "remove aptlists" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "rm -rf /var/lib/apt/lists/*"
	action :run
end

execute "create partial" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "mkdir /var/lib/apt/lists/partial"
	action :run
end

execute "move back gpg" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "mv /tmp/*.gpg /var/lib/apt/lists/"
	action :run
end

execute "apt update" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "apt-get update"
	action :run
end

execute "install-apache" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "apt-get install -y --force-yes apache2 libapache2-mod-php5 libapache2-mod-auth-mysql php5-mysql"
	action :run
end

execute "restart-apache" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "/etc/init.d/apache2 restart"
	action :run
end

cookbook_file "/var/www/phpinfo.php" do
	source "phpinfo.php"
	mode 0644
	owner "root"
	group "admin"
end

cookbook_file "/var/www/select.php" do
	source "select.php"
	mode 0644
	owner "root"
	group "admin"
end

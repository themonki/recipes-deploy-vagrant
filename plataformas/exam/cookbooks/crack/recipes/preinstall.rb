cookbook_file "/home/vagrant/archives.tgz" do
	source "archives.tgz"
	mode 0644
	owner "vagrant"
	group "admin"
end

execute "tar" do
	user "vagrant"
	group "admin"
	cwd "/home/vagrant"
	command "tar xfz archives.tgz"
	action :run
end

execute "install package" do
	user "root"
	group "admin"
	cwd "/home/vagrant"
	command "apt-get -o dir::cache=/home/vagrant install -y --force-yes libmpich1.0-dev libmpich-mpd1.0-dev libmpich-shmem1.0-dev mpich2 mpich2-doc john build-essential"
	action :run
end



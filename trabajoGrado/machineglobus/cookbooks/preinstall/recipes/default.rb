##instalar las dependencias necesarias para instalar globus
## solo para CentOS-6.3-x86_64-minimal
##esta receta se aplica solo al mg

class Chef
 	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?

		cookbook_file "/tmp/reposPreinstall.tar.gz" do
			source "reposPreinstall.tar.gz"
			owner "vagrant"
		end

		execute "unpack reposPreinstall" do
			command "tar -xvzf reposPreinstall.tar.gz"
			user "vagrant"
			cwd "/tmp"
			action :run  
		end

		execute "update dependencies" do
			command "yum update -y perl-*.rpm"
			user "root"
			cwd "/tmp/reposPreinstall/Pglobus-gram5-x86_64"
			action :run  
		end

		execute "install dependencies" do
			command "yum install -y cups-*.rpm poppler-*.rpm \
		foomatic-*.rpm gtk2*.rpm\
		iso-codes-*.rpm mesa-dri-drivers-*.rpm\
		mesa-dri1-drivers-*.rpm qt-*.rpm\
		qt3-*.rpm urw-fonts-*.rpm\
		ghostscript-*.rpm qt-*.rpm\
		urw-fonts-*.rpm"
			user "root"
			cwd "/tmp/reposPreinstall/Pglobus-gram5-x86_64"
			action :run  
		end
	end
end




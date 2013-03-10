#http://wiki.opscode.com/display/chef/Recipes
#http://www.ruby-doc.org/gems/docs/c/chef-extensions-0.4.0/Chef/Extensions/Platform.html
#http://docs.opscode.com/chef/dsl_recipe.html
#http://wiki.opscode.com/display/chef/Libraries

class Chef
 	include Extensions::Platform
end

if platform?("ubuntu")
	if Extensions::Platform.i386?
		cookbook_file "/home/vagrant/tcl8.5_8.5.11-1ubuntu1_i386.deb" do
			      source "tcl8.5_8.5.11-1ubuntu1_i386.deb"
				    mode 0644
				    owner "vagrant"
				    #group "admin"				
		end
		
		cookbook_file "/home/vagrant/expect_5.45-2_i386.deb" do
				source "expect_5.45-2_i386.deb"
      	mode 0644
        owner "vagrant"
        #group "admin"
		end
	end

	if Extensions::Platform.amd64?
		cookbook_file "/home/vagrant/tcl8.5_8.5.11-1ubuntu1_amd64.deb" do
				    source "tcl8.5_8.5.11-1ubuntu1_amd64.deb"
				    mode 0644
				    owner "vagrant"
				    #group "admin"				
		end

		cookbook_file "/home/vagrant/expect_5.45-2_amd64.deb" do
        source "expect_5.45-2_amd64.deb"
        mode 0644
        owner "vagrant"
        #group "admin"
		end	
	end

		execute "install tlc" do
				    user "root"
				    #group "admin"
				    cwd "/home/vagrant"
						command "dpkg -i tcl*.deb"
				    action :run
		end
		execute "install expect" do
				    user "root"
				    #group "admin"
				    cwd "/home/vagrant"
				    command "dpkg -i expect*.deb"
				    action :run
		end
end

if platform?("redhat", "centos", "fedora")
 
	
	if Extensions::Platform.i386?
		cookbook_file "/home/vagrant/tcl-8.5.7-6.el6.i686.rpm" do
				    source "tcl-8.5.7-6.el6.i686.rpm"
				    mode 0644
				    owner "vagrant"
				    #group "admin"				
		end

		cookbook_file "/home/vagrant/expect-5.44.1.15-4.el6.i686.rpm" do
        source "expect-5.44.1.15-4.el6.i686.rpm"
        mode 0644
        owner "vagrant"
        #group "admin"
		end
		
		cookbook_file "/home/vagrant/rsync-3.0.6-9.el6.i686.rpm" do
        source "rsync-3.0.6-9.el6.i686.rpm"
        mode 0644
        owner "vagrant"
        #group "admin"
		end		

	end

	if Extensions::Platform.amd64?
		cookbook_file "/home/vagrant/tcl-8.5.7-6.el6.x86_64.rpm" do
				    source "tcl-8.5.7-6.el6.x86_64.rpm"
				    mode 0644
				    owner "vagrant"
				    #group "admin"				
		end

		cookbook_file "/home/vagrant/expect-5.44.1.15-4.el6.x86_64.rpm" do
        source "expect-5.44.1.15-4.el6.x86_64.rpm"
        mode 0644
        owner "vagrant"
        #group "admin"
		end
		
		cookbook_file "/home/vagrant/rsync-3.0.6-9.el6.x86_64.rpm" do
        source "rsync-3.0.6-9.el6.x86_64.rpm"
        mode 0644
        owner "vagrant"
        #group "admin"
		end

	end

		execute "install tlc" do
				    user "root"
				    #group "admin"
				    cwd "/home/vagrant"
						command "yum install -y tcl*.rpm"
				    action :run
		end
		execute "install expect" do
				    user "root"
				    #group "admin"
				    cwd "/home/vagrant"
				    command "yum install -y expect-*.rpm"
				    action :run
		end
		execute "install rsync" do
	          user "root"
	          cwd "/home/vagrant"
	          command "yum install -y rsync*.rpm"
	          action :run

    end 
end

cookbook_file "/home/vagrant/configssh.exp" do
        source "configssh.exp"
        mode 0644
        owner "vagrant"
        #group "admin"
end


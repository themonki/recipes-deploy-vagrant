
##instalando chef para evitar el prepare


#http://wiki.opscode.com/display/chef/Recipes
#http://www.ruby-doc.org/gems/docs/c/chef-extensions-0.4.0/Chef/Extensions/Platform.html
#http://docs.opscode.com/chef/dsl_recipe.html
#http://wiki.opscode.com/display/chef/Libraries

class Chef
 	include Extensions::Platform
end

if platform?("redhat", "centos", "fedora")
	if Extensions::Platform.amd64?
		cookbook_file "/tmp/chef-10.16.6-1.el6.x86_64.rpm" do
			source "chef-10.16.6-1.el6.x86_64.rpm"
			owner "root"
		end

		execute "install chef" do
			user "root"
			cwd "/tmp"
			command "rpm -Uvh chef-10.16.6-1.el6.x86_64.rpm"
			action :run

		end
	end
end


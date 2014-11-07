cookbook_file "/home/hduser/ssh-copy-id.ext" do
	source "ssh-copy-id.ext"
	mode 0755
	owner "hduser"
	group "hadoop"
end
["slave01", "slave02", "slave03", "master-2"].each do |slave|
	execute "enable ssh access" do
		user "hduser"
		group "hadoop"
		cwd "/home/hduser"
		command "./ssh-copy-id.ext #{slave} hduser hduser"
		action :run
	end
end

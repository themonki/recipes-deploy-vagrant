template "/home/condor/.mpd.conf" do
	source "mpd.conf.rb"
	mode 0600
	owner "condor"
	variables(
		:pass => "condor"
	)
end

cookbook_file "/home/condor/mpd.hosts" do
	source "mpd.hosts"
	mode 0644
	owner "condor"	
end

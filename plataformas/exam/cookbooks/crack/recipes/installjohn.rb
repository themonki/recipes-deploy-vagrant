cookbook_file "/home/condor/john-1.7.2-bp17-mpi8.tar.gz" do
	source "john-1.7.2-bp17-mpi8.tar.gz"
	mode 0644
	owner "condor"
end

execute "tar" do
	user "condor"
	cwd "/home/condor"
	command "tar xfz john-1.7.2-bp17-mpi8.tar.gz"
	action :run
end

execute "make john" do
	user "condor"
	cwd "/home/condor/john-1.7.2-bp17-mpi8/src"
	command "make"
	action :run
end

execute "make clean john" do
	user "condor"
	cwd "/home/condor/john-1.7.2-bp17-mpi8/src"
	command "make clean linux-x86-sse2"
	action :run
end

execute "mv bin" do
	user "condor"
	cwd "/home/condor/john-1.7.2-bp17-mpi8/src"
	command "mv ../run/* /home/condor/bin"
	action :run
end

#source files
cookbook_file "/home/condor/calc_sine.c" do
	source "calc_sine.c"
	owner "condor"
	group "admin"
	mode 0755
	
end

cookbook_file "/home/condor/calc_cosine.c" do
	source "calc_cosine.c"
	mode 0755
	owner "condor"
	group "admin"
end

cookbook_file "/home/condor/collect.c" do
	source "collect.c"
	mode 0755
	owner "condor"
	group "admin"
end
#condor cluster 
cookbook_file "/home/condor/sin.condor" do
	source "sin.condor"
	mode 0755
	owner "condor"
	group "admin"
end


cookbook_file "/home/condor/cos.condor" do
	source "cos.condor"
	mode 0755
	owner "condor"
	group "admin"
end


cookbook_file "/home/condor/collect.condor" do
	source "collect.condor"
	mode 0755
	owner "condor"
	group "admin"
end
#executable
cookbook_file "/home/condor/sin" do
	source "sin"
	mode 0755
	owner "condor"
	group "admin"
end


cookbook_file "/home/condor/cos" do
	source "cos"
	mode 0755
	owner "condor"
	group "admin"
end


cookbook_file "/home/condor/collect" do
	source "collect"
	mode 0755
	owner "condor"
	group "admin"
end

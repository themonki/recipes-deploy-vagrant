#source files
cookbook_file "/home/condor/calc_sine.c" do
	source "calc_sine.c"
	owner "condor"
	group "admin"
	mode 0755
	
end

cookbook_file "/home/condor/calc_sine2.c" do
	source "calc_sine2.c"
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

cookbook_file "/home/condor/calc_cosine2.c" do
	source "calc_cosine2.c"
	mode 0755
	owner "condor"
	group "admin"
end

cookbook_file "/home/condor/calc_degree.c" do
	source "calc_degree.c"
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


cookbook_file "/home/condor/cos2.condor" do
	source "cos2.condor"
	mode 0755
	owner "condor"
	group "admin"
end

cookbook_file "/home/condor/sin2.condor" do
	source "sin2.condor"
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

cookbook_file "/home/condor/degree.condor" do
	source "degree.condor"
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


cookbook_file "/home/condor/cos2" do
	source "cos2"
	mode 0755
	owner "condor"
	group "admin"
end

cookbook_file "/home/condor/sin2" do
	source "sin2"
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

cookbook_file "/home/condor/degree" do
	source "degree"
	mode 0755
	owner "condor"
	group "admin"
end

#dagman
cookbook_file "/home/condor/composetask.dag" do
	source "composetask.dag"
	mode 0755
	owner "condor"
	group "admin"
end

cookbook_file "/home/condor/composetask2.dag" do
	source "composetask2.dag"
	mode 0755
	owner "condor"
	group "admin"
end

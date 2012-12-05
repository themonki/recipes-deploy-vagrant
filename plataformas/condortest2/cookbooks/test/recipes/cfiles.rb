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

cookbook_file "/home/condor/sum.c" do
        source "sum.c"
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


cookbook_file "/home/condor/sum.condor" do
        source "sum.condor"
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


cookbook_file "/home/condor/sum" do
        source "sum"
        mode 0755
        owner "condor"
        group "admin"
end

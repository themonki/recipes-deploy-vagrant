#user "visitor" do
#	not_if "id cluster"
#	comment "condor user"
#	uid 600
#	gid "admin"
#	home "/home/condor"
#	password "$6$fyR8mKK/$dUgKsAGAIzgUnFn49GQaw8fDL1IW9ocwEXSAI74LrrYk.f.GuLp.UQilrV7/5YUrcUwMxpO3CgMdw2PHHA4hs0" # "visitor 2012"
#	shell "/bin/bash"
#	supports :manage_home => true
#end

#user "condor" do
#	home "/home/condor"
#	shell "/bin/bash"
#	supports :manage_home => true
#end

user "condor" do
	not_if "id cluster"
	comment "condor user"
	uid 600
	gid "admin"
	home "/home/condor"
	password "$6$C2weA1pz$916p30.xjqp7xevuM74TOV5ypaz1xLQpKaMYIgHCYOb0GNRYK3KBLhCeKmD28F.QriqR48A7JLL7etQlj9kkz/" # "condor" 
	shell "/bin/bash"
	supports :manage_home => true
end

user "visitor" do
	not_if "id cluster"
	comment "condor user"
	uid 600
	gid "admin"
	home "/home/condor"
	password "$6$fyR8mKK/$dUgKsAGAIzgUnFn49GQaw8fDL1IW9ocwEXSAI74LrrYk.f.GuLp.UQilrV7/5YUrcUwMxpO3CgMdw2PHHA4hs0" # "visitor 2012"
	shell "/bin/bash"
	supports :manage_home => true
end

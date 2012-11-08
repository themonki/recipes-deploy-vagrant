#http://www.cyberciti.biz/tips/execute-commands-on-multiple-hosts-using-expect-tool-part-iii.html

execute "install expect" do
	user "root"
	cwd "/tmp"
	command "yum -install -y expect expectk"
	action :run
end

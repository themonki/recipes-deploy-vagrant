

#enviar el los certs user de vagrant
node[:slaves].each do |slave|
	execute "sign cert #{slave}" do
		command "sudo -H -E -u globus expect run-grid-ca-sign.exp -in #{slave}-hostcert_request.pem -out #{slave}-hostsigned.pem"
		user "vagrant"
		cwd "/tmp"
		action :run
	end
end

#enviar el los certs user de vagrant
node[:slaves].each do |slave|
	execute "scp cert #{slave}" do
		command "scp #{slave}-hostsigned.pem vagrant@#{slave}:/tmp"
		user "vagrant"
		cwd "/tmp"
		action :run
	end
end

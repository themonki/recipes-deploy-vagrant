

#enviar el firmado
execute "eliminar certificado host" do
	command "rm -rf /etc/grid-security/hostcert.pem"
	user "root"
	cwd "/tmp"
	action :run
end

#enviar el firmado
execute "copiar certificado host firmado" do
	command "cp /tmp/#{node[:alias]}hostsigned.pem /etc/grid-security/hostcert.pem"
	user "root"
	cwd "/tmp"
	action :run
end

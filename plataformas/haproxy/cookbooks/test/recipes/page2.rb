execute "pagina 2" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "echo 'Hola soy la maquina 2' > /var/www/page.php"
	action :run
end

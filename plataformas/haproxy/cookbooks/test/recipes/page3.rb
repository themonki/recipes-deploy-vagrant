execute "pagina 3" do
	user "root"
	group "admin"
	cwd "/tmp"
	command "echo 'Hola soy la maquina 3' > /var/www/page.php"
	action :run
end

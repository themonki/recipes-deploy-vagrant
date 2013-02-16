include_recipe "crack::getipadd"

#enviar los host a la maquina local
execute "install package" do
        user "vagrant"
        #group "admin"
        cwd "/home/vagrant"
        command "expect send_host_local.exp"
        action :run
end


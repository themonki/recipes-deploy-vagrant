include_recipe "crack::getipadd"

#enviar los host a la maquina local
execute "install package" do
        user "condor"
        group "admin"
        cwd "/home/condor"
        command "expect send_host_local.exp"
        action :run
end


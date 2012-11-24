#enviar los host a la maquina local
execute "install package" do
        user "condor"
        group "admin"
        cwd "/home/condor"
        command "expect send_host_local"
        action :run
end


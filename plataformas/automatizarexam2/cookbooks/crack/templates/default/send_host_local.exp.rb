#!/usr/bin/expect

#script que envia el archivo host generado en el usuario condor
# a la maquina local para luego ser leido por el server o master

set ipmaquinalocal "<%= @ip_maquina_local %>"
set pass "<%= @pass_maquina_local %>"
set user "<%= @user_maquina_local %>"
set path "<%= @path_project_vagrant %>" 
#el path de coockbook/files/default


#debe de existir el tmp en donde este el path
spawn scp hosts $user@$ipmaquinalocal:$path/tmp

expect {
	"*connecting (yes/no)?" {
		send "yes\r"
		exp_continue
	} #primera vez
	"*assword:" {		
		send "$pass\r"
		expect "expecting."
		send_user "pass enviado\n"				
	}

	
}
#se agrega el host de la maquina al archivo hosts q se envia al server
spawn ssh $user@$ipmaquinalocal cat $path/tmp/hosts >> $path/hosts 

expect {
	"*connecting (yes/no)?" {
                send "yes\r"
                exp_continue
        } #primera vez
	"*assword:" {           
                send "$pass\r"
                expect "expecting."
                send_user "pass enviado\n"
        }

}

#se toma el archivo con el mpdhost format
spawn scp mpd.hosts $user@$ipmaquinalocal:$path/tmp

expect {
        "*connecting (yes/no)?" {
                send "yes\r"
                exp_continue
        } #primera vez
        "*assword:" {
                send "$pass\r"
                expect "expecting."
                send_user "pass enviado\n"
        }

}


#se agrega el el ip al archivo de configuracion de mpd para el server
spawn ssh $user@$ipmaquinalocal cat $path/tmp/mpd.hosts  >> $path/mpd.hosts

expect {
        "*connecting (yes/no)?" {
                send "yes\r"
                exp_continue
        } #primera vez
        "*assword:" {
                send "$pass\r"
                expect "expecting."
                send_user "pass enviado\n"
        }

}
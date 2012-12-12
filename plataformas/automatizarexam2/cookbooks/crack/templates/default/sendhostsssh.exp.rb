#!/usr/bin/expect

	
	set timeout 300
	set user    ""
        set host        ""
        set pass        ""
	set sizeargv	[llength $argv]

if { $sizeargv == 2 || $sizeargv == 4 || $sizeargv == 6} {
	for {set i 0} {$i < [llength $argv]} {incr i 2} {
        	set argvtmp [lindex $argv $i];
	        if {$argvtmp == "-u"} { #username
                	set index [expr $i+1];
        	        set user [lindex $argv $index];
	        } elseif {$argvtmp == "-p"} {#pass
                	set index  [expr $i+1];
        	        set pass  [lindex $argv $index];
	        } elseif {$argvtmp == "-h"} {#host
                	set index  [expr $i+1];
        	        set host  [lindex $argv $index];
		}
	}
} else {
	#send_user "Error parametros incompletos\n"
        send_user "Uso: expect sendhostsssh.exp -u username -p pass -h host\n"
        #exit 1
}

if {$user  ==  "" && $host == ""} {
        send_user "finalizado\n"
        exit
}

##enviar archivo host al usuario indicado
spawn scp /etc/hosts $user@$host:/home/$user/

expect {
	"*connecting (yes/no)?" {
                send "yes\r"
                exp_continue
        }
	"*assword:" {
                send "$pass\r"
                expect "$ "
                send_user "archivo enviado\n"
        }
	"$ "{
		send_user "archivo enviado\n"
	
	}
}
##acceder como ssh
spawn ssh -q $user@$host

expect "*assword:"
send "$pass\r"
expect "$user@" 
send "sudo cp /home/$user/hosts /etc/hosts\r"
send_user "\nactualizando host\n"
#expect {
#	"*assword:"{
 #       	send "$pass\r"
#		exp_continue
#	}
#	"sudo: unable*"{
#		exp_continue
#	}
#	"$user@"{
#		send_user "realizado\n"
#	}
#}
expect "$user@"
send_user "\nrealizado\n"
send "exit\r"        		

exit
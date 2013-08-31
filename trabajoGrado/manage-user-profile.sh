#!/bin/bash

PATH_PROFILE=machineglobus/cookbooks/confighost/attributes
#echo $PATH_PROFILE
PATH_SCRIPT=$(dirname $(readlink -f $0))
#echo $PATH_SCRIPT
PATH_FILES=machineglobus/cookbooks/confighost/files/default
#echo $PATH_FILES
export PATH_CONFIGHOST=$PATH_SCRIPT/$PATH_FILES
#echo $PATH_CONFIGHOST
IP="172.18.0.1"
#echo $IP

function print_help { 
											printf '%s\n' "";
											printf '%s\n' "user-profile: permite administrar el archivo machineglobus/cookbooks/confighost"
											printf '%s\n' "/attributes/default.rb y crear otros perfiles.";
											printf '%s\n' "" ;
											printf '\t%s\n' "Uso:" ;
											printf '\t%s\n' "user-profile.sh [-h] [-l] [-c [OpcionesCrear [<args>]] ] [Opciones [<args>]] " ;
											printf '%s\n' "" ;
											printf '\t\t%s\n' "-c	indica que se crea un nuevo perfil. Ver Opciones para Crear."
											printf '\t\t%s\n' "-l	muestra la lista de perfiles"
											printf '\t\t%s\n' "-h	imprime esta ayuda."   ;
											printf '%s\n' "" ;
											printf '\t%s\n' "Opciones:" ;
											printf '%s\n' "" ;
											printf '\t\t%s\n' "-d	NAME indica que se borrara un perfil"
											printf '\t\t%s\n' "-e	NAME indica que se usara dicho perfil"
											printf '\t\t%s\n' "-s	NAME muestra el contenido del perfil"
											printf '%s\n' "" ;
											printf '\t%s\n' "Opciones para Crear:" ;
											printf '%s\n' ""
											printf '\t\t%s\n' "-n	NAME indica el nombre del perfil"
											printf '\t\t%s\n' "-i	IP indica el la ip del equipo actual del perfil. Por defecto 172.18.0.1."
											printf '\t\t%s\n' "-p	PASS indica el PASS del USER"
											printf '\t\t%s\n' "-u	USER indica el USER de la maquina actual"
											printf '%s\n' "" ;
										} 

function print_error	{
												printf '%s\n' "";
												printf '%s\n' "Error: Parámetros incorrectos.";
												print_help;
											}
function print_list	{
												ls -l $PATH_PROFILE/*.rb;
												exit 0;
											}

function print_show	{
												cat $PATH_PROFILE/$NAME.rb;
												exit 0;
											}
function delete_profile {
												if [ $NAME = "default" ] || [ $NAME = "default-release" ]; then
													printf '%s\n' "";
													printf '%s\n' "No se puede borrar el perfil $NAME.";
													printf '%s\n' "";
													exit 0;
												fi
												rm -rf $PATH_PROFILE/$NAME.rb;
												exit 0;

											}
function election_profile {
												echo $PATH_PROFILE/$NAME.rb;
												echo $PATH_PROFILE/default.rb;
												cat $PATH_PROFILE/$NAME.rb | sed 's/^#*//g' > $PATH_PROFILE/default.rb ;
												exit 0;
}

function create_profile {												
												if [ $NAME ] && [ $PASS ] && [ $USER ]; then
													if [ $PATH_PROFILE/$NAME.rb ]; then
														printf '%s\n' "Actualizando profile $NAME ...";
														rm -rf $PATH_PROFILE/$NAME.rb;
													else
														printf '%s\n' "Creando profile $NAME ...";
													fi
													touch $PATH_PROFILE/$NAME.rb;
													echo "default[:slavedata][:ip_maquina_local] =  \"$IP\"" >> $PATH_PROFILE/$NAME.rb;
													echo "default[:slavedata][:pass_maquina_local] =  \"$PASS\"" >> $PATH_PROFILE/$NAME.rb;
													echo "default[:slavedata][:user_maquina_local] =  \"$USER\"" >> $PATH_PROFILE/$NAME.rb;
													echo "default[:slavedata][:path_project_vagrant] =  \"$PATH_CONFIGHOST\"" >> $PATH_PROFILE/$NAME.rb;
													exit 0;
												fi
												print_error;
												exit 2;
}


while getopts 'n: i: p: u: d: e: s: hlc' option;
do
	case "$option"
		in
			c) CREATE=true;;
			n ) NAME=${OPTARG};;
			i ) IP=${OPTARG};;
			p ) PASS=${OPTARG};;
			u ) USER=${OPTARG};;
			e ) NAME=${OPTARG};election_profile;;
			s ) NAME=${OPTARG};print_show;;
			l) print_list;;
			d ) NAME=${OPTARG};delete_profile;;
			h) print_help; exit 0;;
			*) print_error; exit 2;;
	esac
done

if [ $CREATE ]; then
	create_profile;
fi

exit 0;


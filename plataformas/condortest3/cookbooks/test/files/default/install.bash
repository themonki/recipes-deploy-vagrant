###########################################
# Script para Instalacion y configuracion #
#  inicial de Condor en Linux             #
#  Edier Alberto Zapata edalzap@gmail.com #
#  Marzo 2010 Version 1.0RC3.1/2k111028     #
###########################################
#!/bin/bash

# Detectar Ruta Instalacion Condor
#echo $CONDOR_CONFIG | sed 's:/condor_config::'| sed 's:/etc::'

# Version de Condor a instalar, sera agregada al directorio de instalacion
condorVersion=$(pwd | cut -d- -f2 | sed 's/\.//g')

# Fecha y Hora en que se ejecuto el instalador
HOY=$(date +%F\ %T)

# Crear nombre del HOST sin dominio
HOST=$(echo ${HOSTNAME} | cut -d. -f1)
export HOST

#############################################
###        DECLARACION DE MENSAJES        ###
#############################################
strIdioma="> Seleccione su idioma / Select your language:\n 1. Esp.\n 2. Eng(beta).\nOpcion/Choice";
strWar00=" LEER LEER LEER LEER LEER LEER LEER LEER LEER LEER LEER LEER LEER";
strWar01="-----------------------------------------------------------------";
strWar02=" Se esta iniciando una instalacion de Condor como usuario normal.";
strWar03=" Es decir: Debe asegurarse de poseer permisos de escritura en";
strWar04=" la carpeta destino y que en los demas nodos del cluster existe";
strWar05=" un usuario con el mismo UID(${UID}) y login (${LOGNAME}).";
strWar06=" Este usuario sera el encargado de iniciar Condor.";
strWar07="-----------------------------------------------------------------";
strNoCondor="==> NO se encuentra condor_install.\n Por favor coloque este script en la carpeta del paquete Condor e inicielo de nuevo.";
strNoname="==> El nombre ${HOSTNAME} no es valido. Por favor asigne un nombre al nodo e intente de nuevo.";
strDedica="> Es este un nodo dedicado? [S]i/[N]o";
strContinua="> Desea continuar? [S]i/[N]o";
strTipo="> Seleccione el tipo de nodo:\n 1. manager\n 2. manager,submit";
strTipo="${strTipo}\n 3. execute [Puede ejecutar MPI]\n 4. execute,submit\n 5. submit\n> Opcion";
strCentral="> Indique el FQDN del Central Manager del cluster (ej. cm.mycluster.org)";
strCentralBad="==> No ha indicado un FQDN correcto (Ejemplo: pc.organizacion.dominio)";
strPrefijo="> Indique el directorio donde desea instalar Condor";
strPrefijoBad="==> No posee permisos de escritura en";
strPrefijoOk="Condor sera instalado en la carpeta: ";
strDominio01="> Indique las subredes y/o dominios del cluster.";
strDominio02=" valor predefinido: ";
strDominio03="(inicie con ',' para anexarlas el valor predefinido).";
strUsuario="> Indique el Login del usuario para Condor";
strUsuarioOk="Datos del usuario: ";
strUsuarioBad="==> El login indicado no existe en el sistema.";
strCondorStart="> Desea que se inicie Condor al terminar la instalacion? [S]i/[N]o";
strCondorOk="Iniciando Condor";
strTituloOpciones="Opciones que seran usadas";
strCreaScript01="El archivo ";
strCreaScript02="es un script de inicio de tipo SysV, el cual puede ser usado para iniciar";
strCreaScript03="Condor cada vez que el sistema operativo inicie.";
strCreaSubmit="Puede usar el archivo testTask.condor para verificar el procesamiento de tareas en el cluster.";
strCreaSubmit="${strCreaSubmit}.\n Copie dicho archivo a su carpeta y ejecutelo con:\n condor_submit testTask.condor";
strRcInit="Desea colocar el script condorStart.sh in /etc/init.d?  [S]i/[N]o";
strSchedMpi="Desea permitir el envio de tareas paralelas (Ej. MPI) desde este nodo? [S]i/[N]o";
strNodeMpi="Desea permitir la ejecucion de tareas paralelas (Ej. MPI) en este nodo? [S]i/[N]o";
strMpiSched="Indique el FQDN del nodo que enviara las tareas al universo Parallel";

# Comentarios que van en condor_config.local
strComenEcho="Valores que se adicionaran a";
strComenTitulo="##### VALORES AGREGADOS POR install.bash el dia: ${HOY} #####";
strComenAllowWrite="# Equipos que pueden enviar tareas";
strComenSwap01="# Deshabilitar uso del Swap. Porque en caso de no detectarlo";
strComenSwap02="#  Condor no ejecutara ninguna tarea.";
strComenStart="# No esperar inactividad para iniciar ejecucion de las tareas";

# Comentarios que van en bashrc
strBashEtc="# TICAC: Si existe /etc/bashrc leerlo";
strBashCondor="# TICAC: Cargar variables de Condor";

#############################################
### DECLARACION DE VARIABLES Y CONSTANTES ###

# Opciones que minimizan la edicion del archivo de configuracion.
# Definir opcion para Log de Instalacion 
 condorLog="--install-log=condorInstallLog.txt"
# Obtener el dominio del PC actual
 dominio=$(/bin/hostname --domain)
# Almacenar el nombre del Central Manager
 cManager=""
# Si no se detecta Swap. Deshabilitar su uso para condor.
#  Porque en ocasiones produce fallas en la ejecucion de tareas.
 resSwap="RESERVED_SWAP=0"
# UID almacena el ID del usuario que ejecuta el script.
# LOGNAME almacena el login del usuario que ejecuta el script.
# En caso de ser nodo dedicado se asignara valor START=TRUE
 condorStart=""
# En caso de ser un Submit node, se creara un archivo de prueba.
# y se pedira confirmacion para activar MPI-Scheduller
 submitNode=0
# En caso de ser un Execute node, se pedira confirmacion para activar MPI-Execute.
 executeNode=0
# Variables para activar MPI
 mpiSched="N";
 mpiNode="N";

#############################################
# Ayuda para linea de comandos Esp.
function ayudaEs()
{
 echo "##################################"
 echo "# OPCIONES POR LINEA DE COMANDOS #"
 echo "##################################"
 echo -e " -t = Tipo de nodo:\n  [m] Manager\t [s] Submit\n  [e] Execute\t [ms] Manager,Submit\n [se] Submit Execute"
 echo " -c = Nombre completo del Central Manager"
 echo " -p = Carpeta donde sera instalado Condor."
 echo " -d = Dominio de la red"
 echo " -u = Usuario para Condor"
 echo " -b = Iniciar Condor al cargar sistema operativo. (Solo usuario root)"
 echo " -s = Iniciar Condor al terminar instalacion."
 echo " -h = Ayuda en español."
 echo " -H = Help in english."
 echo " Ejemplo:"
 echo " ./install.bash -t ms -m master.test.com -p /home/condor -d test.com -u condor -s -init"
 echo ""
}

# Ayuda para linea de comandos Eng.
function ayudaEn()
{
 echo "##################################"
 echo "#      COMMAND LINE OPTIONS      #"
 echo "##################################"
 echo -e " -t = Node's type:\n  [m] Manager\t [s] Submit\n  [e] Execute\t [ms] Manager,Submit\n [se] Submit Execute"
 echo " -c = Central Manager's Full Domain Name"
 echo " -p = Installation directory."
 echo " -d = Network Domain"
 echo " -u = Condor's user."
 echo " -b = Start Condor at boot time. (root user Only)"
 echo " -s = Start Condor after installation."
 echo " -h = Ayuda en español."
 echo " -H = Help in english."
 echo " Example:"
 echo " ./install.bash -t ms -m master.test.com -p /home/condor -d test.com -u condor -s -init"
 echo ""
}

#############################################
###    FUNCIONES PARA CAPTURA DE DATOS    ###

# Solicitar idioma deseado para los mensajes
function leeIdioma()
{
 echo -n -e "${strIdioma}: "
 read idioma
echo "Idioma: ${idioma}"
# si se elije Ingles, se cambian los mensajes.
 if [ ${idioma} -eq 2 ]; then
  strWar00=" READ READ READ READ READ READ READ READ READ READ READ READ READ";
  strWar01="-----------------------------------------------------------------";
  strWar02=" A normal user instalation of Condor is starting.";
  strWar03=" It means, that you have to be sure that you can create files in";
  strWar04=" the target folder. And that an user with same UID(${UID}) and";
  strWar05=" same login(${LOGNAME}) exists in the other nodes of the cluster.";
  strWar06=" This user will be in charge of start Condor.";
  strWar07="-----------------------------------------------------------------";
  strNoCondor="==> condor_install cannot be found in current folder\nPlease copy this script to the Condor's package folder and start it again.";
  strNoname="==> The name ${HOSTNAME} isn't valid. Please assign a name to this node and try again.";
  strDedica="> Is this a dedicated node? ye[S]/[N]o";
  strContinua="> Do you wish to continue? ye[S]/[N]o";
  strTipo="> Choose the node's type:\n 1. manager\n 2. manager,submit";
  strTipo="${strTipo}\n 3. execute\n 4. execute,submit\n 5. submit\n> Option";
  strCentral="> Type the Central Manager's FQDN of this cluster (ie. cm.mycluster.org)";
  strCentralBad="==> You haven't type a correct FQDN (Example: pc.organization.domain)";
  strPrefijo="> Type the folder's name where Condor will be installed";
  strPrefijoBad="==> You can't write in";
  strPrefijoOk="Condor will be installed in the folder:";
  strDominio01="> Type the network domain for the cluster";
  strDominio02=" default: ";
  strDominio03="(start with ',' to add them to the default).";
  strUsuario="> Type the login of the condor's user";
  strUsuarioOk="User's Data: ";
  strUsuarioBad="==> The login cannot be found in the system.";
  strCondorStart="> Do you wish that Condor be started after installation? ye[S]/[N]o";
  strCondorOk="Starting Condor";
  strTituloOpciones="Options to be used";
  strCreaScript01="The file ";
  strCreaScript02="is a SysV-style boot script, which can be used to start";
  strCreaScript03="Condor each time the operating system starts.";
  strCreaSubmit="You can use the file testTask.condor to check the task's processing in the cluster.";
  strCreaSubmit="${strCreaSubmit} Make a copy of the file in your Home folder and run it with:\n condor_submit testTask.condor";
  strRcInit="Do you want to copy the script condorStart.sh in /etc/init.d?  ye[S]/[N]o";
  strSchedMpi="Will you sent Pararell tasks(i.e. MPI) from this node? ye[S]/[N]o";
  strNodeMpi="Will you accept Pararell tasks (i.e. MPI) in this node? ye[S]/[N]o";
  strMpiSched="Type the FQDN of the node which sent the Parallel tasks";

# Comentarios que van en condor_config.local
  strComenEcho="This data will be added to";
  strComenTitulo="##### DATA ADDED BY install.bash in: ${HOY} #####";
  strComenAllowWrite="# Nodes which can submit tasks";
  strComenSwap01="# Disable Swap check for Condor. Because if Condor can't find it";
  strComenSwap02="#  none task will be run.";
  strComenStart="# Do not wait for user's inactivity before to start taks.";

# Comentarios que van en bashrc
  strBashEtc="# TICAC: If exist /etc/bashrc load it";
  strBashCondor="# TICAC: Load Condor's variables";
#####
# Show Command line options.
   ayudaEn 
  else
# Mostrar opciones por linea de comandos
   ayudaEs
 fi
}

# Verificar que se ejecuta dentro de la carpeta de Condor
function chkCondor()
{
# verificar que esta en la carpeta con los instaladores de Condor
 if [ ! -f ./condor_install ]; then
  echo -e "${strNoCondor}"
  exit 1
 fi
# Verificar que el PC tiene un nombre asignado.
 local=$(echo ${HOSTNAME} | cut -d\. -f1| grep -i local | wc -l)
 if [ $local -eq 1 ]; then
  echo -e "${strNoName}"
  exit 1
 fi
}

# Verificar que es Superusuario
function leeUID()
{
 if [ ${UID} -gt 0 ]; then
  echo -e "${strWar00}\n${strWar01}\n${strWar02}\n${strWar03}";
  echo -e "${strWar04}\n${strWar05}\n${strWar06}\n${strWar07}\n";
  echo -n "${strContinua} : ";
  read cont

  case "${cont}" in
   "N" | "n" )
    exit 1
   ;;
   "S" | "s" )
    cont="S"
    cUID=${UID}
    ;;
   * )
    leeUID
   ;;
  esac
 else
  leeUser
 fi
}

# En caso de ejecutarse como root, pedir el login del usuario q ejecutara condor.
function leeUser()
{
# Si no se le envio un login pedirlo.
 if [ -z $1 ]; then
  echo -n "${strUsuario}: "
  read usuario
 else # Colocar login enviado en variable local.
  usuario=$1
 fi
 existe=$(grep -w ${usuario} /etc/passwd | wc -l)
# el usuario existe
 if [ ${existe} -eq 1 ]; then
# Obtener el UID del usuario
  cUID=$(grep -w ${usuario} /etc/passwd | cut -d\: -f3)
  cGID=$(grep -w ${usuario} /etc/passwd | cut -d\: -f4)
  condorUID="CONDOR_IDS = ${cUID}.${cGID}";
# Asignar login del usuario
  condorUser="--owner=${usuario}"
  echo "${strUsuarioOk} ${usuario} UID: ${cUID} GID: ${cGID}"
 else
  echo -e "\n${strUsuarioBad}\n";
  leeUser
 fi
 echo "usuario: ${usuario}"
}

# leer el tipo de nodo
function leeTipo()
{
 echo -n -e "${strTipo}: "
 read tipo
echo "tipo: ${tipo}"
# Definir lectura posterior de nombre de Central Manager
 noManager=0;
 if [ ${tipo} -gt 2 ]; then
  noManager=1;
 fi
# Si es un nodo de procesamiento se puede evitar que espere
#  inactividad antes de inciar las tareas.
 dedica=0;
 case $tipo in
  "1" )
     tipo=manager;
  ;;
  "2" )
     tipo=manager,submit;
     submitNode=1;
  ;;
  "3" ) # Si es un nodo de procesamiento se puede evitar que espere ...
     tipo=execute;
     executeNode=1;
     dedica=1;
  ;;
  "4" ) # ... espere inactividad antes de inciar las tareas.
     tipo=execute,submit;
     submitNode=1;
     dedica=1;
  ;;
  "5" )
     tipo=submit;
     submitNode=1;
  ;;
    * )
     leeTipo
  ;;
 esac
# Tipo de nodo <[submit],[execute],[manager]>
 condorType="--type=${tipo}"
# Si el tipo de nodo no es manager se debe pedir el nombre del
# Central Manager del cluster.
 if [ ${noManager} -eq 1 ]; then
  leeCentral;
 fi
# Si el tipo de nodo es execute se preguntara si es dedicado
 if [ ${dedica} -eq 1 ]; then
  leeDedicado;
 fi
}

# leer el nombre del central manager
function leeCentral()
{
 echo -e "${strCentral}: "
 read cManager
echo "CM: ${cManager}"
# Verificar que hay un FQDN de CM correcto
 n=$(echo "$cManager}" | awk -F\. '{print NF}')
 if [ ${n} -lt 3 ]; then
  echo -e "${strCentralBad}"
  leeCentral
 else
# hostName del CentralManager
  condorCM="--central-manager=${cManager}"
# Cambiar a Dominio del Central Manager
  dominio=$(echo ${cManager} | cut -d\. -f2-)
 fi
}

# Si el nodo es de solo ejecucion, se puede definir como nodo dedicado
function leeDedicado()
{
 echo -n "${strDedica} : "
 read dedica
echo "Dedica: ${dedica}"
 case "${dedica}" in
  "S" | "s" )
   condorStart="START=TRUE"
   ;;
  "N" | "n" )
   condorStart=""
  ;;
  * )
   leeDedicado
  ;;
 esac
}

# leer el prefijo de instalacion (carpeta destino) 
function leePrefijo
{
 #local prefijo
 echo "${strPrefijo}: "
 read prefijo
echo "prefijo: ${prefijo}"
 touch ${prefijo}/test &> /dev/null
  escribe=$(echo $?)
 if [ ${escribe} -ne 0 ]; then
  echo "${strPrefijoBad} ${prefijo}"
  leePrefijo
 else
  rm -f ${prefijo}/test &> /dev/null
  prefijo="${prefijo}/condor${condorVersion}"
  echo "${strPrefijoOk} ${prefijo}"
 fi
 condorPrefix="--prefix=${prefijo}"
}

# leer el dominio
function leeDominio
{
 if [ -z ${dominio} ]; then
  echo -e "${strDominio01}: "
  read nDominio
echo "Dominio: ${nDominio}"
  nDominio=$(echo ${nDominio} | sed s/\ //g)
  if [ -z ${nDominio} ]; then
   leeDominio
  else
   nDominio="*.${nDominio}"
  fi
 else
  echo -e "${strDominio01}\n${strDominio03} ${strDominio02} *.${dominio}:"
  read nDominio
echo "Dominio: ${nDominio}"
# Eliminar espacios en Blanco de la lista de Dominios
  nDominio=$(echo ${nDominio} | sed s/\ //g)
# Detectar si se inicia con Coma.
  indexComa=$(expr index "$nDominio" ,);
  if [ -z ${nDominio} ]; then
   nDominio="*.${dominio}";
# Si el primer caracter es coma anexarlo al Default.
  elif [ ${indexComa} -eq 1 ]; then
   nDominio="*.${dominio}${nDominio}";
  fi
 fi
 allowWrite="ALLOW_WRITE=${nDominio}"
echo "Dominio: ${nDominio}"
}

# Pregunta si se desea iniciar Condor al terminar la instalacion.
function leeIniciaCondor()
{
 echo -n "${strCondorStart} : "
 read iniCondor
echo "iniCondor: ${iniCondor}"
 case "${iniCondor}" in
  "S" | "s" )
   iniCondor="S"
   ;;
  "N" | "n" )
   iniCondor="N"
  ;;
  * )
  leeIniciaCondor
  ;;
 esac
}

# Anexar carga de variables de Condor a la configuración de Bash.
function cambiaBashrc
{
 if [ ${UID} -eq 0 ]; then # Es root se cambia el /etc/bashrc
  if [ -f /etc/bashrc ]; then
   homeBashrc="/etc/bashrc";
  elif [ -f /etc/bash.bashrc ]; then
   homeBashrc="/etc/bash.bashrc";
  fi
# Eliminar configuracion antigua.
  grep -v "TICAC" ${homeBashrc} > /tmp/bashTmp
  cat /tmp/bashTmp > ${homeBashrc}
# Anexar nuevos datos.
  echo ". ${prefijo}/condor.sh ${strBashCondor}" >> ${homeBashrc}
 else
  homeBashrc="${HOME}/.bashrc";
  homeProfile="${HOME}/.bash_profile";
  echo "${strBash}"
  if [ -f ${homeBashrc} ]; then
# Eliminar configuracion antigua.
    grep -v "TICAC" ${homeBashrc} > /tmp/bashTmp
    cat /tmp/bashTmp > ${homeBashrc}
# Anexar nuevos datos.
    echo ". ${prefijo}/condor.sh ${strBashCondor}" >> ${homeBashrc}
# Algunos Bash cargan .bash_profile en lugar de .bashrc
    touch ${homeProfile}
# Eliminar configuracion antigua.
    grep -v ". ${homeBashrc}" ${homeProfile} > /tmp/bashTmp
    cat /tmp/bashTmp > ${homeProfile}
# Colocar nuevos datos
    echo ". ${homeBashrc}" >> ${homeProfile}
  else
   echo "if [ -f /etc/bashrc ]; then" > ${homeBashrc}
   echo " . /etc/bashrc         ${strBashEtc}" >> ${homeBashrc}
   echo "fi" >> ${homeBashrc}
   echo ". ${prefijo}/condor.sh ${strBashCondor}" >> ${homeBashrc}
# Algunos Bash cargan .bash_profile en lugar de .bashrc
    touch ${homeProfile}
# Eliminar configuracion antigua.
    grep -v ". ${homeBashrc}" ${homeProfile} > /tmp/bashTmp
    cat /tmp/bashTmp > ${homeProfile}
# Colocar nuevos datos
    echo ". ${homeBashrc}" >> ${homeProfile}
  fi
 fi
}

# Funcion que modifica el script de inicio condor.boot de acuerdo
# con los valores ingresados.
function creaBootScript
{
 initD=$1
 salida=${prefijo}/startCondor.sh
 ejemplo=${prefijo}/etc/examples/condor.boot

 if [ -f ${prefijo}/etc/examples/condor.boot.generic ]; then
  ejemplo=${prefijo}/etc/examples/condor.boot.generic
 fi

set -x
 echo "#! /bin/sh" > ${salida}
 echo ". ${prefijo}/condor.sh # Cargar Variables Entorno" >> ${salida}
# if [ ${ejemploVer} -eq 1 ]; then 
  echo "MASTER=${prefijo}/sbin/condor_master # Ubicacion de condor_master" >> ${salida}
# fi
# Quitar la primer linea (#!/bin/bash) y el MASTER del archivo de ejemplo.
# y anexar el resto al archivo de inicio.
 cat ${ejemplo} | grep -v "^#!" | grep -v "^MASTER=" >> ${salida}
 chmod 755 ${salida}
 echo "${strCreaScript01}: ${salida}"
 echo -e "${strCreaScript02}\n${strCreaScript03}"
set +x
# Si no es root no puede acceder a /etc/init.d
 if [ ${UID} -eq 0 ]; then
# se llamo por Argumentos no por preguntas.
  if [ -z ${initD} ]; then
   echo -n "${strRcInit}: "
   read initD
echo "initD: ${initD}"
  fi
  case "${initD}" in
   "S" | "s" )
    cp -v ${salida} /etc/init.d
# Estamos en Debian?
    if [ -f /sbin/update-rc.d -o -f /usr/sbin/update-rc.d ]; then
     update-rc.d startCondor.sh start 99 2 3 5 . stop 10 0 1 6 .
# O estamos en RedHat?
    elif [ -f /sbin/chkconfig -o -f /usr/sbin/chkconfig ]; then
     chkconfig --level 235 startCondor.sh on
    fi
   ;;
   "N" | "n" )
    echo "";
   ;;
   * )
    echo "Error";
   ;;
  esac
 fi
 
}

# Funcion encargada de crear un submit file de ejemplo para testear la 
# instalacion.
function creaSubmit()
{
 testFolder="${prefijo}"
 outFile="${testFolder}/testTask.condor"
# Verificar que es un nodo de Envio.
 if [ ${submitNode} -eq 1 ]; then
  echo "##" > ${outFile}
  echo "# Test Submit File" >> ${outFile}
  echo "##" >> ${outFile}
  echo "# Use: condor_submit testTask.condor" >> ${outFile}
  echo "should_transfer_files = Yes" >> ${outFile}
  echo "when_to_transfer_output = ON_EXIT_OR_EVICT" >> ${outFile}
  echo "Executable = /bin/hostname" >> ${outFile}
  echo "Universe   = vanilla" >> ${outFile}
  echo "Output     = hostOut.\$(Process)" >> ${outFile}
  echo "Error      = hostErr.\$(Process)" >> ${outFile}
  echo "Queue 15" >> ${outFile}
  echo -e "${strCreaSubmit}"
 fi
}

# Funcion encargada de eliminar todos los archivos .dbg
# en ${prefijo}, con el fin de reducir el tamaño en disco.
function borraDbg()
{
 echo " Borrando Archivos .DBG / Deleting .DBG Files"
 for i in $(find ${prefijo} -iname "*.dbg");
  do
#   echo "$i: [Borrado / Deleted]"
   rm -f $i
  done
}

# Preparar este Scheduller para enviar tareas al universo Parallel.
function schedMPI
{
 if [ ${submitNode} -eq 1 ]; then
 # Si existe mpirun, se puede usar MPI
  chkMpi=$(which mpirun > /dev/null)
  if [ $? -eq 0 ]; then
   echo -n "${strSchedMpi} : "
   read schedMpi
echo "schedMpi ${schedMpi}"
   case "${schedMpi}" in
    "S" | "s" )
     mpiSched="S"
     ;;
    "N" | "n" )
     mpiSched="N"
    ;;
    * )
     schedMPI
    ;;
   esac
  fi
 fi
}

# Preparar este nodo para procesar tareas en el universo Parallel.
function nodeMPI
{
 if [ ${executeNode} -eq 1 ]; then
 # Si existe mpirun, se puede usar MPI
  chkMpi=$(which mpirun > /dev/null)
  if [ $? -eq 0 ]; then
   echo -n "${strNodeMpi} : "
   read nodeMpi
echo "nodeMpi ${nodeMpi}"
   case "${nodeMpi}" in
    "S" | "s" )
     echo -e "${strMpiSched}\n${strDominio02} [${cManager}]: "
     read mpiScheduller
echo "MpiSched: ${mpiScheduller}"
     if [ -z ${mpiScheduller} ]; then
      mpiScheduller=${cManager}
     fi
     mpiNode="S"
     condorStart="START=TRUE"
     ;;
    "N" | "n" )
     mpiNode="N"
    ;;
    * )
     nodeMPI
    ;;
   esac
  fi
 fi
}

# Anexado Sep-09-2010
# Variables requeridas para enviar tareas MPI
function mpiSent
{
 echo "UNUSED_CLAIM_TIMEOUT = 0" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "MPI_CONDOR_RSH_PATH = \$(LIBEXEC)" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "ALTERNATE_STARTER_2 = \$(SBIN)/condor_starter" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "STARTER_2_IS_DC = TRUE" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "SHADOW_MPI = \$(SBIN)/condor_shadow" >> ${prefijo}/local.${HOST}/condor_config.local
}

# Anexado Sep-09-2010
# Variables requeridas para ejecutar tareas MPI
function mpiRun
{
 echo "DedicatedScheduler = \"DedicatedScheduler@${mpiScheduller}\"" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "STARTD_ATTRS = \$(STARTD_ATTRS), DedicatedScheduler" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "SUSPEND	 = False" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "CONTINUE	 = True" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "PREEMPT	 = False" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "KILL		 = False" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "WANT_SUSPEND = False" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "WANT_VACATE	= False" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "RANK		 = Scheduler =?= \$(DedicatedScheduler)" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "MPI_CONDOR_RSH_PATH = \$(LIBEXEC)" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "CONDOR_SSHD = /usr/sbin/sshd" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "CONDOR_SSH_KEYGEN = /usr/bin/ssh-keygen" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "STARTD_EXPRS = \$(STARTD_EXPRS), DedicatedScheduler" >> ${prefijo}/local.${HOST}/condor_config.local
}

# Anexado Sep-02-2010
# En caso de dectectar ROCKS se debe modificar el
# FILESYSTEM_DOMAIN y el UID_DOMAIN por local
function rocksFix
{
 if [ -f /opt/rocks/bin/rocks ]; then
# Rocks detectado
# Cambiar el Dominio del Head Node por Local.
  cat ${prefijo}/local.${HOST}/condor_config.local | sed "s/UID_DOMAIN = ${dominio}/UID_DOMAIN = local/"  | sed "s/FILESYSTEM_DOMAIN = ${dominio}/FILESYSTEM_DOMAIN = local/" > ${prefijo}/local.${HOST}/condor_config.local.rocks
# Crear copia del archivo condor_config original
  cat ${prefijo}/local.${HOST}/condor_config.local > ${prefijo}/local.${HOST}/condor_config.local.original
# Cambiar el condor_config original por el modificado.
  cat ${prefijo}/local.${HOST}/condor_config.local.rocks > ${prefijo}/local.${HOST}/condor_config.local
 fi
}

# Anexado Sep-20-2010
# Ajustes postInstalacion
function postFix
{
# Eliminar restriccion de Memoria para la JVM
# En algunas distribuciones Inhibe la ejecución de Java.
 cat ${prefijo}/local.${HOST}/condor_config.local | sed 's/\(\-Xmx\).*/\1/' > /tmp/condor.tmp
# Cambiar archivo condor_config.local
 cat /tmp/condor.tmp > ${prefijo}/local.${HOST}/condor_config.local
}

# Funcion escargada de procesar los argumentos enviados
# por la linea de comandos.
function procesaArgumentos
{
 tipo="";
 while getopts "Hbt:c:p:d:u:sh" arg
 do
  case ${arg} in
   h) # Ayuda español
    ayudaEs
    exit 1
   ;;
   H) # Ayuda ingles
    ayudaEn
    exit 1
   ;;
   b) # Colocar Scripts de inicio en /etc/init.d
      initD="S"
   ;;
   s) # Iniciar Condor al terminar
      iniCondor="S"
   ;;
   t) # Tipo de nodo: Manager, Submit, Execute, ManagerSubmit, SubmitExecute
    case ${OPTARG} in
     "m" )
      tipo=manager;
     ;;
     "s" )
      tipo=submit;
      submitNode=1;
# Si existe mpirun, se usara MPI
     chkMpi=$(which mpirun > /dev/null)
     if [ $? -eq 0 ]; then
      mpiSched="S"
     fi
     ;;
     "e" )
      tipo=execute;
      condorStart="START=TRUE";
 # Si existe mpirun, se puede procesar MPI
      chkMpi=$(which mpirun > /dev/null)
      if [ $? -eq 0 ]; then
       mpiScheduller=${cManager}
      fi
       mpiNode="S"
     ;;
     "ms" )
      tipo=manager,submit;
      submitNode=1;
# Si existe mpirun, se usara MPI
     chkMpi=$(which mpirun > /dev/null)
     if [ $? -eq 0 ]; then
      mpiSched="S"
     fi
     ;;
     "se" )
      tipo=submit,execute;
      submitNode=1;
      condorStart="START=TRUE";
     ;;
     esac
     condorType="--type=${tipo}"
   ;;
   c) # nombre completo del Central Manager
      condorCM="--central-manager=${OPTARG}"
#  Por defecto el Central Manager sera el Scheduler
# tanto para tareas normales como MPI
      mpiScheduller=${OPTARG}
#  Si se indica -m antes de -t no se detectará el
# nombre del MpiScheduler (porque es obtenido de cManager)
# con la siguiente linea se arregla.
      cManager=${OPTARG}
# Usar Dominio del Central Manager
      dominio=$(echo ${OPTARG} | cut -d\. -f2-)
      allowWrite="ALLOW_WRITE=*.${dominio}"
   ;;
   p) # Prefijo de instalación: Osea donde se va a poner la carpeta condor${condorVersion}
      prefijo=${OPTARG}
# Verificar que si se puede escribir en ${prefijo}
      touch ${prefijo}/test &> /dev/null
      escribe=$(echo $?)
      if [ ${escribe} -ne 0 ]; then
       echo "${strPrefijoBad} ${prefijo}"
       exit 1
      else
       rm -f ${prefijo}/test &> /dev/null
       prefijo="${prefijo}/condor${condorVersion}"
       echo "${strPrefijoOk} ${prefijo}"
      fi
      condorPrefix="--prefix=${prefijo}"
   ;;
   d) # Dominio de la red
      allowWrite="ALLOW_WRITE=*.${OPTARG}"
   ;;
   u) # Usuario que ejecutara Condor
      leeUser ${OPTARG}
   ;;
   ?)
    ayudaEs
    exit
   ;;   
  esac
 done
}

#############################################
###            CAPTURA DE DATOS           ###
#############################################

# Si no se han pasado argumentos hacer preguntas.
if [ -z $1 ]; then
# Solicitar Idioma para los mensajes
 leeIdioma

# Verificar que esta en la carpeta con Condor
 chkCondor
# Iniciar captura opciones instalacion
 leeUID          # Mostrar mensaje de alera si no es ejecutado como root.
 leeTipo         # Leer tipo de Nodo.
 leePrefijo      # Leer prefijo carpeta instalacion. Se adiciona /condor/
 leeDominio      # Leer equipos/dominios aceptados escritura.
 schedMPI        # Si es un nodo de Envio se preguntara si se habilita MPI.
 nodeMPI         # Si es un nodo de Ejecucion se preguntara si se habilita MPI.
 leeIniciaCondor # Preguntar si se desea inicar Condor al terminar instalacion.
else
# Verificar que esta en la carpeta con Condor
 chkCondor
# Procesar las opciones pasadas por la linea de comandos.
 procesaArgumentos $@
fi
# Creacion de la lista de opciones que seran pasadas al condor_install
 opciones="${condorLog} ${condorCM} ${condorType} ${condorPrefix} ${condorUser}"
# Ejecutar condor_install con las opciones ingresadas.
 echo "${strTituloOpciones}:"
 echo "${opciones}"

## Si hay un log anterior Eliminarlo.
 if [ -f condorInstallLog.txt ]; then
  rm condorInstallLog.txt
 fi

## Ejecutar Instalador de Condor
 ./condor_install ${opciones}
# Oct-08-2010
 if [ ! -f ${prefijo}/local.${HOST}/condor_config.local ]; then
  echo ">>>>>> condor_install Error <<<<<<"
  exit 1
 fi

# Configuracion
 echo "${strComenEcho} ${prefijo}/local.${HOST}/condor_config.local"
 echo "${allowWrite}"
 echo "${resSwap}"
 echo "${condorStart}"
 echo "${strComenTitulo}" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "${strComenAllowWrite}" >> ${prefijo}/local.${HOST}/condor_config.local
 echo "${allowWrite}" >> ${prefijo}/local.${HOST}/condor_config.local
# Sep-20-2010
# En caso de no detectar Swap desactivarlo.
# Verificar que hay Swap
 Swap=$(free | grep -i swap | awk -F\   ' {print $2}')
 if [ ${Swap} -eq 0 ]; then
  echo "${strComenSwap01}" >> ${prefijo}/local.${HOST}/condor_config.local
  echo "${strComenSwap02}" >> ${prefijo}/local.${HOST}/condor_config.local
  echo "${resSwap}" >> ${prefijo}/local.${HOST}/condor_config.local
 fi

## Anexar configuracion para enviar tareas MPI.
 if [ ${mpiSched} = "S" ]; then
  mpiSent
## Anexar configuracion para procesar tareas MPI.
 elif [ ${mpiNode} = "S" ]; then
  mpiRun
 fi
# Se supone que la verificacion siguiente puede ser hecha con -n o -z pero ambas fallaron.
 if [ "x${condorStart}" != "x" ]; then
  echo "${strComenStart}" >> ${prefijo}/local.${HOST}/condor_config.local
  echo "${condorStart}" >> ${prefijo}/local.${HOST}/condor_config.local
 fi
# En caso de realizar una instalacion como root el archivo anterior: ${prefijo}/local.${HOST}/condor_config.local
# no sera editable por ningun usuario, por esta razon se debe realizar el chown siguiente.
 if [ ${UID} -eq 0 ]; then
  chown ${cUID}:${cGID} ${prefijo}/local.${HOST}/condor_config.local
 fi

###### Ajustes al Sistema Operativo / Cuenta de Usuario.
 cambiaBashrc             # Arreglar $HOME/.bashrc
 creaBootScript ${initD}  # Crear Script de inicio.
 creaSubmit               # Crear testTask.condor
 borraDbg                 # Eliminar archivos .dbg
 rocksFix		          # Si se detecta ROCKS cambiar el UID y FILESYSTEM_DOMAIN
 postFix                  # Ajustes postInstalacion

##### INICIAR CONDOR #####
if [ ${iniCondor} = "S" ]; then
 echo "${strCondorOk}"
 . ${prefijo}/condor.sh
 ${prefijo}/sbin/condor_master
fi

#####################
##
## 2010-11-17 Cambios 
##
# 1.  Se corrigió la falla de no habilitar MPI en
#    caso de indicar un nodo tipo submit usando
#    linea de comandos.
##
## 2010-12-09 Cambios 
##
# 1.  Se corrigió error en la linea de ejemplo
#    en la ayuda (argumento no valido: -v)
# 2.  Arreglada la falla en deteccion del nombre
#    del MpiScheduler al usar linea de comandos.
##
## 2011-01-10 Cambios 
##
# 1.  Fueron modificadas y agregadas opciones de la
#    linea de comandos. Dichas opciones son:
#   1.a. Cambios:
#    -i => -b : Configurar init.d para iniciar Condor
#        en boot time.
#    -m => -c : Indicar nombre completo del Central Manager
#   1.b. Adiciones:
# 2.  
#    

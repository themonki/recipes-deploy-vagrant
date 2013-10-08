<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_LOGICA . '/User.php' );
function printMenu() {

echo "        <div class = 'cssmenu'>
            <ul>
                <li class = 'last'> <a href = '" . SITE_WEB . "/login/" . "signout.php'<span>Salir</span></a> </li>
                <li class = 'has-sub'><a href = '#'><span>" . unserialize($_SESSION['user'])->getName() . "</span></a>
                    <ul>
                        <li><a href = '" . SITE_WEB . "/site/personal/" . "index.php'><span>Ver Perfil</span></a></li>
                        <li class = 'last'><a href = ''><span>Editar Perfil</span></a></li>
                    </ul>
                </li>
                <li><a href = '#'><span>Dashboard</span></a></li>
                <li><a href = '" . SITE_WEB . "/" . "index.php'><span>Inicio</span></a></li>
            </ul>
        </div>
";
}
?>

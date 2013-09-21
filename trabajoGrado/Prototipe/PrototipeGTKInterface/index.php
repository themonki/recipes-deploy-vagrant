<?php
session_start();
if(isset($_SESSION['PWD_CONTROLADOR'])){    
    require_once( $_SESSION['PWD_CONTROLADOR'] . '/config.php' );
    echo "1";
} else {
    require_once( $_SERVER["DOCUMENT_ROOT"].'/PrototipeGTKInterface/controlador/config.php' );
    echo "2";
}
header("Location: ".$_SESSION['SITE_WEB']);
?>

<?php

session_start();
if (isset($_SESSION['PWD_CONTROLADOR'])) {
    require_once( $_SESSION['PWD_CONTROLADOR'] . '/config.php' );
} else {
    require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
}
header("Location: " . $_SESSION['SITE_WEB'] . "/site");
?>

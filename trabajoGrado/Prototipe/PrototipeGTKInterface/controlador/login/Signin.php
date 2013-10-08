<?php

/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
session_start();

require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once ( PWD_CONTROLADOR . '/login/Login.php' );

$msg = "";
$msgshow = 'display: none;';
$formerror = '';

if (isset($_SESSION['user']) && unserialize($_SESSION['user'])->getId() !== 0) {
    if (valid_login(unserialize($_SESSION["user"]))) {
        header("Location: " . SITE_WEB . "/site");
    } else {
        $msg = "¡Fallo de Autenticación¡ Puede ser que este desactivado, comuniquese con el administrador.";
        $msgshow = '';
        $formerror = 'formerror';
        session_destroy();
    }
} else if (isset($_POST["username"]) && isset($_POST["password"])) {

    $usertmp = new User();
    $usertmp->setEmail($_POST["username"]);
    $usertmp->setPassword(md5($_POST["password"]));

    if (valid_login($usertmp)) {
        if (setting_Session($usertmp)) {
            header("Location: " . SITE_WEB . "/site");
            exit;
        } else {
            $msg = "¡Fallo al obtener los valores del usuario para la sesión.";
            $msgshow = '';
            $formerror = 'formerror';
        }
    } else {
        $msg = "¡Fallo al autenticarse¡. <br>Nombre de Usuario y/o Contraseña inválidos. También puede ser que este desactivado, comuniquese con el administrador.";
        $msgshow = '';
        $formerror = 'formerror';
    }
}
?>

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
$msgshow = 'none';

if (isset($_SESSION['user']) && unserialize($_SESSION['user'])->getId() !== 0) {// ya esta loggeado
    header("Location: " . SITE_WEB . "/site");
    exit;
} else if (isset($_POST["username"]) && isset($_POST["password"])) {// validar los datos
    $userTmp = new User();
    $userTmp->setEmail($_POST["username"]);
    $userTmp->setPassword(md5($_POST["password"]));
    if (valid_login($userTmp)) {
        if (setting_Session($userTmp, NULL)) {// solo el usuario
            header("Location: " . SITE_WEB . "/site");
            exit;
        } else {
            $msg = "¡Fallo al obtener los valores del usuario para la sesión.";
            $msgshow = 'error';
        }
    } else {
        $msg = "¡Fallo al autenticarse¡. <br>Nombre de Usuario y/o Contraseña inválidos. También puede ser que este desactivado, comuniquese con el administrador.";
        $msgshow = 'error';
    }
}
?>

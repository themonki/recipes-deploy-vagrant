<?php

/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
session_start();
$msg="";
$msgshow= 'display: none;';
$formerror = '';
if (isset($_SESSION['PWD_CONTROLADOR'])) {
    include( $_SESSION['PWD_CONTROLADOR'] . '/login/Login.php' );
} else {
    include( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/login/Login.php' );
}

if (isset($_SESSION["username"]) && $_SESSION["password"]) {
    if (valid_login($_SESSION["username"], $_SESSION["password"])) {
        header("Location: " . $_SESSION['SITE_WEB']."/site");
    }
} elseif (isset($_POST["username"]) && isset($_POST["password"])) {
    $username = $_POST["username"];
    $password = md5($_POST["password"]);
    
    if (valid_login($username, $password)) {
        $_SESSION['username'] = $username;
        $_SESSION['password'] = $password;
        echo "SELECT * "
                . "FROM users "
                . "WHERE email = '" . $username . "' "
                . ";";
        if(setting_Session($username)){
            header("Location: " . $_SESSION['SITE_WEB']."/site");
            exit;
        }  else {
            $msg = "¡Fallo al obtener los valores del usuario para la sesión.";
            $msgshow= '';
            $formerror = 'formerror';
        }
        
    } else {
        $msg = "¡Fallo al autenticarse¡. <br>Nombre de Usuario y/o Contraseña invalidos.";
        $msgshow= '';
        $formerror = 'formerror';
    }
}
?>

<?php

/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 * 
 * Funciónes para controlar la session y acceso a las paginas.
 * @author Edgar Moncada - Modificaciones
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_MODEL . '/ModelUser.php' );
include_once( PWD_LOGICA . '/User.php' );

/**
 * Función que sera la encargada de saber si la sessión ya tiene asiganos los 
 * valores del usuario y si aun existe en la base de datos.
 * @return true si se conecta correctamente.
 */
function is_logged_in() {
    /**
     * Cheque session is user logged in or not
     * */
    if (isset($_SESSION['user']) && unserialize($_SESSION['user'])->getId() !== 0) {
        if (valid_login(unserialize($_SESSION['user']))) {
            return true;
        } else {
            session_destroy();
            header("Location: " . SITE_WEB . "/login/signin.php");
            exit;
        }
    } else {
        header("Location: " . SITE_WEB . "/login/signin.php");
        exit;
    }
}

/**
 * Función que ingresa comprueba si en la session se tiene un usuario 
 * y si estos datos estan bien en la base de datos.
 * @param User $user el usuario a validar con email y password y status true.
 * @return boolean true si la validacion del usuario es correcta
 */
function valid_login($user) {
    /**
     * Cheque username and password is it match or not. If match return true else flase
     * */
    $modelUser = new ModelUser();
    $userFind = $modelUser->selectByEmailPasswordActivate($user);
    if (isset($userFind) && $userFind->getId() != 0) {
        return true;
    } else {
        return false;
    }
}

/**
 * Función que dado el usuario con el username (email) agregara a la session los
 * valores necesarios.
 * @param User $user el usuario con el email a buscar
 * @return boolea true si se hace correctamente.
 */
function setting_Session($user) {
    $modelUser = new ModelUser();
    $userSession = $modelUser->selectByEmail($user);
    $_SESSION['user'] = serialize($userSession);
    return true;
}

?>

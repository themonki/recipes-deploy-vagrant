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
include_once( PWD_FACHADA . '/Fachada.php' );
include_once( PWD_LOGICA . '/User.php' );

/**
 * Función que sera la encargada de saber si la sessión ya tiene asiganos los 
 * valores del usuario y si aun existe en la base de datos.
 */
function is_logged_in() {
    /**
     * Cheque session is user logged in or not
     * */
    if (isset($_SESSION['user']) && unserialize($_SESSION['user'])->getId() !== 0) {
        if (valid_login(unserialize($_SESSION['user']))) {
            
        } else {
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
    $fachada = new Fachada();
    $conect = $fachada->db_connect_pg();

    if ($conect) {
        $query = "SELECT * "
                . "FROM usr_user "
                . "WHERE usr_email = '" . $user->getEmail() . "' "
                . "AND usr_password = '" . $user->getPassword() . "' "
                . "AND usr_status = TRUE ;";
        $result = $fachada->db_query_select_pg($query);
        $fachada->db_close_pg();
        if (pg_num_rows($result) > 0) {
            return true;
        }
    }
    return false;
}

/**
 * Función que dado el usuario con el username (email) agregara a la session los
 * valores necesarios.
 * @param User $user el usuario con el email a buscar
 * @return boolea true si se hace correctamente.
 */
function setting_Session($user) {

    $fachada = new Fachada();
    $conect = $fachada->db_connect_pg();

    if ($conect) {
        $query = "SELECT * "
                . "FROM usr_user "
                . "WHERE usr_email = '" . $user->getEmail() . "' "
                . ";";
        $result = $fachada->db_query_select_pg($query);
        $fachada->db_close_pg();
        while ($row = pg_fetch_array($result)) {
            $userSession = new User();
            
            $userSession->setId($row['usr_id']);
            $userSession->setEmail($row['usr_email']);
            $userSession->setPassword($row['usr_password']);
            $userSession->setName($row['usr_name']);
            $userSession->setStatus($row['usr_status']);
            $userSession->setUserSystem($row['usr_usersystem']);

            $_SESSION['user'] = serialize($userSession);
            break;
        }

        return true;
    }
    return true;
}

?>

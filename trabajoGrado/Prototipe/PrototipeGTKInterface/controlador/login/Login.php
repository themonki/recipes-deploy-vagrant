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
if (isset($_SESSION['PWD_FACHADA'])) {
    include( $_SESSION['PWD_FACHADA'] . '/Fachada.php' );
} else {
    include( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/fachada/Fachada.php' );
}

/**
 * Función que sera la encargada de saber si la sessión ya tiene asiganos los 
 * valores del usuario y si aun existe en la base de datos.
 */
function is_logged_in() {
    /**
     * Cheque session is user logged in or not
     * */
    if (isset($_SESSION['username']) && isset($_SESSION["password"])) {
        if (valid_login($_SESSION["username"], $_SESSION["password"])) {
            
        } else {
            header("Location: " . $_SESSION['SITE_WEB'] . "/login/signin.php");
            exit;
        }
    } else {
        header("Location: " . $_SESSION['SITE_WEB'] . "/login/signin.php");
        exit;
    }
}

/**
 * Función que ingresa comprueba si en la session se tiene un usuario 
 * y si estos datos estan bien en la base de datos.
 * @param type $user el nombre de usuario
 * @param type $password el password ya encriptado en md5
 * @return boolean true si la validacion del usuario es correcta
 */
function valid_login($user, $password) {
    /**
     * Cheque username and password is it match or not. If match return true else flase
     * */
    $fachada = new Fachada();
    $conect = $fachada->db_connect_pg();

    if ($conect) {
        $query = "SELECT * "
                . "FROM users "
                . "WHERE email = '" . $user . "' "
                . "AND password = '" . $password . "' "
                . "AND estado = TRUE ;";
        $result = $fachada->db_query_select_pg($query);
        $fachada->db_close_pg();
        if (pg_num_rows($result) > 0) {
            return true;
        }
    }
    return false;
}

?>

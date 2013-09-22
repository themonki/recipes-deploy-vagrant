<?php

/**
 * Clase fachada que será utilizada para la conexión a la base de datos 
 * postgres.
 *
 * @author Edgar Moncada
 */
session_start();
if (isset($_SESSION['PWD_CONTROLADOR'])) {
    require_once( $_SESSION['PWD_CONTROLADOR'] . '/config.php' );
} else {
    require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
}

class Fachada {

    private $dbcon = null;

    /**
     * Función para obtener una conexión a la base de datos postgres.
     * @return resource conexión a la base de datos postgres.
     */
    public function db_connect_pg() {

        $this->dbcon = pg_connect("host=" . DB_HOST . " user=" . DB_USER . " password=" . DB_PASSWORD . " dbname=" . DB_NAME)
                or die('ERROR AL CONECTAR A LA BASE DE DATOS ' . pg_last_error());


        return $this->dbcon;
    }

    /**
     * Función para cerrar una conexión a la base de datos.
     * @return true si cerro la base de datos.
     */
    public function db_close_pg() {
        if (isset($this->dbcon)) {
            pg_close($this->dbcon);
            $this->dbcon=null;
            return true;
        }
        return false;
    }

    /**
     * Función realizar consultas a la base de datos.
     * @param type $query String con la consulta a realizar
     * @return type el arreglo a manejar con el resultado, false si falla.
     */
    public function db_query_select_pg($query) {
        if (isset($query) && isset($this->dbcon)) {
            return pg_query($this->dbcon, $query);
        }
        return false;
    }

}

?>

<?php

require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_FACHADA . '/Fachada.php' );
include_once( PWD_LOGICA . '/User.php' );

/**
 * Clase encargada de consultar, insertar y actualizar la tabla usr_user de la 
 * base de datos.
 *
 * @author Edgar Moncada
 */
class ModelUser {

    /**
     * @var Fachada 
     */
    private $fachada;

    /**
     * Nombre de la tabla.
     * @var string.
     */
    private $tablename = "usr_user";
    private $col1 = "usr_id";
    private $col2 = "usr_email";
    private $col3 = "usr_password";
    private $col4 = "usr_status";
    private $col5 = "usr_name";
    private $col6 = "usr_usersystem";

    /**
     * Constructor por defecto.
     */
    function __construct() {
        $this->fachada = new Fachada();
    }

    /**
     * Método para instertar en la tabla usr_user.
     * @param User $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function insert($obj) {
        $sql = "INSERT INTO " . $this->tablename . " "
                . "VALUES ("
                . "" . "DEFAULT" . ", "
                . "'" . $obj->getEmail() . "', "
                . "'" . $obj->getPassword() . "', "
                . "'" . $obj->getStatus() . "', "
                . "'" . $obj->getName() . "', "
                . "'" . $obj->getUserSystem() . "'"
                . ");";
        $result = $this->fachada->db_insert_pg($sql);
        return $result;
    }

    /**
     * Método para instertar en la tabla usr_user con el id dado.
     * @param User $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function insertId($obj) {
        $sql = "INSERT INTO " . $this->tablename . " "
                . "VALUES ("
                . "" . $obj->getId() . ", "
                . "'" . $obj->getEmail() . "', "
                . "'" . $obj->getPassword() . "', "
                . "'" . $obj->getStatus() . "', "
                . "'" . $obj->getName() . "', "
                . "'" . $obj->getUserSystem() . "'"
                . ");";
        $result = $this->fachada->db_insert_pg($sql);
        return $result;
    }

    /**
     * Método para instertar en la tabla usr_user.
     * @param User $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function updateById($obj) {
        $sql = "UPDATE " . $this->tablename . " SET "
                . $this->col2 . " = '" . $obj->getEmail() . "', "
                . $this->col3 . " = '" . $obj->getPassword() . "', "
                . $this->col4 . " = '" . $obj->getStatus() . "', "
                . $this->col5 . " = '" . $obj->getName() . "', "
                . $this->col6 . " = '" . $obj->getUserSystem() . "' "
                . "WHERE " . $this->col1 . " = " . $obj->getId() . ""
                . ";";
        $result = $this->fachada->db_update_pg($sql);
        return $result;
    }

    /**
     * Método para instertar en la tabla usr_user.
     * @param User $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function deleteById($obj) {
        $sql = "DELETE FROM " . $this->tablename . " "
                . "WHERE " . $this->col1 . " = " . $obj->getId() . ""
                . ";";
        $result = $this->fachada->db_delete_pg($sql);
        return $result;
    }

    /**
     * Método para instertar en la tabla usr_user.
     * @param User $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function selectById($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename ." "
                . "WHERE " . $this->col1 . " = " . $obj->getId() . ""
                .";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new User();
        while ($row = pg_fetch_array($result)) {   
            $objTmp->setId($row[$this->col1]);
            $objTmp->setEmail($row[$this->col2]);
            $objTmp->setPassword($row[$this->col3]);
            $objTmp->setStatus($row[$this->col4]);
            $objTmp->setName($row[$this->col5]);
            $objTmp->setUserSystem($row[$this->col6]);
            break;
        }        
        return $objTmp;
    }
    
    /**
     * Método para instertar en la tabla usr_user.
     * @param User $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function selectByEmail($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename ." "
                . "WHERE " . $this->col2 . " = '" . $obj->getEmail() . "'"
                .";";
        $result = $this->fachada->db_query_select_pg($sql);
        
        $objTmp = new User();
        while ($row = pg_fetch_array($result)) {   
            $objTmp->setId($row[$this->col1]);
            $objTmp->setEmail($row[$this->col2]);
            $objTmp->setPassword($row[$this->col3]);
            $objTmp->setStatus($row[$this->col4]);
            $objTmp->setName($row[$this->col5]);
            $objTmp->setUserSystem($row[$this->col6]);
            break;
        }        
        return $objTmp;
    }

    /**
     * Método para instertar en la tabla usr_user.
     * @param User $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function selectByEmailPassword($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename ." "
                . "WHERE " . $this->col2 . " = '" . $obj->getEmail() . "' AND "
                . "" . $this->col3 . " = '" . $obj->getPassword() . "'"
                .";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new User();
        while ($row = pg_fetch_array($result)) {   
            $objTmp->setId($row[$this->col1]);
            $objTmp->setEmail($row[$this->col2]);
            $objTmp->setPassword($row[$this->col3]);
            $objTmp->setStatus($row[$this->col4]);
            $objTmp->setName($row[$this->col5]);
            $objTmp->setUserSystem($row[$this->col6]);
            break;
        }        
        return $objTmp;
    }
    
    /**
     * Método para instertar en la tabla usr_user.
     * @param User $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function selectByEmailPasswordActivate($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename ." "
                . "WHERE " . $this->col2 . " = '" . $obj->getEmail() . "' AND "
                . "" . $this->col3 . " = '" . $obj->getPassword() . "' AND "
                . "" . $this->col4 . " = " . "TRUE" . ""
                .";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new User();
        while ($row = pg_fetch_array($result)) {   
            $objTmp->setId($row[$this->col1]);
            $objTmp->setEmail($row[$this->col2]);
            $objTmp->setPassword($row[$this->col3]);
            $objTmp->setStatus($row[$this->col4]);
            $objTmp->setName($row[$this->col5]);
            $objTmp->setUserSystem($row[$this->col6]);
            break;
        }        
        return $objTmp;
    }
}

?>
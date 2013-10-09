<?php

require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_FACHADA . '/Fachada.php' );
include_once( PWD_LOGICA . '/RelationUserCert.php' );

/**
 * Clase encargada de consultar, insertar y actualizar la tabla ruc_relationusercert de la 
 * base de datos.
 *
 * @author Edgar Moncada
 */
class ModelRelationUserCert {

    /**
     * @var Fachada 
     */
    private $fachada;

    /**
     * Nombre de la tabla.
     * @var string.
     */
    private $tablename = "ruc_relationusercert";
    private $col1 = "usr_id";
    private $col2 = "crt_id";

    /**
     * Constructor por defecto.
     */
    function __construct() {
        $this->fachada = new Fachada();
    }

    /**
     * Método para instertar en la tabla ruc_relationusercert.
     * @param RelationUserCerts $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function insert($obj) {
        $sql = "INSERT INTO " . $this->tablename . " "
                . "VALUES ("
                . "" . $obj->getIdUser() . ", "
                . "" . $obj->getIdCert() . ""
                . ");";
        $result = $this->fachada->db_insert_pg($sql);
        return $result;
    }

    /**
     * Método para instertar en la tabla ruc_relationusercert con el id dado.
     * @param RelationUserCerts $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function insertId($obj) {
        $sql = "INSERT INTO " . $this->tablename . " "
                . "VALUES ("
                . "" . $obj->getIdUser() . ", "
                . "" . $obj->getIdCert() . ""
                . ");";
        $result = $this->fachada->db_insert_pg($sql);
        return $result;
    }

    /**
     * Método para actualizar en la tabla ruc_relationusercert.
     * @param RelationUserCerts $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function updateById($obj) {
        $sql = "UPDATE " . $this->tablename . " SET "
                . $this->col1 . " = " . $obj->getIdUser() . " "
                . $this->col2 . " = " . $obj->getIdCert() . " "
                . "WHERE " . $this->col1 . " = " . $obj->getIdUser() . " "
                . "AND " . $this->col2 . " = " . $obj->getIdCert() . ""
                . ";";
        $result = $this->fachada->db_update_pg($sql);
        return $result;
    }

    /**
     * Método para borrar en la tabla ruc_relationusercert.
     * @param RelationUserCerts $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function deleteById($obj) {
        $sql = "DELETE FROM " . $this->tablename . " "
                . "WHERE " . $this->col1 . " = " . $obj->getIdUser() . " "
                . "AND " . $this->col2 . " = " . $obj->getIdCert() . ""
                . ";";
        $result = $this->fachada->db_delete_pg($sql);
        return $result;
    }

    /**
     * Método para consultar en la tabla ruc_relationusercert.
     * @param RelationUserCerts $obj de la logica con los datos encapsulados.
     * @return RelationUserCerts el objeto que corresponde con la consulta.
     */
    function selectById($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col1 . " = " . $obj->getIdUser() . " "
                . "AND " . $this->col2 . " = " . $obj->getIdCert() . ""
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new RelationUserCerts();
        while ($row = pg_fetch_array($result)) {
            $objTmp->setIdUser($row[$this->col1]);
            $objTmp->getIdCert($row[$this->col2]);            
            break;
        }
        return $objTmp;
    }
    
    /**
     * Método para consultar todos los registros en la tabla ruc_relationusercert.
     * @return array con los objetos RelationUserCerts correspondientes.
     */
    function select() {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename . ""
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objArray = array();

        while ($row = pg_fetch_array($result)) {
            $objTmp = new RelationUserCert();
            $objTmp->setIdUser($row[$this->col1]);
            $objTmp->setIdCert($row[$this->col2]);            
            $objArray[] = $objTmp;
        }
        return $objArray;
    }
    
    /**
     * Método para consultar en la tabla ruc_relationusercert.
     * @param RelationUserCerts $obj de la logica con los datos encapsulados.
     * @return array con los objetos RelationUserCerts correspondientes.
     */
    function selectByIdUser($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col1 . " = " . $obj->getIdUser() . ""
                . ";";
       $result = $this->fachada->db_query_select_pg($sql);
        $objArray = array();

        while ($row = pg_fetch_array($result)) {
            $objTmp = new RelationUserCert();
            $objTmp->setIdUser($row[$this->col1]);
            $objTmp->setIdCert($row[$this->col2]);            
            $objArray[] = $objTmp;
        }
        return $objArray;
    }
    
    /**
     * Método para consultar en la tabla ruc_relationusercert.
     * @param RelationUserCerts $obj de la logica con los datos encapsulados.
     * @return array con los objetos RelationUserCerts correspondientes.
     */
    function selectByIdCert($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col2 . " = " . $obj->getIdCert() . ""
                . ";";
       $result = $this->fachada->db_query_select_pg($sql);
        $objArray = array();

        while ($row = pg_fetch_array($result)) {
            $objTmp = new RelationUserCert();
            $objTmp->setIdUser($row[$this->col1]);
            $objTmp->setIdCert($row[$this->col2]);            
            $objArray[] = $objTmp;
        }
        return $objArray;
    }

}

?>
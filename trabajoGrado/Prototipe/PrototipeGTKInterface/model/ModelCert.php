<?php

require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_FACHADA . '/Fachada.php' );
include_once( PWD_LOGICA . '/Cert.php' );

/**
 * Clase encargada de consultar, insertar y actualizar la tabla crt_cert de la 
 * base de datos.
 *
 * @author Edgar Moncada
 */
class ModelCert {

    /**
     * @var Fachada 
     */
    private $fachada;

    /**
     * Nombre de la tabla.
     * @var string.
     */
    private $tablename = "crt_cert";
    private $col1 = "crt_id";
    private $col2 = "crt_serial";
    private $col3 = "crt_issue";
    private $col4 = "crt_keypath";
    private $col5 = "crt_certpath";
    private $col6 = "crt_proxypath";

    /**
     * Constructor por defecto.
     */

    function __construct() {
        $this->fachada = new Fachada();
    }

    /**
     * Método para instertar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function insert($obj) {
        $sql = "INSERT INTO " . $this->tablename . " "
                . "VALUES ("
                . "" . "DEFAULT" . ", "
                . "'" . $obj->getSerial() . "', "
                . "'" . $obj->getIssue() . "', "
                . "'" . $obj->getKeyPath() . "', "
                . "'" . $obj->getCertPath() . "', "
                . "'" . $obj->getProxyPath() . "'"
                . ");";
        $result = $this->fachada->db_insert_pg($sql);
        return $result;
    }

    /**
     * Método para instertar en la tabla crt_cert con el id dado.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function insertId($obj) {
        $sql = "INSERT INTO " . $this->tablename . " "
                . "VALUES ("
                . "" . $obj->getId() . ", "
                . "'" . $obj->getSerial() . "', "
                . "'" . $obj->getIssue() . "', "
                . "'" . $obj->getKeyPath() . "', "
                . "'" . $obj->getCertPath() . "', "
                . "'" . $obj->getProxyPath() . "'"
                . ");";
        $result = $this->fachada->db_insert_pg($sql);
        return $result;
    }

    /**
     * Método para instertar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function updateById($obj) {
        $sql = "UPDATE " . $this->tablename . " SET "
                . $this->col2 . " = '" . $obj->getSerial() . "', "
                . $this->col3 . " = '" . $obj->getIssue() . "', "
                . $this->col4 . " = '" . $obj->getKeyPath() . "', "
                . $this->col5 . " = '" . $obj->getCertPath() . "', "
                . $this->col6 . " = '" . $obj->getProxyPath() . "' "
                . "WHERE " . $this->col1 . " = " . $obj->getId() . ""
                . ";";
        $result = $this->fachada->db_update_pg($sql);
        return $result;
    }

    /**
     * Método para instertar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
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
     * Método para instertar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
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
        $objTmp = new Cert();
        while ($row = pg_fetch_array($result)) {   
            $objTmp->setId($row[$this->col1]);
            $objTmp->setSerial($row[$this->col2]);
            $objTmp->setIssue($row[$this->col3]);
            $objTmp->setKeyPath($row[$this->col4]);
            $objTmp->setCertPath($row[$this->col5]);
            $objTmp->setProxyPath($row[$this->col6]);
            break;
        }        
        return $objTmp;
    }

    /**
     * Método para instertar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function selectBySerialIssue($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename ." "
                . "WHERE " . $this->col2 . " = '" . $obj->getSerial() . "' AND "
                . "" . $this->col3 . " = '" . $obj->getIssue() . "'"
                .";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new Cert();
        while ($row = pg_fetch_array($result)) {   
            $objTmp->setId($row[$this->col1]);
            $objTmp->setSerial($row[$this->col2]);
            $objTmp->setIssue($row[$this->col3]);
            $objTmp->setKeyPath($row[$this->col4]);
            $objTmp->setCertPath($row[$this->col5]);
            $objTmp->setProxyPath($row[$this->col6]);
            break;
        }        
        return $objTmp;
    }

}

?>

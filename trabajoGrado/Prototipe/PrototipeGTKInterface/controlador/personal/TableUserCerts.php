<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_MODEL . '/ModelRelationUserCert.php' );
include_once( PWD_MODEL . '/ModelCert.php' );
include_once( PWD_LOGICA . '/RelationUserCert.php' );
include_once( PWD_LOGICA . '/User.php' );
include_once( PWD_LOGICA . '/Cert.php' );

function printTableCertsUser($User) {
    $modelRelationUserCert = new ModelRelationUserCert();
    $relationUserCert = new RelationUserCert();
    $relationUserCert->setIdUser($User->getId());

    $result = $modelRelationUserCert->selectByIdUser($relationUserCert);

    echo "<table>";
    echo "<tr>";
    echo "<td>";
    echo "Id";
    echo "</td>";
    echo "<td>";
    echo "Serial";
    echo "</td>";
    echo "<td>";
    echo "Issue";
    echo "</td>";
    echo "<td>";
    echo "Used";
    echo "</td>";
    echo "</tr>";

    foreach ($result as $ruc) {
        $modelCert = new ModelCert();
        $certFind = new Cert();
        $certFind->setId($ruc->getIdCert());
        $cert = $modelCert->selectById($certFind);

        echo "<tr class='".isCertUsed($cert)."' >";
        echo "<td>";
        echo $cert->getId();
        echo "</td>";
        echo "<td>";
        echo $cert->getSerial();
        echo "</td>";
        echo "<td>";
        echo $cert->getIssue();
        echo "</td>";
        echo "<td>";
        echo isCertUsed($cert);
        echo "</td>";
        echo "</tr>";
    }
    echo "</table>";
    if (count($result) <= 0) {
        echo "No se encontraron registros.";
    }
}

function isCertUsed($cert) {
    if ($_SERVER["SSL_CLIENT_I_DN"] == $cert->getIssue()
            && $_SERVER["SSL_CLIENT_M_SERIAL"] == $cert->getSerial()) {
        return "selected";
    } else {
        return "";
    }
}

?>

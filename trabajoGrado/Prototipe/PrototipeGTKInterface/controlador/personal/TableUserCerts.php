<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_MODEL . '/ModelRelationUserCert.php' );
include_once( PWD_MODEL . '/ModelCert.php' );
include_once( PWD_LOGICA . '/RelationUserCert.php' );
include_once( PWD_LOGICA . '/User.php' );
include_once( PWD_LOGICA . '/Cert.php' );

function printTableUserCerts($user) {
    echo buildTableUserCerts($user);
}

function buildTableUserCerts($user) {

    $modelRelationUserCert = new ModelRelationUserCert();
    $relationUserCert = new RelationUserCert();
    $relationUserCert->setIdUser($user->getId());

    $data = array();

    $headers = array(
        "",
        array("Id", "Serial", "Issue", "Used")
    );

    $data[] = $headers;

    $result = $modelRelationUserCert->selectByIdUser($relationUserCert);

    foreach ($result as $ruc) {
        $modelCert = new ModelCert();
        $certFind = new Cert();
        $certFind->setId($ruc->getIdCert());
        $cert = $modelCert->selectById($certFind);
        $certsData = array(
            isCertUsed($cert),
            array(
                $cert->getId(),
                $cert->getSerial(),
                $cert->getIssue(),
                isCertUsed($cert)
            )
        );
        $data[] = $certsData;
    }

    $content = "\n<table>\n";
    $count = 0;
    foreach ($data as $row) {
        $content.= "\t<tr class='$row[0]'>\n";
        if ($count == 0) {
            foreach ($row[1] as $d) {
                $content.= "\t\t<th>\n";
                $content.= "\t\t\t$d\n";
                $content.= "\t\t</th>\n";
            }
            $count++;
        } else if($count< (count($data))) {
            foreach ($row[1] as $d) {
                $content.= "\t\t<td>\n";
                $content.= "\t\t\t$d\n";
                $content.= "\t\t</td>\n";
            }
            $count++;
        }
        $content.= "\t</tr>\n";
    }
    if (count($result) <= 0) {
        $content.= "\t<tr class='noFound'>\n";
        $content.= "\t\t<td colspan='4'>\n";
        $content.= "\t\t\tNo se encontraron registros.\n";
        $content.= "\t\t</td>\n";
        $content.= "\t</tr>\n";
    }

    $content.= "</table>\n";
    return $content;
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

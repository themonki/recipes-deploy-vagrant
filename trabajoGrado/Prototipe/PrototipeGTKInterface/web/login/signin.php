<?php
/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );

include_once( PWD_CONTROLADOR . '/login/Signin.php' );

include_once(PWD_CONTROLADOR . '/templates/TemplateManager.php');

$contenidoPrincipal = new TemplateManager();
$contenidoPrincipal->plantilla("signin");
$contenidoPrincipal->asigna_variables(array(
    "SITE_PROTOTIPE" => SITE_PROTOTIPE,
    "msg" => $msg,
    "msgshow" => $msgshow
));
$contenidoPrincipalString = $contenidoPrincipal->muestra();
echo $contenidoPrincipalString;

?>

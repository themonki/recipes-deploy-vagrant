<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_CONTROLADOR . '/login/Login.php' );
is_logged_in();
include_once(PWD_CONTROLADOR . '/templates/TemplateManager.php');


$message_class = 'none';
if (isset($_GET) && isset($_GET['message'])) {
    $message = $_GET['message'];
    $message_class = $_GET['message_class'];
}
$contenidoEditar = new TemplateManager();
$contenidoEditar->plantilla("edit");
$contenidoEditar->asigna_variables(array(
    "SITE_CONTROLADOR" => SITE_CONTROLADOR,
    "MESSAGE_CLASS" => $message_class,
    "MESSAGE" => $message,
    "SITE_WEB" => SITE_WEB,
    "NAME" => unserialize($_SESSION['user'])->getName(),
    "EMAIL" => unserialize($_SESSION['user'])->getEmail()
));


$contenidoEditarString = $contenidoEditar->muestra();

$contenidoPrincipal = new TemplateManager();
$contenidoPrincipal->plantilla("principal");
$contenidoPrincipal->asigna_variables(array(
    "SITE_PROTOTIPE" => SITE_PROTOTIPE,
    "SITE_WEB" => SITE_WEB,
    "NAME" => unserialize($_SESSION['user'])->getName(),
    "CONTAINER" => $contenidoEditarString
));
$contenidoPrincipalString = $contenidoPrincipal->muestra();
echo $contenidoPrincipalString;
?>

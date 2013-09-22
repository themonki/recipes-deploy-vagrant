<?php

/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
/*
 * Database Configaration 
 * */

define('DB_HOST', 'localhost');
define('DB_USER', 'globus');
define('DB_PASSWORD', 'globus');
define('DB_NAME', 'globusdatabase');

session_start();

/**
 * PATH PARA REDIRECCIONAR PAGINAS ENTRE OTRAS
 */
if (!isset($_SESSION['SITE_PROTOTIPE'])) {
    echo "asigna ";
    $_SESSION['SITE_PROTOTIPE'] = '/PrototipeGTKInterface';
    echo $_SESSION['SITE_PROTOTIPE'] . " ";
}

if (!isset($_SESSION['SITE_WEB'])) {
    echo ", web ";
    $_SESSION['SITE_WEB'] = $_SESSION['SITE_PROTOTIPE'] . '/web';
    echo $_SESSION['SITE_WEB'] . " ";
}

if (!isset($_SESSION['SITE_CONTROLADOR'])) {
    $_SESSION['SITE_CONTROLADOR'] = $_SESSION['SITE_PROTOTIPE'] . '/controlador';
}

if (!isset($_SESSION['SITE_PHPSECLIB'])) {
    $_SESSION['SITE_PHPSECLIB'] = $_SESSION['SITE_CONTROLADOR'] . '/phpseclib';
}

if (!isset($_SESSION['SITE_FACHADA'])) {
    $_SESSION['SITE_FACHADA'] = $_SESSION['SITE_CONTROLADOR'] . '/fachada';
}

if (!isset($_SESSION['SITE_TEMPLEATE'])) {
    $_SESSION['SITE_TEMPLEATE'] = $_SESSION['SITE_PROTOTIPE'] . '/templates';
}


/**
 * PATH EN EL SERVIDOR PARA IMPORTACIONES ENTRE OTRAS
 */
if (!isset($_SESSION['PWD_PROTOTIPE'])) {
    $_SESSION['PWD_PROTOTIPE'] = $_SERVER['DOCUMENT_ROOT'] . $_SESSION['SITE_PROTOTIPE'];
}

if (!isset($_SESSION['PWD_CONTROLADOR'])) {
    $_SESSION['PWD_CONTROLADOR'] = $_SESSION['PWD_PROTOTIPE'] . '/controlador';
}

if (!isset($_SESSION['PWD_PHPSECLIB'])) {
    $_SESSION['PWD_PHPSECLIB'] = $_SESSION['PWD_CONTROLADOR'] . '/phpseclib';
}

if (!isset($_SESSION['PWD_FACHADA'])) {
    $_SESSION['PWD_FACHADA'] = $_SESSION['PWD_CONTROLADOR'] . '/fachada';
}

if (!isset($_SESSION['PWD_TEMPLEATE'])) {
    $_SESSION['PWD_TEMPLEATE'] = $_SESSION['PWD_PROTOTIPE'] . '/templates';
}
?>
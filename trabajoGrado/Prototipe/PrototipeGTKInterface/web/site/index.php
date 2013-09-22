<?php
/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
session_start();
if (isset($_SESSION['PWD_CONTROLADOR'])) {
    include( $_SESSION['PWD_CONTROLADOR'] . '/login/Login.php' );
} else {
    include( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/login/Login.php' );
}
is_logged_in();
?>

<!DOCTYPE html>
<html>
    <head>
        <link rel='stylesheet' type='text/css' href='<?php echo $_SESSION['SITE_PROTOTIPE'] . "/css/"; ?>styleMenu.css' />
        <script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
    </head>
    <body>
        <?php 
            include( $_SESSION['PWD_TEMPLEATE'] . '/menu.php' );
            printMenu();
        ?>
    </body>
</html>


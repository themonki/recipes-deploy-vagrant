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

<!doctype html>
<html>
    <head>
        <script src="<?php echo $_SESSION['SITE_PROTOTIPE'] . "/js/"; ?>scripts.js" type="text/javascript"></script>
        <link rel='stylesheet' type='text/css' href='<?php echo $_SESSION['SITE_PROTOTIPE'] . "/css/"; ?>style.css' />
        <link rel='stylesheet' type='text/css' href='<?php echo $_SESSION['SITE_PROTOTIPE'] . "/css/"; ?>styleMenu.css' />
        <script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
    </head>
    <body>
        <div class="wrapper">
            <div class="header">
                <?php
                include( $_SESSION['PWD_TEMPLEATE'] . '/menu.php' );
                printMenu();
                ?>
            </div>
            <h2>Bienvenido</h2>
            <p>
                Este es la pagina principal para el prototipo de Interfaz.                             
            </p>            
        </div>
        <div class="footer">
            <p>
                Autor: Edgar Moncada
            </p>
        </div>
    </body>
</html>


<?php
/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
/**
 * Cleare session cookies
 */
session_start();
?>
<!doctype html>
<html>
    <head>
        <script src="<?php echo $_SESSION['SITE_PROTOTIPE'] . "/js/"; ?>scripts.js" type="text/javascript"></script> 
    </head>
    <body>
        <?php
        if (session_destroy()) {
            ?>
            <?php
            session_start();
            include( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
            header("Location: " . $_SESSION['SITE_WEB'] . "/login/signin.php");
        }
        ?>
    </body>
</html>




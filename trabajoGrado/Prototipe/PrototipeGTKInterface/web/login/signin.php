<?php
/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );

include_once( PWD_CONTROLADOR . '/login/Signin.php' );
/**
 * Estilo css styleLogin.css
 * http://ui-cloud.com/html-login-register-forms/
 */
?>
<!doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Iniciar Sesión</title>
        <link rel="stylesheet" href="<?php echo SITE_PROTOTIPE . "/css/"; ?>styleLogin.css" />
        <link rel="stylesheet" href="<?php echo SITE_PROTOTIPE . "/css/"; ?>styleMessages.css" />
    </head>
    <body>
        <form class="formLogin" action ="" method="POST">            
            <h2>Iniciar Sesión</h2>
            <input name="username" type="text" class="text-field" placeholder="Correo"
                   required="true" />
            <input name="password" type="password" class="text-field" placeholder="Contraseña"
                   required="true" />
            <input type="submit" value="Ingresar" class="button" />
            <div class="<?php echo $msgshow;  ?>" > <?php echo $msg; ?></div>
        </form>
    </body>
</html>
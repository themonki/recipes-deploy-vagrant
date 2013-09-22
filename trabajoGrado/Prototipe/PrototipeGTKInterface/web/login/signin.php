<?php
/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
session_start();
if (isset($_SESSION['PWD_CONTROLADOR'])) {
    include( $_SESSION['PWD_CONTROLADOR'] . '/login/Signin.php' );
} else {
    include( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/login/Signin.php' );
}
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
        <link rel="stylesheet" href="<?php echo $_SESSION['SITE_PROTOTIPE'] . "/css/"; ?>styleLogin.css" />
    </head>
    <body>
        <form class="<?php echo $formerror;  ?>" action ="" method="POST">            
            <h2>Iniciar Sesión</h2>
            <input name="username" type="text" class="text-field" placeholder="Correo"
                   required="true" />
            <input name="password" type="password" class="text-field" placeholder="Contraseña"
                   required="true" />
            <input type="submit" value="Ingresar" class="button" />
            <label style="<?php echo $msgshow;  ?>" class="error" > <?php echo $msg; ?></label>
        </form>        
        

    </body>
</html>
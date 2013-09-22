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

include( $_SESSION['PWD_TEMPLEATE'] . '/principal.php' );
print_up();
?>


<h2>Bienvenido <?php echo $_SESSION['name'];?>,</h2>
<p>
    Esta es la página principal para el prototipo de Interfaz.
</p>
<p>
    Si usted puede visualizar correctamente esta página es porque 
    acaba de ingresar por medio del usuario y contraseña 
    administrados y porque instalo correctamente su certificado de 
    usuario (.p12).
</p>
<p>
    <strong>Pero recuerde:</strong> que si esta utilizando un equipo
    que no es suyo, no olvide eliminar si certificado de usuario, 
    para que otros no puedan acceder como usted.
<p>
    Ahora disfrute de los servicios del Grid.
</p>

<?php
print_down();
?>
        


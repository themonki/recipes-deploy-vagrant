<?php
/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_CONTROLADOR . '/login/Login.php' );

is_logged_in();

include_once( PWD_CONTROLADOR . '/personal/TableUserCerts.php' );

include( PWD_TEMPLEATE . '/principal.php' );
print_up();
?>
<div class="profile">
    <div class="photo">
        <img src="<?php echo SITE_PROTOTIPE; ?>/resources/images/profile/profile_avatar.png">        
    </div>

    <div class="containerText">
        <div class="name">
            <h2><?php echo unserialize($_SESSION['user'])->getName(); ?></h2>
        </div>

        <div class="email">
            <h3><?php echo unserialize($_SESSION['user'])->getEmail(); ?></h3>
        </div>
    </div>

</div>

<div class="CSSTableGenerator" >
   <?php printTableCertsUser(unserialize($_SESSION['user']))?>
</div>

<?php
print_down();
?>
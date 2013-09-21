<?php
/**
* PHP Simpe Login
* @author Resalat Haque
* @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
*/
session_start();
if(isset($_SESSION['PWD_CONTROLADOR'])){
    include( $_SESSION['PWD_CONTROLADOR'] . '/login/Login.php' );
} else {
    include( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/login/Login.php' );
}
is_logged_in();
?>

<!DOCTYPE HTML>
<html>
<head>
	<title>Wellcome to secure page</title>
	<link rel="stylesheet" type="text/css" href="<?php echo $_SESSION['SITE_PROTOTIPE']."/css/"; ?>style.css">
</head>
<body class="full">
	<p>Hello <?php  echo $_SESSION['username'];?> !</p><br />
	<p>What are you feeling</p>
	<a href="signout.php">Sign out</a>
</body>
</html>
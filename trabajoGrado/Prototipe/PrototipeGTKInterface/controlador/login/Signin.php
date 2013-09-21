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

if( isset($_SESSION["username"]) && $_SESSION["password"]){
	if( valid_login($_SESSION["username"], $_SESSION["password"]) ){
	  	header("Location: ".$_SESSION['SITE_WEB']);
	}
} elseif( isset($_POST["username"]) && isset($_POST["password"]) ){
	$username = $_POST["username"];
	$password = md5($_POST["password"]);

	if( valid_login($username, $password) ){
		session_start();
		$_SESSION['username'] = $username;
		$_SESSION['password'] = $password;
		header("Location: ".$_SESSION['SITE_WEB']);
		exit;
	}
	else{
		$msg = "Fail to login. Wrong username or password!";
	}
}
?>

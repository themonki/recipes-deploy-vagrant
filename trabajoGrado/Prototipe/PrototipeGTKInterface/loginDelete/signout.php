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
if(session_destroy()){
header("Location: signin.php");
}
?>
<?php
/**
* PHP Simpe Login
* @author Resalat Haque
* @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
*/

session_start();
require_once( dirname(__FILE__) . '/config.php' );

function db_connect(){
	/**
	* DB connect and db select
	**/
	global $dbcon;
	$dbcon = mysql_connect(DB_HOST, DB_USER, DB_PASSWORD) or die('Fail to conncet DB '.mysql_error());
	$dbselect = mysql_select_db(DB_NAME, $dbcon) or die('Fail to select DB '.mysql_error());	
}


function cheque_user_name($user){
	/**
	* Cheque username is it alresdy exist or not. Return true is not exist else return false. 
	**/
	$query = mysql_query("SELECT * FROM `login` WHERE user = '$user'");
	$result = mysql_num_rows($query);
	if(  $result == 0){
		// User name is not alresdy exist in db
		return true;
	}
	else{
		// User name is already exist in db
		return false;
	}
}

function add_user($user, $password){
	/**
	* Insurt new user's name and password to db with dhassing password
	**/
	// Hash password in md5 format
	$query = "INSERT INTO `login` ( `id` ,`user` , `password` )
	VALUES ( NULL , '$user', '$password')";
	mysql_query($query);
	return true;
}

function valid_login($user, $password){
	/**
	* Cheque username and password is it match or not. If match return true else flase
	**/
	$query = mysql_query("SELECT id FROM `login` WHERE
		user = '$user' AND password = '$password'" );
	
	$result = mysql_num_rows($query);
	if( $result > 0){
		return true;
	}
}

function is_logged_in(){
	/**
	* Cheque session is user logged in or not
	**/
	if( isset( $_SESSION['username']) && isset($_SESSION["password"]) ){
		if( valid_login($_SESSION["username"], $_SESSION["password"]) ){
		}
		else{
	    	header("Location: signin.php");
			exit;
		}
	}
	else{
		header("Location: signin.php");
		exit;
	}
}

?>
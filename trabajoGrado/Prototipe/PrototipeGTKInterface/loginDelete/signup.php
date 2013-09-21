<?php
/**
* PHP Simpe Login
* @author Resalat Haque
* @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
*/

if($_SERVER["REQUEST_METHOD"] == "POST"){
	include('function.php');
	db_connect();
	if (isset($_POST["user"]) && isset($_POST["password"]) && $_POST["password"] == $_POST["password2"]){
		$user = $_POST["user"];
		$password = md5($_POST["password"]);
		if(cheque_user_name($user)){
			add_user($user,$password);
			$msg = 'Signup successfull!';
		}
		else{
			$msg = 'User name already exist! Try another...';
		}
	}
	else{
		$msg = 'Please cheque your inputs!';
	}
}

?>
<!DOCTYPE HTML>
<html>
<head>
	<title>Sing up</title>
	<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body class="min">
	<div class="form">
	<?php
	if(isset($msg)){
		echo "<p class='error'>{$msg}</p>";
	}
	?>
	<form action ="" method="post" >
		<b>User Name: </b><input type="text" name="user" /><br />
		<b>Password: </b><input type="password" name="password" /><br />
		<b>Re-type:  </b><input type="password" name="password2" /><br />
		<input type="submit" value="Sigin Up" />
	</form>
	</div>
</body>
</html>
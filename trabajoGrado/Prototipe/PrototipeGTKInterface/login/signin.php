<?php
/**
* PHP Simpe Login
* @author Resalat Haque
* @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
*/
include('function.php');
db_connect();

if( isset($_SESSION["username"]) && $_SESSION["password"]){
	if( valid_login($_SESSION["username"], $_SESSION["password"]) ){
	  	header("Location: index.php");
	}
}

elseif( isset($_POST["username"]) && isset($_POST["password"]) ){
	$username = $_POST["username"];
	$password = md5($_POST["password"]);

	if( valid_login($username, $password) ){
		session_start();
		$_SESSION['username'] = $username;
		$_SESSION['password'] = $password;
		header("Location: index.php");
		exit;
	}
	else{
		$msg = "Fail to login. Wrong username or password!";
	}
}
?>
<!DOCTYPE HTML>
<html>
<head>
	<title>Sign in</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body class="min">
	<p>Welcome to <a href="http://www.w3bees.com/2013/02/php-simple-log-in-example.html">PHP Sign in example</a> demo!</p>
	<p>User name: w3bees, Password: w3bees</p>
	<h1>Sign in</h1>
<div class="form">
	<?php
	if(isset($msg)){
		echo "<p class='error'>{$msg}</p>";
	}
	?>
	<form action ="" method="POST" >
		<lable><b>Username: </b><input type="text" name="username" /><br />
		<lable><b>Password: </b><input type="password" name="password" /><br />
		<input type="submit" value="Sigin in" />
	</form>
	<br />
	<br />
	<p>New user? <a href="signup.php">Sign up</a>
</div>

</body>
</html>
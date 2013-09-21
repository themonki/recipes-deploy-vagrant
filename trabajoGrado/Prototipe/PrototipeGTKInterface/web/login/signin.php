<?php
/**
* PHP Simpe Login
* @author Resalat Haque
* @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
*/
session_start();
    if(isset($_SESSION['PWD_CONTROLADOR'])){
        include( $_SESSION['PWD_CONTROLADOR'] . '/login/Signin.php' );
    } else {
        include( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/login/Signin.php' );
    }
?>
<!DOCTYPE HTML>
<html>
<head>
	<title>Sign in</title>
	<link rel="stylesheet" type="text/css" href="<?php echo $_SESSION['SITE_PROTOTIPE']."/css/"; ?>style.css">
</head>
<body class="min">
	<p>Welcome to <a href="http://www.w3bees.com/2013/02/php-simple-log-in-example.html">PHP Sign in example</a> demo!</p>
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
</div>

</body>
</html>
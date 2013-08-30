<html>
<body>
<form method="POST" action="">
<input type="text" name="comando">
<input type="submit" value="enviar">
</form>

<?php



 
if(isset($_GET['comando'])){
$var = system($_GET['comando']);
echo $var;
}



print nl2br(exec('/usr/bin/whoami'));

print "<br/>";

print nl2br(shell_exec('/usr/bin/whoami'));

print "<br/>";

print nl2br(exec('pwd'));

print "<br/>";

print nl2br(exec('ls -la'));

print "<br/>";



set_include_path(get_include_path() . PATH_SEPARATOR . 'phpseclib');

include('Net/SSH2.php');

define('NET_SSH2_LOGGING', NET_SSH2_LOG_COMPLEX);


$ssh = new Net_SSH2('mg2');
if (!$ssh->login('vagrant', 'vagrant')) {
    exit('Login Failed');
}

$ssh->setTimeout(10101010101010101010 nl2br($ssh->exec('/usr/bin/whoami'));

print "<br/>";

print nl2br($ssh->exec('pwd'));

print "<br/>";

print nl2br($ssh->exec('ls -la'));

print "<br/>**************************************<br/>";

//print $ssh->read('#[\[]*vagrant@mg2[ ~\]\$]*#');
print nl2br("grid-proxy-init\n");
$ssh->write("expect run-grid-proxy-init.exp -p vagrant\n");

print $ssh->read('#[\[]*vagrant@mg2[ ~\]\$]*#');
//echo $ssh->getLog();

?>
</body>
</html>

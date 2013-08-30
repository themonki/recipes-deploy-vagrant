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

$output = "";

$ssh->setTimeout(3);
/*
 nl2br($ssh->exec('/usr/bin/whoami'));
print nl2br($output);
print "<br/>";

$output = $ssh->exec('pwd');
echo nl2br($output);
print "<br/>";

$output = $ssh->exec('ls -la');

echo nl2br($output);
*/
print "<br/>**************************************<br/>";
$output = $ssh->read('#[\[]*vagrant@mg2[ ~\]\$]*#');
echo nl2br($output);
print "<br/>1<br/>";

echo nl2br("grid-proxy-init\n");
print "<br/>2<br/>";

$ssh->write("expect /tmp/run-grid-proxy-init.exp -p vagrant\n");

$output = $ssh->read('#[\[]*vagrant@mg2[ ~\]\$]*#');
echo nl2br($output);
print "<br/>3<br/>";

//echo $ssh->getLog();

?>
</body>
</html>




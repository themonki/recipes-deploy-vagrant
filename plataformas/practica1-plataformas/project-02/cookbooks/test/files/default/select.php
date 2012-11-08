<?php
$con = mysql_connect("172.18.0.2","root","");
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }

mysql_select_db("database1", $con);

$result = mysql_query("SELECT * FROM example");

while($row = mysql_fetch_array($result))
  {
  echo $row['name'] . " " . $row['age'];
  echo "<br />";
  }

mysql_close($con);
?>


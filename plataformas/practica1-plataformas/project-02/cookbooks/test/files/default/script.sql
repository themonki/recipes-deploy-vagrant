/*
http://www.w3schools.com/php/php_mysql_select.asp
http://www.w3schools.com/php/php_mysql_insert.asp
<?
phpinfo()
?>
*/
create database database1;
use database1;
CREATE TABLE example(
id INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(id),
 name VARCHAR(30), 
 age INT);
insert into example (name,age) values ('john',36);
-- http://www.linuxhomenetworking.com/wiki/index.php/Quick_HOWTO_:_Ch34_:_Basic_MySQL_Configuration
grant all privileges on database1.* to root@"%";

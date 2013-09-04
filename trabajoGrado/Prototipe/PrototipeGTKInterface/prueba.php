<html>
    <body>
        <form method="POST" action="prueba.php">
            <input type="text" name="comando">
            <input type="submit" value="enviar">
        </form>

        <?php

        /**
         * Determines if the browser provided a valid SSL client certificate
         *
         * @return boolean True if the client cert is there and is valid
         * http://cweiske.de/tagebuch/ssl-client-certificates.htm
         */
        function hasValidCert() {
            if (!isset($_SERVER['SSL_CLIENT_M_SERIAL'])
                    || !isset($_SERVER['SSL_CLIENT_V_END'])
                    || !isset($_SERVER['SSL_CLIENT_VERIFY'])
                    || $_SERVER['SSL_CLIENT_VERIFY'] !== 'SUCCESS'
                    || !isset($_SERVER['SSL_CLIENT_I_DN'])
            ) {
                return false;
            }

            if ($_SERVER['SSL_CLIENT_V_REMAIN'] <= 0) {
                return false;
            }

            return true;
        }
        
//        CREATE TABLE `sc_users_sslclientcerts` (
//            `id` INT NOT NULL AUTO_INCREMENT ,
//            `uId` INT NOT NULL ,
//            `sslSerial` VARCHAR( 32 ) NOT NULL ,
//            `sslClientIssuerDn` VARCHAR( 1024 ) NOT NULL ,
//            `sslName` VARCHAR( 64 ) NOT NULL ,
//            `sslEmail` VARCHAR( 64 ) NOT NULL ,
//            PRIMARY KEY ( `id` ) ,
//            UNIQUE (`id`)
//          ) CHARACTER SET utf8 COLLATE utf8_general_ci;

        
//        $query = 'INSERT INTO ' . $this->getTableName()
//            . ' '. $this->db->sql_build_array(
//                'INSERT', array(
//                'uId'               => $userId,
//                'sslSerial'         => $_SERVER['SSL_CLIENT_M_SERIAL'],
//                'sslClientIssuerDn' => $_SERVER['SSL_CLIENT_I_DN'],
//                'sslName'           => $_SERVER['SSL_CLIENT_S_DN_CN'],
//                'sslEmail'          => $_SERVER['SSL_CLIENT_S_DN_Email']
//            )
//        );
//print nl2br(exec('/usr/bin/whoami'));
//
//print "<br/>";
//
//print nl2br(shell_exec('/usr/bin/whoami'));
//
//print "<br/>";
//
//print nl2br(exec('pwd'));
//
//print "<br/>";
//
//print nl2br(exec('ls -la'));
//
//print "<br/>";

//        foreach ($_SERVER as $key_name => $key_value) {
//
//            print $key_name . " = " . $key_value . "<br>";
//        }


        set_include_path(get_include_path() . PATH_SEPARATOR . 'phpseclib');

        include('Net/SSH2.php');

        define('NET_SSH2_LOGGING', NET_SSH2_LOG_COMPLEX);

        $user = "vagrant";
        $passuser = "vagrant";
        $host = "mg2";
        $ssh = new Net_SSH2('mg2');
        if (!$ssh->login($user, $passuser)) {
            exit('Login Failed');
        }

        $output = "";

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
//print "<br/>**************************************<br/>";
        //[vagrant@mg2 tmp]$
        $output = $ssh->read('['.$user.'@'.$host.' ~]$');
        echo nl2br($output);
//print "<br/>1<br/>";
//echo nl2br("grid-proxy-init\n");
//print "<br/>2<br/>";

        //$ssh->write("expect /tmp/run-grid-proxy-init.exp -p vagrant\n");

        //$output = $ssh->read('#[\[]*vagrant@mg2[ ~\]\$]*#');
//echo nl2br($output);
//print "<br/>3<br/>";
        if(hasValidCert()){
            echo "<br/>es valido";
        }

        if (isset($_POST['comando'])) {

            $var = $_POST['comando'];

            $ssh->write("$var\n");

            $output = $ssh->read('#[\[]*vagrant@mg2[ ~\]\$]*#');
            echo nl2br($output);
        }
//globusrun -status https://172.18.0.21:43922/16362122880619392831/4895484430711845780/
//globusrun -b -r 172.18.0.21/jobmanager-fork "&(executable=/bin/sleep)(arguments=50000)"
//echo $ssh->getLog();
        ?>
    </body>
</html>



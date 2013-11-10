<?php
session_start();
include_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
?>
<html>
    <head>
        <script src="<?php print SITE_PROTOTIPE . "/js/"; ?>/scripts.js" type="text/javascript"></script>        
    </head>
    <body style="white-space:pre-wrap">
        <form method="POST" action="prueba.php">
            <input style="width: 800px" type="text" name="comando"/>
            <input type="submit" value="enviar"/>
        </form><?php
        header("Expires: Tue, 01 Jan 2000 00:00:00 GMT");
        header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
        header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
        header("Cache-Control: post-check=0, pre-check=0", false);
        header("Pragma: no-cache");

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
//        `id` INT NOT NULL AUTO_INCREMENT,
//        `uId` INT NOT NULL,
//        `sslSerial` VARCHAR( 32 ) NOT NULL,
//        `sslClientIssuerDn` VARCHAR( 1024 ) NOT NULL,
//        `sslName` VARCHAR( 64 ) NOT NULL,
//        `sslEmail` VARCHAR( 64 ) NOT NULL,
//        PRIMARY KEY ( `id` ),
//        UNIQUE (`id`)
//        ) CHARACTER SET utf8 COLLATE utf8_general_ci;
//        $query = 'INSERT INTO ' . $this->getTableName()
//                . ' ' . $this->db->sql_build_array(
//                        'INSERT', array(
//                    'uId' => $userId,
//                    'sslSerial' => $_SERVER['SSL_CLIENT_M_SERIAL'],
//                    'sslClientIssuerDn' => $_SERVER['SSL_CLIENT_I_DN'],
//                    'sslName' => $_SERVER['SSL_CLIENT_S_DN_CN'],
//                    'sslEmail' => $_SERVER['SSL_CLIENT_S_DN_Email']
//                        )
//        );
        print nl2br(exec('/usr/bin/whoami'));
        print "<br/>";
        print shell_exec('/usr/bin/whoami');
        print nl2br(exec('pwd'));
        print nl2br("<br/>");
        print nl2br(exec('ls -la'));
        print nl2br("<br/>");

//        foreach ($_SERVER as $key_name => $key_value) {
//
//            nl2br $key_name . " = " . $key_value . "<br>";
//        }
        var_dump($_SERVER);
        print "<br/>*********************************************************************";

        require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );

        set_include_path(get_include_path() . PATH_SEPARATOR . PWD_PHPSECLIB);

        include('Net/SSH2.php');

        define('NET_SSH2_LOGGING', NET_SSH2_LOG_COMPLEX);

        $user = "vagrant";
        $passuser = "vagrant";
        $host = "mg2";
        $ssh = new Net_SSH2('mg2');
        if (!$ssh->login($user, $passuser)) {
            exit('Login Failed');
        }
        print "<br/>";
        $output = $ssh->exec('/usr/bin/whoami');
        print $output;
        $output = $ssh->exec('pwd');
//        print $output;
        $output = $ssh->exec('ls -la');
//        print $output;
        print "<br/>**************************************<br/>";
//        [vagrant@mg2 tmp]$
        $output = $ssh->read('[' . $user . '@' . $host . ' ~]$');
        print $output;
        print "<br/>";
        $ssh->write("expect /tmp/run-grid-proxy-init.exp -p vagrant\n");
        $output = $ssh->read('[' . $user . '@' . $host . ' ~]$');
//        print $output;
        if (hasValidCert()) {
            print "<br/>es valido";
            print "<br/>";
        }
        print "<br/>**************************************<br/>";
        $datos = openssl_x509_parse($_SERVER['SSL_CLIENT_CERT']);
//        var_dump($datos);
        print "<br/>**************************************<br/>";
        $p12cert = array();
        openssl_pkcs12_read($_SERVER['SSL_CLIENT_CERT'], $p12cert, 'client');        
//        var_dump($p12cert);
        print "<br/>**************************************<br/>";
        if (isset($_POST['comando'])) {
            $var = $_POST['comando'];
            $ssh->write("$var\n");
            $output = $ssh->read('[' . $user . '@' . $host . ' ~]$');
            print $output;
        }

//        globusrun -status url
        //        globusrun -b -r 172.18.0.21/jobmanager-fork "&(executable=/bin/sleep)(arguments=50000)"
//        print $ssh->getLog();
        ?>
    </body>
</html>



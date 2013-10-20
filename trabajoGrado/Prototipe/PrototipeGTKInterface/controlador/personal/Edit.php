<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_MODEL . '/ModelUser.php' );
include_once( PWD_LOGICA . '/User.php' );
include_once ( PWD_CONTROLADOR . '/login/Login.php' );

if (isset($_POST)) {
    $name = $_POST['name'];
    $password = $_POST['passwordNew']; // encriptado
    $modelUser = new ModelUser();
    $user = $modelUser->selectById(unserialize($_SESSION['user']));

    $user->setName($name);
    if(isset($password) && $password!='' ) {
        $user->setPassword(md5($password));
    }

    $result = $modelUser->updateById($user);

    if (isset($result) && $result > 0) {
        $message = "Correcto";
        $message_class = "success";
        $user = $modelUser->selectById($user);
        setting_Session($user);
    } else {
        //error
        $message = "Error";
        $message_class = "error";        
    }
    header("Location: " . SITE_WEB . "/site/personal/edit.php?message=".$message."&message_class=".$message_class);
//    exit;
}
?>
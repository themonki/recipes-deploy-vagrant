<?php

/**
 * Imprime la plantilla, el layout con el menu.
 * para mostrar el contenido se llama a la funcion.
 * 
 * print_up();
 * 
 * contenido
 * 
 * print_down();
 */
session_start();

require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );

function print_up() {
    echo "
<!doctype html>
    <html>
        <head>
            <script src='" . SITE_PROTOTIPE . "/js/scripts.js' type='text/javascript'></script>
            <link rel='stylesheet' type='text/css' href='" . SITE_PROTOTIPE . "/css/style.css' />
            <link rel='stylesheet' type='text/css' href='" . SITE_PROTOTIPE . "/css/styleMenu.css' />
            <link rel='stylesheet' type='text/css' href='" . SITE_PROTOTIPE . "/css/styleProfile.css' />
            <link rel='stylesheet' type='text/css' href='" . SITE_PROTOTIPE . "/css/styleTable.css' />
            <script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
        </head>
        <body>
            <div class='wrapper'>
                <div class='header'>";

    include( PWD_TEMPLEATE . '/menu.php' );
    printMenu();
    echo "
                </div>
                ";
}

function print_down() {

    echo "
            </div>
            <div class='footer'>
                <p>
                    Autor: Edgar Moncada
                </p>
            </div>
        </body>
    </html>";
}
?>






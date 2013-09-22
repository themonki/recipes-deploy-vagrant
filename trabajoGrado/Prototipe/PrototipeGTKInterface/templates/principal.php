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
if (isset($_SESSION['PWD_CONTROLADOR'])) {
    include( $_SESSION['PWD_CONTROLADOR'] . '/config.php' );
} else {
    include( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
}

function print_up() {
    echo "
<!doctype html>
    <html>
        <head>
            <script src='" . $_SESSION['SITE_PROTOTIPE'] . "/js/scripts.js' type='text/javascript'></script>
            <link rel='stylesheet' type='text/css' href='" . $_SESSION['SITE_PROTOTIPE'] . "/css/style.css' />
            <link rel='stylesheet' type='text/css' href='" . $_SESSION['SITE_PROTOTIPE'] . "/css/styleMenu.css' />
            <script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>
        </head>
        <body>
            <div class='wrapper'>
                <div class='header'>";

                    include( $_SESSION['PWD_TEMPLEATE'] . '/menu.php' );
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






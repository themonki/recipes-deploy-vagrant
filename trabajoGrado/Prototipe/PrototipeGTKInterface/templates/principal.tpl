<!doctype html>
<html>
    <head>
        <script src='{SITE_PROTOTIPE}/js/scripts.js' type='text/javascript'></script>
        <link rel='stylesheet' type='text/css' href='{SITE_PROTOTIPE}/css/style.css' />
        <link rel='stylesheet' type='text/css' href='{SITE_PROTOTIPE}/css/styleMenu.css' />
        <link rel='stylesheet' type='text/css' href='{SITE_PROTOTIPE}/css/styleProfile.css' />
        <link rel='stylesheet' type='text/css' href='{SITE_PROTOTIPE}/css/styleTable.css' />
        <link rel='stylesheet' type='text/css' href='{SITE_PROTOTIPE}/css/styleForm.css' />
    </head>
    <body>
        <div class='wrapper'>
            <div class='header'>
                <div class = 'cssmenu'>
                    <ul>
                        <li class = 'last'> <a href = '{SITE_WEB}/login/signout.php'<span>Salir</span></a> </li>
                        <li class = 'has-sub'><a href = '#'><span>{NAME}</span></a>
                            <ul>
                                <li><a href = '{SITE_WEB}/site/personal/index.php'><span>Ver Perfil</span></a></li>
                                <li class = 'last'><a href = '{SITE_WEB}/site/personal/edit.php'><span>Editar Perfil</span></a></li>
                            </ul>
                        </li>
                        <li><a href = '#'><span>Dashboard</span></a></li>
                        <li><a href = '{SITE_WEB}/site/index.php'><span>Inicio</span></a></li>
                    </ul>
                </div>
            </div>
            <div class='container'>
                {CONTAINER}
            </div>
            <div class='footer'>
                <p>
                    Autor: Edgar Moncada
                </p>
            </div>        
        </div>            
    </body>
</html>
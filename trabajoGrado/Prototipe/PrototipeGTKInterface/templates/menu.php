<?php

session_start();

function printMenu() {

echo "        <div class = 'cssmenu'>
            <ul>
                <li class = 'last'> <a href = '" . $_SESSION['SITE_WEB'] . "/login/" . "signout.php'<span>Logout</span></a> </li>
                <li class = 'has-sub'><a href = '#'><span>" . $_SESSION['name'] . "</span></a>
                    <ul>
                        <li><a href = '#'><span>View Profile</span></a></li>
                        <li class = 'last'><a href = '#'><span>Edit Profile</span></a></li>
                    </ul>
                </li>
                <li><a href = '#'><span>Dashboard</span></a></li>
                <li><a href = '" . $_SESSION['SITE_WEB'] . "/" . "index.php'><span>Home</span></a></li>
            </ul>
        </div>
";
}
?>

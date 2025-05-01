<?php

$cfg = [
    'dbhost' => "database",
    'dbname' => "example_cms_db",
    'dbuser' => getenv("MYSQL_USER") ?: "example_cms_user",
    'dbpwd' => getenv("MYSQL_PASSWORD") ?: "example_cms_password",
];


date_default_timezone_set("Europe/London");
$dblink = new mysqli($cfg["dbhost"], $cfg["dbuser"], $cfg["dbpwd"], $cfg["dbname"]);


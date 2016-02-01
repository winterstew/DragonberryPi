<?php
/**
 * Sample configuration file
 */
$config['app']['name'] = 'DragonberryPi';
$config['app']['root'] = (!empty($_SERVER['APP_ROOT'])) ? $_SERVER['APP_ROOT'] : '';

$config['app']['db'] = array(
    'driver'   => 'mysql',
    'host'     => 'localhost',
    'port'     => '3306',
    'user'     => (!empty($_SERVER['DB_USER'])) ? $_SERVER['DB_USER'] : 'user',
    'password' => (!empty($_SERVER['DB_PASSWORD'])) ? $_SERVER['DB_PASSWORD'] : 'password',
    'name'     => (!empty($_SERVER['DB_NAME'])) ? $_SERVER['DB_NAME'] : 'DragonberryPi',
);

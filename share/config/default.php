<?php
/**
 * Sample configuration file
 */
$config['name'] = 'DragonberryPi';
$config['root'] = (!empty($_SERVER['APP_ROOT'])) ? $_SERVER['APP_ROOT'] : '';
$config['logfile'] = dirname(__FILE__) . '/../../logs/app.log';
$config['mode'] =  (!empty($_SERVER['SLIM_MODE'])) ? $_SERVER['SLIM_MODE']: 'production';

$config['db'] = array(
    'driver'   => 'mysql',
    'host'     => 'localhost',
    'port'     => '3306',
    'user'     => (!empty($_SERVER['DB_USER'])) ? $_SERVER['DB_USER'] : 'user',
    'password' => (!empty($_SERVER['DB_PASSWORD'])) ? $_SERVER['DB_PASSWORD'] : 'password',
    'name'     => (!empty($_SERVER['DB_NAME'])) ? $_SERVER['DB_NAME'] : 'DragonberryPi',
);

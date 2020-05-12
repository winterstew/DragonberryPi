<?php
use \Monolog\Logger;
use \Monolog\Handler\StreamHandler;

// Including global autoloader
require_once dirname(__FILE__) . '/../vendor/autoload.php';

// Basic config for Slim Application
$config = array(
    'displayErrorDetails' => true,
);

// Load config file
$configFile = dirname(__FILE__) . '/../share/config/default.php';

if (is_readable($configFile)) {
    require_once $configFile;
}

// Create application instance with config
$app = new \Slim\App(["settings" => $config]);

$container = $app->getContainer();

// add a logger
$container['logger'] = function($c) {
    $logger = new Logger($c['settings']['name']);
    $level = array('development'=>Logger::DEBUG,'production'=>Logger::ERROR);
    $file_handler = new StreamHandler($c['settings']['logfile'], $level[$c['settings']['mode']]);
    $logger->pushHandler($file_handler);
    return $logger;
};

// add a database connection
$container['connection'] = function ($c) {
    // Define connection as a static variable, to avoid connecting more than once
    static $connection;
    // Try and connect to the database, if a connection has not been established yet
    if(!isset($connection)) {
        $conf = $c['settings']['db'];
        // Load configuration as an array. Use the actual location of your configuration file
        $connection = mysqli_connect($conf['host'],
                                     $conf['user'],
                                     $conf['password'],
                                     $conf['name'],
                                     $conf['port']);
        // If connection was not successful, handle the error
        if($connection === false) {
            // Handle error - notify administrator, log to a file, show an error screen, etc.
            return mysqli_connect_error(); 
        }
    }
    return $connection;
};


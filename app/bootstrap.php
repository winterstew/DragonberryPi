<?php
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

// Including global autoloader
require_once dirname(__FILE__) . '/../vendor/autoload.php';

// Init config data
$config = array();

// Basic config for Slim Application
$config['app'] = array(
    'name' => 'DragonberryPi',
    'log.enabled' => true,
    'log.level' => Slim\Log::INFO,
    'log.writer' => new Slim\Extras\Log\DateTimeFileWriter(array(
        'path' => dirname(__FILE__) . '/../share/logs'
    )),
    'mode' => (!empty($_SERVER['SLIM_MODE'])) ? $_SERVER['SLIM_MODE']: 'production'
);

// Load config file
$configFile = dirname(__FILE__) . '/../share/config/default.php';

if (is_readable($configFile)) {
    require_once $configFile;
}

function db_connect($conf) {
    // Define connection as a static variable, to avoid connecting more than once 
    static $connection;
    // Try and connect to the database, if a connection has not been established yet
    if(!isset($connection)) {
        // Load configuration as an array. Use the actual location of your configuration file
        $connection = mysqli_connect($conf['host'],
                                     $conf['user'],
                                     $conf['password'],
                                     $conf['name'],
                                     $conf['port']);
    }
    // If connection was not successful, handle the error
    if($connection === false) {
        // Handle error - notify administrator, log to a file, show an error screen, etc.
        return mysqli_connect_error(); 
    }
    return $connection;
}

// Create application instance with config
$app = new Slim\App($config['app']);

// Get logger
$log = $app->getLog();

// Only invoked if mode is "production"
$app->configureMode('production', function () use ($app) {
    $app->config(array(
        'log.enable' => true,
        'log.level' => Slim\Log::WARN,
        'debug' => false
    ));
});

// Only invoked if mode is "development"
$app->configureMode('development', function () use ($app) {
    $app->config(array(
        'log.enable' => true,
        'log.level' => Slim\Log::DEBUG,
        'debug' => true
    ));
});

// Other config here (i.e. database, mail system, etc)...

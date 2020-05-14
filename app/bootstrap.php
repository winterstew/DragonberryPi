<?php
use \Monolog\Logger;
use \Monolog\Handler\StreamHandler;
use \Tuupola\Middleware\HttpBasicAuthentication;
use \Tuupola\Middleware\HttpBasicAuthentication\PdoAuthenticator;

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
    // set level based on development or production 
    // Monolog supports the logging levels described by RFC 5424:
    //  DEBUG (100): Detailed debug information.
    //  INFO (200): Interesting events. Examples: User logs in, SQL logs.
    //  NOTICE (250): Normal but significant events.
    //  WARNING (300): Exceptional occurrences that are not errors. 
    //  ERROR (400): Runtime errors that do not require immediate action but should typically be logged and monitored.
    //  CRITICAL (500): Critical conditions. Example: Application component unavailable, unexpected exception.
    //  ALERT (550): Action must be taken immediately. 
    //  EMERGENCY (600): Emergency: system is unusable.
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

// add HTTP Basic Authentication
// passwords need to be created with password_hash with PASSWORD_DEFAULT
$container['pdo'] = function ($c) {
    $host = $c['settings']['db']['host'];
    $dbname = $c['settings']['db']['name'];
    $username = $c['settings']['db']['user'];
    $password = $c['settings']['db']['password'];
    $charset = 'utf8';
    $collate = 'utf8_unicode_ci';
    $dsn = "mysql:host=$host;dbname=$dbname;charset=$charset";
    $options = [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_PERSISTENT => false,
        PDO::ATTR_EMULATE_PREPARES => false,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES $charset COLLATE $collate"
    ];
    return new PDO($dsn, $username, $password, $options);
};

$app->add(new HttpBasicAuthentication([
    "path" => "/",
    "ignore" => ["/login","/checkUser","/home","/logout"],
    "realm" => "DragonberryPi",
#    "users" => [
#        "gm" => '$2y$10$rtE03IHT3GfbYm8CJEFO8udE34zgP7BePodqgym/KjcJcavqdG/W6',
#        "pc" => '$2y$10$TBqi/txEYuw00ebwB3rlD.oFlK3ZZRhyQx7bDrNT9cUxJsIyvgUP.'
#    ],
    "authenticator" => new PdoAuthenticator([
        "pdo" => $container->pdo,
        "table" => "ValidUser",
        "user" => "user",
        "hash" => "hash"
    ]),
    "error" => function ($response, $arguments) {
        $data = [];
        $data["headers"] = $response->getHeaders();
        $data["status"] = "error";
        $data["message"] = $arguments["message"];

        $body = $response->getBody();
        $body->write(json_encode($data,JSON_UNESCAPED_SLASHES));
    }
]));

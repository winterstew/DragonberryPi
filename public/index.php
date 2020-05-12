<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \Interop\Container\ContainerInterface as ContainerInterface;

// Start the session
session_start();

// Include application bootstrap
require_once dirname(__FILE__) . '/../app/bootstrap.php';

// Defining routes
$app->get('/hello/{name}', function (Request $request, Response $response, array $args) {
    $name = $args['name'];
    $greeter = new \AppLib\Helpers\Hello($name);
    $response->getBody()->write($greeter->greet());
    $this->logger->info("Just logging $name visit...");
    
    return $response;
});

// Uncomment below to enable the about to check out variables
// Do not leave on though... security risk.
$app->get('/about', function (Request $request, Response $response, array $args) {
    $body = $response->getBody();
    $body->write("<h1>About ", $this['settings']['name'], "</h1>");
    $body->write("<h2>\$_SERVER</h2>");
    $body->write('<pre>' . var_export($_SERVER, true) . '</pre>');
    $auth_user = $_SERVER['PHP_AUTH_USER'];
    $auth_pass = $_SERVER['PHP_AUTH_PW'];
    $body->write("<h2>\$_ENV</h2>");
    $body->write('<pre>' . var_export($_ENV, true) . '</pre>');
    $body->write("<h2>\$_SESSION</h2>");
    $body->write('<pre>' . var_export($_SESSION, true) . '</pre>');
    $body->write("<h2>settings</h2>");
    $body->write('<pre>' . var_export($this['settings'], true) . '</pre>');
    $body->write("<h2>Browser</h2>");
    $browser = new Browser();
    //if ( $browser->getBrowser() == Browser::BROWSER_FIREFOX && $browser->getVersion() >=10 ) {
    //    $body->write("you have Firefox version 10 or greater");
    //}
    $body->write($browser->getBrowser() . " ");
    $body->write($browser->getVersion() . " ");
    $body->write($browser->getPlatform() . " ");
    $body->write($browser->getUserAgent() . " ");
    //$body->write($browser->isMobile() . " ");
    //$body->write($browser->isTablet() . " ");
});

$app->map(['GET', 'POST'], '/', function (Request $request, Response $response, array $args) {
    if (isset($_POST['but_logout'])) {
        session_unset();
        session_destroy();
    }
    // If uname is already set the user is already logged in
    if(!isset($_SESSION['uname'])){
        require dirname(__FILE__) . '/../app/login.php';
    } else {
        require dirname(__FILE__) . '/../app/home.php';
    }
});

/*
$app->post('/checkUser', function (Request $request, Response $response, array $args) {
    $logger = $this->logger;
    $conn = $this->connection;
    $requestBody = $request->getParsedBody();
    $checkUser = new \AppLib\DatabaseCalls\checkUser($conn,$requestBody['username'],$requestBody['password'],$logger);
    $check = $checkUser->isValid();
    if ($check) {
        // Lets save the username and password, both as indication of being logged in
        //  and to use for feeding mod_dbd for the image pages
        $_SESSION['uname'] = $requestBody['username'];
        $_SESSION['pass'] = $requestBody['password'];
        $_SERVER['PHP_AUTH_USER'] = $requestBody['username'];
        $_SERVER['PHP_AUTH_PW'] = $requestBody['password'];
        $_SERVER['AUTH_TYPE'] = 'Basic';
    }
    $response->getBody()->write($check);
});

$app->post('/adventure', function (Request $request, Response $response, array $args) {
    echo "Let's Play!!!";
});


$app->get('/map/:mapMode/:aId/', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../adventure.php';
})->conditions(array('mapMode' => '(pc||dm)','aId' => '\d\d*'));

$app->get('/design/', function () use ($app, $log) {
    require dirname(__FILE__) . '/../design.php';
});

$app->post('/design/select', function () use ($app, $log) {
    require dirname(__FILE__) . '/../select.php';
});

//$app->post('/select', function () use ($app, $log) {
//    require dirname(__FILE__) . '/../select.php';
//});

$app->post('/design/showColumns', function () use ($app, $log) {
    require dirname(__FILE__) . '/../showColumns.php';
});

//$app->post('/showColumns', function () use ($app, $log) {
//    require dirname(__FILE__) . '/../showColumns.php';
//});

$app->post('/design/updateRecord', function () use ($app, $log) {
    require dirname(__FILE__) . '/../updateRecord.php';
});

$app->post('/design/insertRecord', function () use ($app, $log) {
    require dirname(__FILE__) . '/../insertRecord.php';
});

//$app->get('/herolab/:mapId/:pawnName/:modifierName/toggleNamedPawnModifier', function ($mapId, $pawnName, $modifierName) use ($app, $log) {
//    $greeter = new AppLib\Helpers\Hello("Toggle $pawnName's $modifierName status on map $mapId");
//    echo $greeter->greet();
//    $log->info("Just logging $pawnName visit...");
//});

$app->post('/map/:mapMode/:aId/adjustPawnIndicator', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../adjustPawnIndicator.php';
});

$app->post('/map/:mapMode/:aId/checkForUpdates', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../checkForUpdates.php';
});

$app->post('/map/:mapMode/:aId/checkPawnModifiers', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../checkPawnModifiers.php';
});

$app->post('/map/:mapMode/:aId/checkPawnProperties', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../checkPawnProperties.php';
});

$app->post('/map/:mapMode/:aId/saveMapTilePawn', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../saveMapTilePawn.php';
});

$app->post('/map/:mapMode/:aId/toggleModifier', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../toggleModifier.php';
});

$app->post('/map/:mapMode/:aId/toggleVisibility', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../toggleVisibility.php';
});

$app->post('/map/:mapMode/:aId/toggleShowName', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../toggleShowName.php';
});

$app->post('/map/:mapMode/:aId/updatePawnAttackType', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../updatePawnAttackType.php';
});

$app->post('/map/:mapMode/:aId/pullRole', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../pullRole.php';
});

$app->get('/herolab/:mapId/:pawnName/:modifierName/toggle', function ($mapId, $pawnName, $modifierName) use ($app, $log) {
    require dirname(__FILE__) . '/../toggleNamedPawnModifier.php';
});

*/

// Important: run the app ;)
$app->run();

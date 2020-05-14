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
    #$auth_user = $_SERVER['PHP_AUTH_USER'];
    #$auth_pass = $_SERVER['PHP_AUTH_PW'];
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

$app->map(['GET', 'POST'], '/login', function (Request $request, Response $response, array $args) {
    $login = file_get_contents(dirname(__FILE__) . "/../app/login.php");
    $response->getBody()->write($login);
});

$app->map(['GET', 'POST'], '/logout', function (Request $request, Response $response, array $args) {
    $logger = $this->logger;
    $logger->info("logging out");
    $conn = $this->connection;
    $user = new userManagement($conn,$_SESSION['uname'],$_SESSION['pass'],$logger);
    $check = $user->logout();
    $login = file_get_contents(dirname(__FILE__) . "/../app/login.php");
    $response->getBody()->write($login);
});

$app->map(['GET', 'POST'], '/home', function (Request $request, Response $response, array $args) {
    $home = file_get_contents(dirname(__FILE__) . "/../app/home.php");
    $response->getBody()->write($home);
});

$app->map(['GET', 'POST'], '/', function (Request $request, Response $response, array $args) {
    $response->getBody()->write("<h1>main page</h1>");
});

$app->get('/images/{data:.+}', function (Request $request, Response $response, array $args) {
    $data = $args['data'];
    $this->logger->info("the data is '$data'");
    $image = file_get_contents(dirname(__FILE__) . "/../images/$data");
    if($image === FALSE) {
        $handler = $this->notFoundHandler;
        return $handler($request, $response);    
    }
    
    $response->write($image);
    return $response->withHeader('Content-Type', FILEINFO_MIME_TYPE);
});
use \AppLib\DatabaseCalls\userManagement as userManagement;
$app->post('/checkUser', function (Request $request, Response $response, array $args) {
    $logger = $this->logger;
    $logger->info("time to check the login");
    $conn = $this->connection;
    $requestBody = $request->getParsedBody();
    $user = new userManagement($conn,$requestBody['username'],$requestBody['password'],$logger);
    $check = $user->isValid();
    if ($check) { $user->login(); }
    $response->getBody()->write($check);
    #return $response->appendHeader('Authorization', 'Basic ' . 
    #    base64_encode($_SESSION['uname'] . ':' . $_SESSION['pass']));

});

/*
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

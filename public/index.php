<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \Interop\Container\ContainerInterface as ContainerInterface;
use \AppLib\DatabaseCalls\userManagement as userManagement;

// Start the session
session_start();

// Include application bootstrap
require_once dirname(__FILE__) . '/../app/bootstrap.php';

// Defining routes
//$app->get('/hello/{name}', function (Request $request, Response $response, array $args) {
//    $name = $args['name'];
//    $greeter = new \AppLib\Helpers\Hello($name);
//    $response->getBody()->write($greeter->greet());
//    $this->logger->info("Just logging $name visit...");
//    return $response;
//});

// Uncomment below to enable the about to check out variables
// Do not leave on though... security risk.
$app->get('/about', function (Request $request, Response $response, array $args) {
    $body = $response->getBody();
    $javascript = '<script src="jquery-3.5.1.js" type="text/javascript"></script>';
    $javascript .= '<script type="text/javascript">';
    $javascript .= 'var keyValues = [], global = window;';
    $javascript .= 'for (var prop in global) {';
    $javascript .= ' keyValues.push(prop + "=" + global[prop]);';
    $javascript .= '}';
    $javascript .= 'msg="<h2>java globals</h2>" + keyValues.join("<br>");';
    $javascript .= '$(document).ready(function(){$("#javavar").html(msg)});';
    $javascript .= '</script>';
    $body->write($javascript);
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
    $body->write("<div id='javavar'></div>");
});

$app->post('/logout', function (Request $request, Response $response, array $args) {
    $logger = $this->logger;
    $logger->info("logging out");
    $conn = $this->connection;
    $user = new userManagement($conn,$_SESSION['uname'],$_SESSION['pass'],$logger);
    $check = $user->logout();
    return $response->withRedirect('/', 301); 
});

$app->map(['GET', 'POST'], '/adventure', function (Request $request, Response $response, array $args) {
    $conn = $this->connection;
    $logger = $this->logger;
    if (loggedIn($conn,$logger)) {
        $response->getBody()->write("<h1>Adventure Time!</h1>");
    } else {
        return $response->withRedirect('/', 301); 
    }
});

$app->get('/fail', function (Request $request, Response $response, array $args) {
    // increment attempt number
    $_SESSION['loginAttempts'] = (!isset($_SESSION['loginAttempts'])) ? 0 : $_SESSION['loginAttempts']+=1;
});

$app->get('/home', function (Request $request, Response $response, array $args) {
    $body = $response->getBody();
    $conn = $this->connection;
    $logger = $this->logger;
    // if we are logged in 
    if (loggedIn($conn,$logger)) {
        // reset our attempt number
        $_SESSION['loginAttempts'] = 0;
        #$body->write("<h2>\$_SESSION</h2>");
        #$body->write('<pre>' . var_export($_SESSION, true) . '</pre>');
        //j load javascript home.php to do these:
        $body->write(file_get_contents(dirname(__FILE__) . "/../app/home.php"));
            //j present our choice of adventures 
            //j also present our color and scale options
            //j if we are a site administrator,
                //j present adventure and account creation options
            //j show the logout button
                //j choosing this goes to "/logout" which clears all SESSION variables and reloads "/"
    } else {
        return $response->withRedirect('/', 301); 
    }
    return $this->cache->withExpires($response, time());
});

$app->get('/', function (Request $request, Response $response, array $args) {
    $body = $response->getBody();
    $conn = $this->connection;
    $logger = $this->logger;
    // initialize login attempt counter
    if(!isset($_SESSION['loginAttempts'])){$_SESSION['loginAttempts']=0;};
    // if attempt number < 2,
    if ($_SESSION['loginAttempts'] < 2) {
        // initialize the notBefore time to now 
        $_SESSION['notBefore'] = time();
    // else if attempt number > 5 and it is before the notBefore time,
    } else if (($_SESSION['loginAttempts'] > 5) and (time() <= $_SESSION['notBefore'])) {
        // send a try again later page
        $body->write("Try again later...");
        return $response;
    }
    // if we are not logged in
    if (!loggedIn($conn,$logger)) {
        // if attempt number > 4,
        if ($_SESSION['loginAttempts'] > 4) {
            // set the notBefore time to now + 5 minutes
            $_SESSION['notBefore'] = time() + 300;
        }
        // show the login page
        $body->write(file_get_contents(dirname(__FILE__) . "/../app/login.php"));
            //j Javascript in login.php will do this work
            //j  ask for login
            //j  check for validity using /checkUser
            //j   sucessful checkUser calls "/" again POSTing idUser and userType (maybe uname and pass) and
            //j      beforeSend-ing authentiation username and password 
            //j   failed checkUser increments loginAttempts and calls "/" again
    }
    // return with and expires flag so it is not cached
    return $this->cache->withExpires($response, time());
});

$app->get('/images/{data:.+}', function (Request $request, Response $response, array $args) {
    $body = $response->getBody();
    $conn = $this->connection;
    $logger = $this->logger;
    if (loggedIn($conn,$logger)) {
        $data = $args['data'];
        $logger->info("the data is '$data'");
        $image = file_get_contents(dirname(__FILE__) . "/../images/$data");
        if($image === FALSE) {
            $handler = $this->notFoundHandler;
            return $handler($request, $response);    
        }
        $response->write($image);
        return $response->withHeader('Content-Type', FILEINFO_MIME_TYPE);
    } else {
        return $response->withRedirect('/', 301); 
    }
});

$app->post('/checkUser', function (Request $request, Response $response, array $args) {
    $logger = $this->logger;
    $logger->info("time to check the login");
    $conn = $this->connection;
    $requestBody = $request->getParsedBody();
    $user = new userManagement($conn,$requestBody['username'],$requestBody['password'],$logger);
    $check = $user->isValid();
    if ($check and ($requestBody['login']=true)) {
        $logger->info("time to actually log in");
        $user->login(); 
    }
    $response->getBody()->write(json_encode($user->uinfo));
});


/*
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

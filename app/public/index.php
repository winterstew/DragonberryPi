<?php
// Include application bootstrap
require_once dirname(__FILE__) . '/../bootstrap.php';

// Defining routes
$app->get('/hello(/:name)', function ($name = 'anonymous') use ($app, $log) {
    $greeter = new SampleApp\Helpers\Hello($name);
    echo $greeter->greet();
    $log->info("Just logging $name visit...");
});

// // Uncomment below to enable the about to check out variables
// // Do not leave on though... security risk.
// $app->get('/about', function () use ($app, $log) {
//     echo "<h1>About ", $app->config('name'), "</h1>";
//     echo "<h2>\$_SERVER</h2>";
//     var_dump($_SERVER);
//     echo "<h2>\$_ENV</h2>";
//     var_dump($_ENV);
//     echo "<h2>config('db')</h2>";
//     var_dump($app->config('db'));
//     echo "<h2>Browser</h2>";
//     $browser = new Sinergi\BrowserDetector\Browser();
//     $os = new Sinergi\BrowserDetector\Os();
//     $device = new Sinergi\BrowserDetector\Device();
//     $language = new Sinergi\BrowserDetector\Language();
//     #echo $browser::IE . '<br>';
//     #echo $browser::FIREFOX . '<br>';
//     #echo $browser::CHROME . '<br>';
//     echo $browser->getName() .'<br>';
//     echo $browser->getVersion() .'<br>';
//     echo $os->getName() .'<br>';
//     echo $os->getVersion() .'<br>';
//     echo $language->getLanguage() .'<br>';
//     echo "<h2>Slim Mode</h2>";
//     echo "<p><small>appRoot is: ", $app->config('root'), '</small></p>';
//     echo "<p><small>Current mode is: ", $app->config('mode'), '</small></p>';
// });

$app->get('/', function () use ($app, $log) {
    require dirname(__FILE__) . '/../sizer.php';
});

$app->get('/map/:mapMode/:aId/', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../adventure.php';
})->conditions(array('mapMode' => '(pc||dm)','aId' => '\d\d*'));

//$app->get('/herolab/:mapId/:pawnName/:modifierName/toggleNamedPawnModifier', function ($mapId, $pawnName, $modifierName) use ($app, $log) {
//    $greeter = new SampleApp\Helpers\Hello("Toggle $pawnName's $modifierName status on map $mapId");
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

$app->post('/map/:mapMode/:aId/updatePawnAttackType', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../updatePawnAttackType.php';
});

$app->post('/map/:mapMode/:aId/pullRole', function ($mapMode, $aId) use ($app, $log) {
    require dirname(__FILE__) . '/../pullRole.php';
});

$app->get('/herolab/:mapId/:pawnName/:modifierName/toggle', function ($mapId, $pawnName, $modifierName) use ($app, $log) {
    require dirname(__FILE__) . '/../toggleNamedPawnModifier.php';
});


// Important: run the app ;)
$app->run();

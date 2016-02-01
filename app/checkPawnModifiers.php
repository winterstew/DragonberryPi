<?php
// how to access data sent using JSON
$jsondata = file_get_contents('php://input');

// http://php.net/manual/en/function.json-decode.php
$pawnId = json_decode( $jsondata, true ); // 2nd arg true to convert objects to associative arrays

// Create connection
$conn = db_connect($app->config('db'));

$passBack = array();
$result = $conn->query("SELECT * FROM Modifiers WHERE idPawn = ".$pawnId);
if ($result->num_rows > 0) {
  while($m = $result->fetch_assoc()) {
    $key = "modifier".$m["idModifier"];
    $passBack[$key] = True;
  }
}

echo json_encode($passBack);
$conn->close();

?>

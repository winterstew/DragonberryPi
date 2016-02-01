<?php
// how to access data sent using JSON
$jsondata = file_get_contents('php://input');

// http://php.net/manual/en/function.json-decode.php
$pawnId = json_decode( $jsondata, true ); // 2nd arg true to convert objects to associative arrays

// Create connection
$conn = db_connect($app->config('db'));

//$rows = array(["$table"]);
$result = $conn->query("SELECT * FROM PawnRoleImageSourceLocation WHERE idPawn = ".$pawnId);
if ($result->num_rows > 0) {
  $row = $result->fetch_assoc();
}
//$count = 0;
//if ($result->num_rows > 0) {
//  while($row = $result->fetch_assoc()) {
//    $count++;
//    $rows[$count] = $row;
//  }
//}

echo json_encode($row);
$conn->close();

// more info at http://www.dyn-web.com/tutorials/php-js/json/decode.php
//for($x=0;$x < count($elements);$x++) {
//    echo $x." ".$elements[$x];
//    echo "<br>";
//    for ($y=0;$y < count($elements[$x]);$y++) {
//        echo $x." ".$y." ".$elements[$x][$y];
//        echo "<br>";
//    }
//}
//foreach($elements as $x => $x_value) {
//    echo $x." ".$x_value;
//    echo "<br>";
//}
?>

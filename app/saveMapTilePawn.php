<?php
function unpack_transform($t) {
  $tm = array("rotate"=>0,"scale"=>1.0,"translateX"=>0.0,"translateY"=>0.0);
  sscanf($t,"rotate(%f %f %f) translate(%f %f) scale(%f)",
   $tm['rotate'],$rcx,$rc,$tm['translateX'],$tm['translateY'],$tm['scale']);
  echo $t ."<br>";
  return $tm;
}

// how to access data sent using JSON
$jsondata = file_get_contents('php://input');

// http://php.net/manual/en/function.json-decode.php
$saveList = json_decode( $jsondata, true ); // 2nd arg true to convert objects to associative arrays
$table = array_shift($saveList);

// Create connection
$conn = db_connect($app->config('db'));
while (count($saveList) > 1) {
  $id =  array_shift($saveList);
  $attributes =  array_shift($saveList);
  $transform = unpack_transform($attributes['transform']);
  $sql = "UPDATE `". $table ."` SET ";
  $sql .= "`rotate`=" . $transform['rotate']; 
  if ($table == "Pawn") { $sql .= ", `sizeFeet`=" . $transform['scale']/$attributes['pawnscale']; }
  if ($table == "Tile") { $sql .= ", `scale`=" . $transform['scale']; }
  if ($table == "Map") { $sql .= ", `scale`=" . $transform['scale']; }
  $sql .= ", `translateX`=" . $transform['translateX'];
  $sql .= ", `translateY`=" . $transform['translateY'];
  $sql .= " WHERE `id". $table ."`='".$id."'";
  $result = $conn->query($sql);
  if ($result == 1) {echo $sql . "<br>";}
}

//echo json_encode($transform);
$conn->close();

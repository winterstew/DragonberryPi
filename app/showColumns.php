<?php
// This php takes a JSON from POST and uses the values to do a select on the database
// This is pretty powerful, so it might need replacing for production
$conn = db_connect($app->config('db'));
// pull JSON from POST
$jsondata = file_get_contents('php://input');
// decode into objects
$request = json_decode( $jsondata, false ); 
// select_expr 
$table = isset($request->table) ? $request->table : 'Adventure';
$sql=sprintf("SHOW COLUMNS FROM %s;",$table);
$result = $conn->query($sql);
$rows = array($table);
if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    array_push($rows,$row);
  }
}
echo json_encode($rows);
$conn->close();
?>

<?php
// This php takes a JSON from POST and uses the values to do a select on the database
// This is pretty powerful, so it might need replacing for production
$conn = db_connect($app->config('db'));
// pull JSON from POST
$jsondata = file_get_contents('php://input');
// decode into objects
$request = json_decode( $jsondata, false ); 
// select_expr 
$table = isset($request->table) ? $request->table : 'None';
$id = isset($request->id) ? $request->id : '';
$idList = isset($request->idList) ? $request->idList : '';
$setList = isset($request->setList) ? $request->setList : '';
$log->info("insertRecord.php");
$log->info(sprintf("LOCK TABLES %s WRITE;",$table));
$conn->query(sprintf("LOCK TABLES %s WRITE;",$table));
if (($table != 'None') && ($setList != '') && (! $id)) {
  $log->info(sprintf("INSERT INTO %s SET %s;",$table,$setList));
  $conn->query(sprintf("INSERT INTO %s SET %s;",$table,$setList));
}
$log->info(sprintf("SELECT * FROM %s WHERE id%s = LAST_INSERT_ID();",$table,$table));
$result = $conn->query(sprintf("SELECT * FROM %s WHERE id%s = LAST_INSERT_ID();",$table,$table));
$log->info($result->num_rows);
$log->info(sprintf("UNLOCK TABLES;"));
$conn->query(sprintf("UNLOCK TABLES;"));
if ($idList) {
  $log->info(sprintf($idList,$table,"LAST_INSERT_ID()"));
  $conn->query(sprintf($idList,$table,"LAST_INSERT_ID()"));
}
$rows = array($table);
if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    array_push($rows,$row);
  }
}
echo json_encode($rows);
$conn->close();
?>

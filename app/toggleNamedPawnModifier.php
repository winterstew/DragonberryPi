<!DOCTYPE html>
<html style="width:100%;height:100%;">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<?php 
include 'controls.php';
// Create connection
$conn = db_connect($app->config('db'));
$sql="SELECT * FROM Modifier WHERE name like '". $modifierName. "%'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
  while($m = $result->fetch_assoc()) {
    $modifierId = $m["idModifier"];
  }
  $sql="SELECT * FROM Pawn WHERE idMap=". $mapId ." and name like '". $pawnName ."'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    while($m = $result->fetch_assoc()) {
      $pawnId = $m["idPawn"];
    }
    $where="WHERE idPawn = ". $pawnId ." AND idModifier = ". $modifierId;
    $sql="SELECT * FROM Modifiers ". $where;
    $modifiers = $conn->query($sql);
    if ($modifiers->num_rows > 0) {
      $sql = "DELETE FROM Modifiers ". $where;
    } else {
      $sql = "INSERT INTO Modifiers (idPawn, idModifier) VALUES (". $pawnId .", ". $modifierId .")";
    }
    $conn->query($sql);
  }
}
$conn->close();
?>
</head>
<script>
window.close()
</script>
</html>

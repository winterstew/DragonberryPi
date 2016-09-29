<?php
// Create connection
$conn = db_connect($app->config('db'));
$where="WHERE idMap = ".$_POST['mapId']." AND idRole = ".$_POST['roleId'];
$sql="SELECT * FROM Pawn ".$where;
$pawn = $conn->query($sql);
if ($pawn->num_rows > 0) {
  $updatesql = "UPDATE Pawn SET idMap=NULL WHERE idRole=".$_POST['roleId'];
} else {
  $target = $conn->query("SELECT * FROM Pawn WHERE idPawn=".$_POST['pawnId'])->fetch_assoc();
  $updatesql = "UPDATE Pawn SET idMap=".$_POST["mapId"].", translateX=".$target["translateX"].", translateY=".$target["translateY"]." WHERE idRole=".$_POST['roleId'];
}
$conn->query($updatesql);
$conn->close();
?>

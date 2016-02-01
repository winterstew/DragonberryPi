<?php
// Create connection
$conn = db_connect($app->config('db'));
$where="WHERE idPawn = ".$_POST['pawnId']." AND idModifier = ".$_POST['modifierId'];
$sql="SELECT * FROM Modifiers ".$where;
$modifiers = $conn->query($sql);
if ($modifiers->num_rows > 0) {
  $sql = "DELETE FROM Modifiers ".$where;
} else {
  $sql = "INSERT INTO Modifiers (idPawn, idModifier) VALUES (".$_POST['pawnId'].", ".$_POST['modifierId'].")";
}
$conn->query($sql);
$conn->close();
?>

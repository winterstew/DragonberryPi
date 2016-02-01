<?php
// Create connection
$conn = db_connect($app->config('db'));
$sql="UPDATE Pawn SET `". $_POST["indicator"] ."` = `". $_POST["indicator"] ."` * ". $_POST["multi"] ." + ". $_POST["adjust"] .",`updated`=NOW() WHERE `idPawn`=". $_POST["pawnId"];
$conn->query($sql);
$conn->close();
?>

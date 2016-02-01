<?php
// Create connection
$conn = db_connect($app->config('db'));
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$sql="UPDATE Pawn SET `attackType`='". $_POST["attackType"] ."', `updated`=NOW() WHERE `idPawn`=". $_POST["pawnId"];
$conn->query($sql);
$conn->close();
?>

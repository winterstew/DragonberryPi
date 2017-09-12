<?php
// Create connection
$conn = db_connect($app->config('db'));
function isShown($row,$mode) {
  if (($mode == "dm") && ($row['dmShowName'] == 1)) {return True;}
  elseif ($row['showName'] == 1) {return True;}
  else {return False;}
}
$sql="SELECT * FROM ".$_POST["table"]." WHERE id".$_POST["table"]." = ".$_POST['id'];
$row = $conn->query($sql)->fetch_assoc(); 
if (isShown($row,"pc")) {
  $sql2="UPDATE ".$_POST["table"]." SET showName=0 WHERE id".$_POST["table"]." = ". $_POST['id'];
} else {
  $sql2="UPDATE ".$_POST["table"]." SET showName=1 WHERE id".$_POST["table"]." = ". $_POST['id'];
}
$conn->query($sql2);
$conn->close();
?>

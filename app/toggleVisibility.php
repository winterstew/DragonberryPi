<?php
// Create connection
$conn = db_connect($app->config('db'));
function isVisible($row,$mode) {
  if (($mode == "dm") && ($row['dmVisible'] == 1)) {return True;}
  elseif ($row['visible'] == 1) {return True;}
  else {return False;}
}
$sql="SELECT * FROM ".$_POST["table"]." WHERE id".$_POST["table"]." = ".$_POST['id'];
$row = $conn->query($sql)->fetch_assoc(); 
if (isVisible($row,"pc")) {
  $sql2="UPDATE ".$_POST["table"]." SET visible=0 WHERE id".$_POST["table"]." = ". $_POST['id'];
} else {
  $sql2="UPDATE ".$_POST["table"]." SET visible=1 WHERE id".$_POST["table"]." = ". $_POST['id'];
}
$conn->query($sql2);
$conn->close();
?>

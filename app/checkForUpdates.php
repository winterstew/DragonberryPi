<?php
// This php is meant to receive a JSON list as follows
//   [tablename,id1,updated1,id2,updated2,....]
// it returns a list of updated (newer than the updated value) entries from tablename as follows
//   [tablename,id1,{attribute_assoc_array},id2,...]
// for Pawns teh format is
//   [tablename,id1,attribute_assoc_array,modifierlist,id2,...]
//   where modifierlist is [mod1_attribute_assoc_array,mod2_attribute_assoc_array,...]
// how to access data sent using JSON
//if (isset($jsondata)) {
//    $log->info("JSON1->".$jsondata);
//} else {
//    $jsondata = file_get_contents('php://input');
//    $log->info("JSON2->".$jsondata);
//}
$jsondata = file_get_contents('php://input');
//$myarray = array("1","2","3");
//$log->info("TEST1->".json_encode($myarray));
//$newarray = json_decode($jsondata);
//$log->info("TEST2->".$newarray[1]);
$dateFormat = "Y-M-d H:i:s";

// http://php.net/manual/en/function.json-decode.php
$checkList = json_decode( $jsondata, true ); // 2nd arg true to convert objects to associative arrays
//$log->info("checkList->".$checkList[1]."<-checkList");
$aId = array_shift($checkList);
$table = array_shift($checkList);
//$log->info("aId->".$aId." table->".$table);

// Create connection
$conn = db_connect($app->config('db'));
$rows = array($table);
$count = 0;
//$log->info("rows->".$rows[0]." count->".count($checkList));
while (count($checkList) > 1) {
  $id =  array_shift($checkList);
  //array_push($rows,$id);
  $updated =  array_shift($checkList);
  $sql = "SELECT `id". $table ."`,`updated` FROM `". $table ."` WHERE `id". $table ."` = ". $id;
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      $count++;
      $diff = date_diff(date_create($row['updated']),
                        date_create($updated));
      //array_push($rows,$diff->format("%s"));
      if ($diff->format("%s") > 0) {
        $sql2 = "SELECT * FROM ";
        if ($table == "Map") {
          $sql2 .= "`MapMapType`";
        } elseif ($table == "Tile") {
          $sql2 .= "`TileImageSourceLocation`";
        } elseif ($table == "Pawn") {
          $sql2 .= "`PawnRoleImageSourceLocation`";
        } elseif ($table == "Pointers") {
          $sql2 .= "`Pointers`";
        }
        $sql2 .= " WHERE `id". $table ."` = ". $id ." ";
        if ($table == "Map") {
          $sql2 .= "AND `idAdventure` = ". $aId;
        }
        $result2 = $conn->query($sql2);
        if ($result2->num_rows == 1) {
          array_push($rows,$id);
          array_push($rows,$result2->fetch_assoc());
          //if (! json_encode($result2->fetch_assoc())) {
          //  $log->info("table->".$table." id->".$id." err->".json_last_error_msg());
          //}
        }
        if ($table == "Pawn") {
          // reset the result2 back to the start
          $result2->data_seek(0);
          if ($result2->num_rows == 1) {
            $row2 = $result2->fetch_assoc();
          }
          $sql3 = "SELECT * FROM `ModifierList` WHERE `idPawn`= ". $row2['idPawn'];
          $result3 = $conn->query($sql3);
          $rows3 = array();
          if ($result3->num_rows > 0) {
            while($row3 = $result3->fetch_assoc()) {
              array_push($rows3,$row3);
            }
          }
          array_push($rows,$rows3);
        }
      }
    }
  }
}
function encodeval($value,$key,$log) {
  if (! json_encode($value)) {
    $log->info("err->".json_last_error_msg()." key->".$key."value->".$value);
  }
}
array_walk_recursive($rows,"encodeval",$log);
$exitcount = count($rows);
$lastindex = $exitcount - 1;
$rowsencoded = json_encode($rows);
$encode_err = "";
if (! $rowsencoded) { $encode_err = "err->" . json_last_error_msg(); }
$firstval = '';
$lastval = '';
if ($exitcount > 0) { $firstval = serialize($rows[0]);  }
if ($lastindex >= 0) { $lastval = serialize($rows[$lastindex]); } 
//$log->info($encode_err." exit-count->".$exitcount."rows[0];..;rows[".$lastindex."]->".$firstval."...;".$lastindex);

//$count=0;
//foreach($rows as $row) {
//    $log->info("row[$count]->".json_encode($row)."<-rows");
//    $count++;
//}
echo json_encode($rows);
$conn->close();

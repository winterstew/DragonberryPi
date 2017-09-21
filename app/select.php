<?php
// This php takes a JSON from POST and uses the values to do a select on the database
// This is pretty powerful, so it might need replacing for production
$conn = db_connect($app->config('db'));
// pull JSON from POST
$jsondata = file_get_contents('php://input');
// decode into objects
$request = json_decode( $jsondata, false ); 
// select_expr 
$select = isset($request->select) ? $request->select : '*';
$table = isset($request->table) ? $request->table : 'Adventure';
$where = isset($request->where) ? $request->where : 'true';
$group = isset($request->group) ? $request->group : 'true';
$order = isset($request->order) ? $request->order : 'true';
$extrajoin = isset($request->extrajoin) ? $request->extrajoin : '';
if ($table == "LocationTree") {
  if (! isset($request->select)) { 
    $select = 'idTree as idLocationTree,name8 as name,name0,name1,name2,name3,name4,name5,name6,name7,name8,treeDepth as depth,treeUpdated as updated' ;
  }
  $table = '( ';
  $table .= 'select l7.idLocation as id7,id6,id5,id4,id3,id2,id1,idTree,treeDepth,treeUpdated,CONCAT_WS("",CAST(l7.name as CHAR),name7) as name8,name7,name6,name5,name4,name3,name2,name1,name0,l7.idParent as idp7,idp6,idp5,idp4,idp3,idp2,idp1,idp0 from ( ' . "\n";
  $table .= 'select l6.idLocation as id6,id5,id4,id3,id2,id1,idTree,treeDepth,treeUpdated,CONCAT_WS("",CAST(l6.name as CHAR),name6) as name7,name6,name5,name4,name3,name2,name1,name0,l6.idParent as idp6,idp5,idp4,idp3,idp2,idp1,idp0 from ( ' . "\n";
  $table .= 'select l5.idLocation as id5,id4,id3,id2,id1,idTree,treeDepth,treeUpdated,CONCAT_WS("",CAST(l5.name as CHAR),name5) as name6,name5,name4,name3,name2,name1,name0,l5.idParent as idp5,idp4,idp3,idp2,idp1,idp0 from ( ' . "\n";
  $table .= 'select l4.idLocation as id4,id3,id2,id1,idTree,treeDepth,treeUpdated,CONCAT_WS("",CAST(l4.name as CHAR),name4) as name5,name4,name3,name2,name1,name0,l4.idParent as idp4,idp3,idp2,idp1,idp0 from ( ' . "\n";
  $table .= 'select l3.idLocation as id3,id2,id1,idTree,treeDepth,treeUpdated,CONCAT_WS("",CAST(l3.name as CHAR),name3) as name4,name3,name2,name1,name0,l3.idParent as idp3,idp2,idp1,idp0 from ( ' . "\n";
  $table .= 'select l2.idLocation as id2,id1,idTree,treeDepth,treeUpdated,CONCAT_WS("",CAST(l2.name as CHAR),name2) as name3,name2,name1,name0,l2.idParent as idp2,idp1,idp0 from ( ' . "\n";
  $table .= 'Select l1.idLocation as id1,l0.idLocation as idTree,l0.depth as treeDepth,l0.updated as treeUpdated,CONCAT_WS("",CAST(l1.name as CHAR),CAST(l0.name as CHAR)) as name2,CAST(l1.name as CHAR) as name1,CAST(l0.name as CHAR) as name0,l0.idParent as idp0,l1.idParent as idp1 From Location as l0 LEFT JOIN Location as l1 ON l1.idLocation = l0.idParent ' . "\n";
  $table .= ') as l01 LEFT JOIN Location as l2 ON l2.idLocation = idp1 ' . "\n";
  $table .= ') as l12 LEFT JOIN Location as l3 ON l3.idLocation = idp2 ' . "\n";
  $table .= ') as l23 LEFT JOIN Location as l4 ON l4.idLocation = idp3 ' . "\n";
  $table .= ') as l34 LEFT JOIN Location as l5 ON l5.idLocation = idp4 ' . "\n";
  $table .= ') as l45 LEFT JOIN Location as l6 ON l6.idLocation = idp5 ' . "\n";
  $table .= ') as l56 LEFT JOIN Location as l7 ON l7.idLocation = idp6 ' . "\n";
  $table .= ') as LocationTree';
} 
$sql=sprintf("SELECT %s FROM %s %s WHERE %s GROUP BY %s ORDER BY %s;",$select,$table,$extrajoin,$where,$group,$order);
$result = $conn->query($sql);
if (explode(" ", $table)[0] == "(") {
  $rows = array(array_pop(explode(" ", $table)));
} else {
  $rows = array(array_shift(explode(" ", $table)));
}
if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    array_push($rows,$row);
  }
}
echo json_encode($rows);
$conn->close();
?>

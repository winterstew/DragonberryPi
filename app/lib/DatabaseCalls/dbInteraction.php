<?php

namespace AppLib\DatabaseCalls;

class dbInteraction
{

    public function __construct($conn,$user,$param,$callAs,$logger)
    {
        $this->conn = $conn;
        $this->user = $user;
        // parameters which are needed depends on the $callAs argument options are
        // table -> a single string matching one of the TABLES or VIEWS
        // whereCol,whereOp,whereVal -> arrays of equal size or defining ANDed WHERE clauses
        // whereCat -> array which is one element shorter the whereCol, each is "AND" or "OR" used to join the where clause
        // orderBy,orderDir -> arrays of equal size to define comma separated ORDER BY arguments
        // limit -> single integer for LIMIT argument
        // setCol,setVal -> arrays of equal size for use in INSERT and UPDATE statements
        $this->param = $param;
        $this->callAs = $callAs;
        $this->logger = $logger;
        
        // will get set to true if params and call are validated
        $this->isValidated = false;
        
        // Define which tables are allowed
        $this->allowedTables = isset($_SESSION['allowedTables']) ? $_SESSION['allowedTables'] : $this->getAllowedTables();
        // Define which tables are allowed
        $this->baseTables = isset($_SESSION['baseTables']) ? $_SESSION['baseTables'] : $this->getAllowedTables("BASE");
        // Define the column names and types allowed for each table;
        $this->allowedColumns = isset($_SESSION['allowedColumns']) ? $_SESSION['allowedColumns'] : $this->getAllowedColumns();
        // Define how this can be called
        $this->allowedCall = array('showColumns','updateRecord','insertRecord','selectRecord');
        
        // starting queryResult
        $this->queryResult = null;
    }
    
    // runs a SQL query and returns an array of the resultant rows
    private function dbReturn($sql)
    {
    	$rows = array();
    	$this->logger->info("dbReturn: query sending -> $sql");
    	$result = $this->conn->query($sql);  	
    	if ($result and ($result->num_rows > 0)) {
	    	$this->logger->info("dbReturn: response number of rows-> " .$result->num_rows);
    		while($row = $result->fetch_assoc()) {
         	array_push($rows,$row);
         }
      }      
      return($rows);
    }
   
   // This gets the list of all the tables in the databaase
   private function getAllowedTables($type="") 
   {
   	$tables = array();
   	$this->logger->info("determining allowed tables");
   	$rows = $this->dbReturn(sprintf("SHOW FULL TABLES WHERE `Table_type` LIKE \"%s%%\";",$type));
   	while($row = array_shift($rows)) {
   		array_push($tables, array_shift($row));
   	}
   	if ($type != "") {
   		$_SESSION[strtolower($type) . 'Tables']=$tables;
   	} else {
	   	$_SESSION['allowedTables']=$tables;
	   }
   	return $tables;
   }
   
   // This returns an associative array keyed with table names
   // each value being a list of allowed columns
   private function getAllowedColumns()
   {
   	$columns = array();
   	$this->logger->info("determining allowed fields and type for each column");
   	$tables = $this->getAllowedTables();
   	while($table = array_shift($tables)) {
   		$result = $this->dbReturn("SHOW COLUMNS FROM `" . $table . "`;");
   		$columnList = array();
   		while($row = array_shift($result)){
   			$columnList[$row['Field']]=$row['Type'];
   		}
   		$columns[$table] = $columnList;
   	}
   	$_SESSION['allowedColumns'] = $columns;
   	return $columns;
   }
   
   // validates the value for a where or set based on the column type
   // return an array with isValid, cleanValue, and allowedOperators
   private function validateValue($value,$type) {
   	$allowedOperator = array(); 
   	$cleanValue = null;
   	$isValid = false;
   	if (is_string($value)) {
	   	$this->logger->debug(sprintf("validating string '%s' for type '%s'",$value,$type));
	   } else {
	   	$this->logger->debug(sprintf("validating non-string %s for type '%s'",$value,$type));
	   }
   	if (preg_match('/^null$/', $value) or ($value===null)) {
   		return array(true,null,array("IS","is","IS NOT","is not","<=>"));
   	};
   	if (preg_match('/^tinyint\(1\)/',$type)) {
   		$allowedOperator = array("IS","IS NOT","is","is not","=","<=>");
   		if (is_bool($value)) {
   			$cleanValue = $value;
   			$isValid = true;
   		} else if (is_numeric($value) and ((intval($value) == 0) or (intval($value) == 1))) {
   			$cleanValue = boolval($value);
   			$isValid = true;
   		} else if (preg_match('/^[Tt][Rr][Uu][Ee]$/',$value) or
   		           preg_match('/^[Yy][Ee][Ss]$/',$value)) {
   		   $cleanValue = true;
   		   $isValid = true;
   		} else if (preg_match('/^[Ff][Aa][Ll][Ss][Ee]$/',$value) or
   		           preg_match('/^[Nn][Oo]$/',$value)) {
   		   $cleanValue = false;
   		   $isValid = true;
   		}
   	} else if (preg_match('/int\b/',$type) or preg_match('/integer/',$type)) {
   		$allowedOperator = array("=","<>","!=","<",">","<=",">=","<=>");
   		if (is_numeric($value) and (intval($value) == floatval($value))) {
   			$cleanValue = intval($value);
   			$isValid = true;
   		}
   	} else if (preg_match('/decimal\b/',$type) or preg_match('/numeric\b/',$type) or 
   	           preg_match('/float\b/',$type) or preg_match('/double\b/',$type)) {
   		$allowedOperator = array("=","<>","!=","<",">","<=",">=","<=>");
   	   if (is_numeric($value)) {
   	   	$cleanValue = floatval($value);
   	   	$isValid = true;
   	   }
   	} else if (preg_match('/date/',$type) or preg_match('/time/',$type)) {
   		$allowedOperator = array("=","<>","!=","<",">","<=",">=","<=>","LIKE","like","NOT LIKE","not like");
   		if (strtotime($value)) {
   			$cleanValue = strval($value);
   		}
   	} else if (preg_match('/char\b/',$type) or preg_match('/text\b/',$type) or 
   	           preg_match('/binary\b/',$type) or preg_match('/blob\b/',$type)) {
   		$allowedOperator = array("=","<>","!=","<",">","<=",">=","<=>","LIKE","like","NOT LIKE","not like");
   		$cleanValue = mysqli_real_escape_string($this->conn,$value);
   		$isValid = true;
   	} else if (preg_match('/^enum\((.*)\)$/',$type,$matches)) {
   		$allowedOperator = array("=","<>","!=","<",">","<=",">=","<=>","LIKE","like","NOT LIKE","not like");
   		$valueList = array();
   		eval("\$valueList = array($matches[1]);");
   		if(in_array($value,$valueList)){
   			$cleanValue = strval($value);
   			$isValid=true;
   		}
   	}
   	if(!$isValid){$this->logger->error("$value is not valid for $type");}
   	return array($isValid,$cleanValue,$allowedOperator);
   }
       
   // Here is where I do all the checking of the parameters to make sure nothing gets borked
   public function validateRequest()
    {
    	$isValid=false;
    	// previously these functions were very insecure (which is fine when it is just on a RaspberryPi)
      // they need to be cleaned up to do some validation but retaining some of their flexibility
      if (in_array($this->callAs,$this->allowedCall)) {
      	$callAs = $this->callAs;
	    	$isValid = true;
	      // to wit: No SELECT columns can be chosen (always *)
	      //         All JOINs are done using Views in the database (the views also made to prevent name overlap in the select)
	      //         Thus there is only ever one TABLE/VIEW  
	      if (preg_match('/insert/',$callAs) or preg_match('/update/',$callAs)) {
	      	$allowedTables = $this->baseTables;
	      } else {
				$allowedTables = $this->allowedTables;
			}
	      $isValid = ($isValid and in_array($this->param['table'],$allowedTables));
	      if (!$isValid) {
	      	$this->logger->warning($this->param['table'] . " is not a valid TABLE for a query");
	      } else {
	      	$table = $this->param['table'];
	      	// WHERE options are split first into whereCol (array list of columns which must be allowed) 
		      if (isset($this->param['whereCol']) and count($this->param['whereCol']) > 0) {
	   	   	// I want it to just drop invalid columns from the list instead of rejecting the whole call
	   	   	$newWhereCol = array();
	   	   	$newWhereOp = array();
	   	   	$newWhereVal = array();
	   	   	$newWhereCat = array();
	   	   	// TODO!!! I need to drop values from the whereCat array as well
	   	   	while (count($this->param['whereCol'])>0) {
	   	   		$c = array_shift($this->param['whereCol']);
	   	   		$o = array_shift($this->param['whereOp']);
	   	   		$v = array_shift($this->param['whereVal']);
	   	   		// if there are still more columns then there may also be a joiner
	   	   		if (count($this->param['whereCol']) > 0) {
	   	   			if (isset($this->param['whereCat'])) {
	   	   				$j = array_shift($this->param['whereCat']);
	   	   			} 
	   	   		}
	   	   		// if the column is valid for the table add it to the new array
	   	   		if (array_key_exists($c,$this->allowedColumns[$table])) {
	   	   			array_push($newWhereCol,$c);
	   	   			array_push($newWhereOp,$o);
	   	   			array_push($newWhereVal,$v);
		   	   		// again if there are still more columns then there may also be a joiner add it to its new array
		   	   		if (count($this->param['whereCol']) > 0) {
		   	   			if (isset($this->param['whereCat'])) {
		   	   				array_push($newWhereCat,$j);
		   	   			} 
		   	   		}
	   	   		} else {
	   	   			$this->logger->warning(sprintf("`%s` %s %s was dropped from WHERE clause for table `%s`",$c,$o,$v,$table));
	   	   		}
	   	   	}
	   	   	$this->param['whereCol'] = (count($newWhereCol) > 0) ? $newWhereCol : null;
	   	   	$this->param['whereOp'] = (count($newWhereOp) > 0) ? $newWhereOp : null;
	   	   	$this->param['whereVal'] = (count($newWhereVal) > 0) ? $newWhereVal : null;
	   	   	$this->param['whereCat'] = (count($newWhereCat) > 0) ? $newWhereCat : null;
	   	  	}
	   	  	// it is OK not to have can WHERE clause, but if we do, the operator and value needs to be appropriate
	      	// WHERE options are split second into whereOp (array list of comparison operators) and third into whereVal
	      	if (isset($this->param['whereCol']) and (count($this->param['whereCol']) > 0)) {
		      	if (isset($this->param['whereOp']) and (count($this->param['whereOp']) == count($this->param['whereCol']))) {
			      	if (isset($this->param['whereVal']) and (count($this->param['whereVal']) == count($this->param['whereCol']))) {
			      		foreach ($this->param['whereVal'] as $k => $v){
			      			$c = $this->param['whereCol'][$k];
			      			$t = $this->allowedColumns[$table][$c];
			      			$o = $this->param['whereOp'][$k];
			      			$valCheck = $this->validateValue($v,$t);
								if (!$valCheck[0]){
									$isValid = false;
					      		$this->logger->warning("there is an invalid WHERE clause value");
								} else if (!in_array($o,$valCheck[2])) {
										$isValid = false;
						      		$this->logger->warning("there is an invalid WHERE clause comparison operator");
								} else {
									// since validateValue also cleans it up and escapes it for SQL lets use that
									$this->param['whereVal'][$k] = $valCheck[1];
									$isValid = ($isValid and true);
								}
			      		}
			      	} else {
			      		$isValid = false;
			      		$this->logger->warning("do not have same number of values as columns in the WHERE clause");
			      	}
			      } else {
		      		$isValid = false;
		      		$this->logger->warning("do not have same number of operators as columns in the WHERE clause");
			      }
			   }
			   // if there is no whereCat defined assume AND connectors
			   if (isset($this->param['whereCol']) and (count($this->param['whereCol']) > 1)) {
			   	if (isset($this->param['whereCat']) and (count($this->param['whereCat']) != count($this->param['whereCol']) - 1)) {
			   		$isValid = false;
		      		$this->logger->warning("do not have the correct number of whereCat connector for the WHERE clause");
			   	} else {
			   		if (!isset($this->param['whereCat'])) {$this->param['whereCat'] = array();}
			   		foreach ($this->param['whereCol'] as $k => $v) {
			   			// break out when we get to last key so one less element if created for whereCat
			   			if ($k >= count($this->param['whereCol']) - 1) {break;}
			   			if (isset($this->param['whereCat'][$k])) {
			   				// if it is defined make sure it is valid
			   				$isValid = ($isValid and in_array($this->param['whereCat'][$k],["AND","and","OR","or"]));
			   			} else {
			   				// if not defined use AND
			   				$this->param['whereCat'][$k] = "AND";
			   			}
			   		}
  				   	if (!$isValid) {
 		 		   		$this->logger->warning("There are invalid connectors for concatenating the WHERE clauses");
						}
			   	}
			   }
		      // ORDER BY must be one of allowed columns
		      if (isset($this->param['orderBy']) and count($this->param['orderBy']) > 0) {
		         foreach ($this->param['orderBy'] as $c) {
		         	$isValid = ($isValid and array_key_exists($c,$this->allowedColumns[$table]));
		         }
			  	}
		   	if (!$isValid) {
		   		$this->logger->warning("There are invalid columns in the ORDER BY clause");
		   	} else if (isset($this->param['orderBy']) and count($this->param['orderBy'] > 0)) {
		      	// ORDER BY direction must be either ASC or DESC
		      	if (isset($this->param['orderDir']) and (count($this->param['orderDir']) == count($this->param['orderBy']))) {
		      		foreach ($this->param['orderDir'] as $d) {
		      			$isValid = ($isValid and in_array($d,['ASC','asc','DESC','desc','']));
		      		}
		      		//$isValid = ($isValid and array_reduce($this->param['orderDir'],
		      		//              function($carry,$item){return ($carry and in_array($item,['ASC','asc','DESC','desc','']));},
		      		//              true));
		      	} else {
		      		$isValid = false;
		      		$this->logger->warning("do not have same number of sort directions as ORDER BY columns");
		      	}
		      	if (!$isValid) {$this->logger->warning("improper sort direction in the ORDER BY clause");}
		   	}
		   	// LIMITS set my a limit option
		   	if (isset($this->param['limit'])) {
		   		if (is_int($this->param['limit']) and ($this->param['limit'] > 0)) {
			         $isValid = ($isValid and true);
			   	} else {
			   		$isValid=false;
			   		$this->logger->warning("improper value for LIMIT clasue");
			   	}
			   }
		   	// SET options are split first into setCol (array list of columns which must be allowed) 
		      if (isset($this->param['setCol'])) {
		      	if (count($this->param['setCol']) > 0) {
		      		foreach ($this->param['setCol'] as $c) {
			         	$isValid = ($isValid and array_key_exists($c,$this->allowedColumns[$table]));
		      		}
				   	//$isValid = ($isValid and array_reduce($this->param['setCol'],
				   	//              function($carry,$item){return ($carry and array_key_exists($item,$this->allowedColumns[$table]));},
				   	//              true));
				   }
				  	// it is OK not to have a SET clause, but if we do it has to be valid
			   	if (!$isValid) {
			   		$this->logger->warning("There are invalid columns in the SET clause");
			   	} else {
			      	// SET options are split second into setVal
			      	if (isset($this->param['setVal']) and (count($this->param['setVal']) == count($this->param['setCol']))) {
			      		foreach ($this->param['setVal'] as $k => $v){
			      			$c = $this->param['setCol'][$k];
			      			$t = $this->allowedColumns[$table][$c];
			      			$valCheck = $this->validateValue($v,$t);
								if (!$valCheck[0]){
									$isValid = false;
					      		$this->logger->warning("there is an invalid SET clause value");
								} else {
									// since validateValue also cleans it up and escapes it for SQL lets use that
									$this->param['setVal'] = $valCheck[1];
									$isValid = ($isValid and true);
								}
			      		}
				      } else {
			      		$isValid = false;
			      		$this->logger->warning("do not have same number of values as columns in the SET clause");
				      }
				   }
			   }
			}
		}
      $this->isValidated = $isValid;
      return $this->isValidated;
    }

	 // execute the database request, return true if it succeeds else false
	 public function doRequest()
    {
    	if ($this->validateRequest()) {
    		$this->logger->info("doRequest: called as " . $this->callAs);
    		switch($this->callAs) {
    			case 'showColumns':
    				// real simple only need the table name
    				$this->queryResult = $this->dbReturn(sprintf("SHOW COLUMNS FROM %s;",$this->param['table']));
    				break;
    			case 'selectRecord':
    				// little more complicated with possible WHERE, ORDER BY, and LIMIT clauses
    				$sql = sprintf("SELECT * FROM `%s`",$this->param['table']);
    				// do we need a WHERE clause
    				if (isset($this->param['whereCol'])) {
    					$sql = sprintf("%s WHERE ",$sql);
    					foreach ($this->param['whereCol'] as $k => $c) {
    						$o = $this->param['whereOp'][$k];
    						$v = $this->param['whereVal'][$k];
    						$j = (isset($this->param['whereCat'][$k]) ? $this->param['whereCat'][$k] : "");
    						if (is_string($v)) {
    							$sql = sprintf("%s `%s` %s \"%s\" %s",$sql,$c,$o,$v,$j);
    						} else if (is_bool($v)) {
    							$b = $v ? 'TRUE' : 'FALSE';
    							$sql = sprintf("%s `%s` %s %s %s",$sql,$c,$o,$b,$j);
    						} else if (is_null($v)) {
    							$b = 'NULL';
    							$sql = sprintf("%s `%s` %s %s %s",$sql,$c,$o,$b,$j);
    						} else {
    							$sql = sprintf("%s `%s` %s %s %s",$sql,$c,$o,$v,$j);
    						}
    					}
    				}
    				// do we need an ORDER BY clause
    				if (isset($this->param['orderBy'])) {
    					$sql = sprintf("%s ORDER BY ",$sql);
    					foreach ($this->param['orderBy'] as $k => $c) {
    						$d = $this->param['orderDir'][$k];
  							$sql = sprintf("%s `%s` %s, ",$sql,$c,$d);
    					}
    					$sql = sprintf("%s TRUE",$sql);
    				}
    				// do we need a LIMIT clause
    				if (isset($this->param['limit'])) {
    					$sql = sprintf("%s LIMIT %d",$sql,$this->param['limit']);
    				}
    				$sql = sprintf("%s;",$sql);
    				$this->queryResult = $this->dbReturn($sql);
    				break;
    			case 'insertRecord':
    				$this->dbReturn(sprintf("LOCK TABLES %s WRITE;\n",$this->param['table']));
    				$this->dbReturn("UNLOCK TABLES;");
/*
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
// $idList is to update a list of records which are dependent of the one just inserted
if ($idList) {
  $log->info(sprintf($idList,$table,"LAST_INSERT_ID()"));
  $conn->query(sprintf($idList,$table,"LAST_INSERT_ID()"));
}
$rows = array($table);
*/

    				break;
    			case 'updateRecord':
    				break;
    		}
    		return true;
    	} else {
	      return false;
	   }
    }
    
    // return the result of the request
    public function getResult()
    {
    	$result = array($this->param['table'],$this->queryResult);
      return $result;        
    }
}

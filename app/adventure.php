<!DOCTYPE html>
<html>
<head>
<?php 
// Create connection
$conn = db_connect($app->config('db'));
// What is the root directory for this app
$appRoot = $app->config('root');
// starting point for scale is 96 dpi
// globalScale is used applied to the pawnGrid maps so they can match 
// the size desired for the physical pawns and display
$standardDipsPerInch = 96.0;
$standardMapPixelsPerInch = 50.0;
$standardPawnPixelsPerFoot = 100.0;
$standardPawnSizeFeet = 5.0;
$pawnScale = 1; // global which will be set based on the pawnGrid map later
$globalScale = $standardDipsPerInch;
if (array_key_exists("scale",$_GET) && ($_GET["scale"] > 0)) {$globalScale *= $_GET["scale"];}
// Everything can be separated by Adventure
// This selects the adventure you are running
$pawnGridReduce = 1;
if (array_key_exists("reduce",$_GET) && ($_GET["reduce"] > 0)) {$pawnGridReduce *= $_GET["reduce"];}
// test is for debug
$testDebug = "";
if (array_key_exists("test",$_GET)) {$testDebug = $_GET["test"];}
// browser check
$browserAlert = null;
$browser = new Sinergi\BrowserDetector\Browser();
if ($mapMode == 'pc') {
  if ($browser->getName() == $browser::CHROME) {
    $browserAlert = "Pawns load best with Firefox";
  }
  if ($browser->getName() == $browser::FIREFOX) {
    $browserAlert = "Maps can be moved best with Chrome";
  }
  if ($browser->getName() == $browser::IE) {
    $browserAlert = "Does not work well in Explorer";
  }
}
// isVisible() checks if a particular map or tile has its visible flag
// checked for the current mapMode
function isVisible($row,$mode) {
  if (($mode == "dm") && ($row['dmVisible'] == 1)) {return True;}
  elseif ($row['visible'] == 1) {return True;}
  else {return False;}
}
// getDirName() retieves the URL approriate directory name for a given
// location entry.  It dows this with a very complicated SQL statement.
// However, this will break if the directory tree gets deeper than 6 levels
function getDirName($c,$idLoc,$depthLoc) {
  //$depth = $c->query("SELECT MAX(depth) FROM Location")->fetch_array()[0];
  // This SQL will create all the trees up to 6 deep
  $sql = "SELECT n0 as dir0, id0, n1 as dir1, id1";
  $sql .= ", CONCAT(n1, n2) as dir2, id2";
  $sql .= ", CONCAT(n1, CONCAT(n2,n3)) as dir3, id3";
  $sql .= ", CONCAT(n1, CONCAT(n2,CONCAT(n3,n4))) as dir4, id4";
  $sql .= ", CONCAT(n1, CONCAT(n2,CONCAT(n3,CONCAT(n4,n5)))) as dir5, id5";
  $sql .= ", CONCAT(n1, CONCAT(n2,CONCAT(n3,CONCAT(n4,CONCAT(n5, l6.name))))) as dir6, l6.idLocation as id6 ";
  $sql .= "FROM ( SELECT n0, id0, n1, id1, n2, id2, n3, id3, n4, id4, l5.name as n5, l5.idLocation as id5 ";
  $sql .= "FROM ( SELECT n0, id0, n1, id1, n2, id2, n3, id3, l4.name as n4, l4.idLocation as id4 ";
  $sql .= "FROM ( SELECT n0, id0, n1, id1, n2, id2, l3.name as n3, l3.idLocation as id3 ";
  $sql .= "FROM ( SELECT n0, id0, n1, id1, l2.name as n2, l2.idLocation as id2 ";
  $sql .= "FROM ( SELECT l0.name as n0, l0.idLocation as id0, l1.name as n1, l1.idLocation as id1 ";
  $sql .= "FROM Location as l0 left join Location as l1 ON l0.idLocation = l1.idParent ";
  $sql .= "WHERE l0.depth = 0) as l12 ";
  $sql .= "LEFT JOIN Location as l2 ON id1 = l2.idParent) as l23 ";
  $sql .= "LEFT JOIN Location as l3 ON id2 = l3.idParent) as l34 ";
  $sql .= "LEFT JOIN Location as l4 ON id3 = l4.idParent) as l45 ";
  $sql .= "LEFT JOIN Location as l5 ON id4 = l5.idParent) as l56 ";
  $sql .= "LEFT JOIN Location as l6 ON id5 = l6.idParent ";
  // only get the tree for this location
  $sql .= "WHERE id".$depthLoc." = ".$idLoc;
  $location = $c->query($sql)->fetch_assoc(); 
  $key = "dir".$depthLoc;
  return $location[$key];
}

?>
<script>
var toggleList = [];
var modifiersList = [];
var myHTML = "";
var selectHTML = "";
var aId = "<?php echo $aId?>";
var mapMode = "<?php echo $mapMode?>";
var standardDipsPerInch = "<?php echo $standardDipsPerInch?>";
var standardMapPixelsPerInch = "<?php echo $standardMapPixelsPerInch?>";
var standardPawnPixelsPerFoot = "<?php echo $standardPawnPixelsPerFoot?>";
var standardPawnSizeFeet = "<?php echo $standardPawnSizeFeet?>";
var globalScale = "<?php echo $globalScale?>";
var testDebug = "<?php echo $testDebug?>";
var pawnProperties = {};
var modifierListHTML = "updateModifierSelectors<br>";
var pawnListHTML = "fillOutPawns<br>";
var updateListHTML = "Update List<br>";

// global variables for transforming elements
var startX=0;
var startY=0;
var startR=0;
var startS=0;
var oldTransform=[];
var newTransform=[];
var mode="t";
var moveRes = globalScale;
var rotRes = 22.5;
var scaleRes = 0.1;
var selectedTileOrPawn = {};
var needsSave = false;
var keyHold = null;

function fillOutPawns() {
  var callback = {
    success: function(req) {
      pawnListHTML += "<p>";
      var pawnProperty = JSON.parse(req.responseText);
      var pawnId = "pawn" + pawnProperty["idPawn"];
      pawnListHTML += pawnId + " <br>";
      var pawn = document.getElementById(pawnId);
      var groups = pawn.getElementsByTagName("g");
      for(gIndex = 0; gIndex < groups.length; gIndex++) {
        pawnListHTML += " " + groups[gIndex].id +" <br>";
        if (groups[gIndex].id == "background") {
          var nodes = groups[gIndex].children;
          if (nodes) {
            for(nIndex = 0; nIndex <  nodes.length; nIndex++) {
              var style = nodes[nIndex].getAttribute("style").replace(/#[Ff][Ff]00[Ff][Ff]/,
                                                                      pawnProperty["backgroundColor"]);
              nodes[nIndex].setAttribute("style",style);
              pawnListHTML += nodes[nIndex].getAttribute("style") + "<br>";
            }
          }
        }
        if (groups[gIndex].id.search("Color") > 0) {
          var nodes = groups[gIndex].children;
          if (nodes) {
            for(nIndex = 0; nIndex <  nodes.length; nIndex++) {
              var style = nodes[nIndex].getAttribute("style").replace(/#00[Ff][Ff][Ff][Ff]/,
                                                                      pawnProperty["color"]);
              nodes[nIndex].setAttribute("style",style);
              pawnListHTML += nodes[nIndex].getAttribute("style") + "<br>";
            }
          }
        }
        if (groups[gIndex].id == "height") {
          var myText = groups[gIndex].getElementsByTagName("tspan");
          if (pawnProperty["height"] != 0) {
            myText[0].innerHTML = 1*pawnProperty["height"];
          } else {
            myText[0].innerHTML = "";
          }
          pawnListHTML += pawnProperty["height"]+ "<br>";
        }
        if (groups[gIndex].id == "roundImage") {
          var myImage = groups[gIndex].getElementsByTagName("image");
          // have to use setAttributeNS for attributes with a prefix
          myImage[0].setAttributeNS('http://www.w3.org/1999/xlink',"xlink:href",pawn.getAttribute("pawnimagehref"));
          myImage[0].setAttribute("height",myImage[0].getAttribute("height")*pawnProperty["imageScale"]);
          myImage[0].setAttribute("width",myImage[0].getAttribute("width")*pawnProperty["imageScale"]);
          myImage[0].setAttribute("y",1*myImage[0].getAttribute("y")+1*pawnProperty["imageY"]);
          myImage[0].setAttribute("x",1*myImage[0].getAttribute("x")+1*pawnProperty["imageX"]);
          pawnListHTML +=  1*myImage[0].getAttribute("x")+1*pawnProperty["imageX"]+ "<br>";
        }
      }
      pawnListHTML += "</p>";
      if (testDebug == "pawnList") {
        var test = document.getElementById("pawnList");
        if (test) { test.innerHTML = pawnListHTML; }
      }
    },
    failure: function(req) {
      pawnListHTML += 'An error has occurred.';
    }
  }
  var pawns = document.getElementsByClassName("Pawn");
  for(index = 0; index < pawns.length; index++) {
    dw_makeXHRRequest( 'checkPawnProperties', callback, 'POST', 
                       JSON.stringify(pawns[index].id.slice(4)), 'application/json' );
  }
}

function updateAll() {
  // This will update the visibility of Maps, Tiles, and Pawns
  // It will also update the transform of Tiles and Pawns
  // It will also update the leader status and modifiers of Pawns
  // But for all, only if the database is newer

  // first lets toggle the visibility on anything which has requested it
  myHTML = "Selected<br>\n" + selectHTML;
  myHTML += "Toggle List<br>\n";
  updateListHTML = "Update List<br>\n";
  while (toggleList.length > 0) {
    // shift off the table name and the id from the list
    var table = toggleList.shift();
    var id = toggleList.shift();
    myHTML += table + " " + id + "<br>\n";
    // toggle visibility
    doToggleVisibility(table,id);
  }
  if (modifiersList.length > 0) myHTML += "Modifier List<br>\n";
  while (modifiersList.length > 0) {
    // shift off the idPawn name and idModifier from the list
    var pawnId = modifiersList.shift();
    var modifierId = modifiersList.shift();
    myHTML += "Pawn " + pawnId + "  Modifier " + modifierId + "<br>\n";
    // toggle modifier
    doToggleModifier(pawnId,modifierId);
  }
  // Now lets check the update status
  var myT= ["Map","Tile","Pawn"];
  var x,i;
  for (x in myT) {
    // build up a list as [tablename,id1,updated1,id2,updated2,...]
    var myE = [aId,myT[x]];
    var elements = document.getElementsByClassName(myT[x]);
    for(index = 0; index < elements.length; index++) {
      myE.push(elements[index].id.slice(myT[x].length))
      myE.push(elements[index].getAttribute("updated"))
    }
    //myHTML += myE;
    updateFromDatabase(myE);
  }
  if (selectedTileOrPawn.id) {
    if ((mapMode != 'pc') && (selectedTileOrPawn.id.slice(0,4) == "pawn")) {
      updateModifierSelectors(selectedTileOrPawn.id.slice(4))
      updateListHTML += "ModifierListUpdate<br> ";
    } else {
      inactivateModifierSelectors();
    }
  }
  // output for testing purposes
  if (testDebug == "visList") {
    var test = document.getElementById("visList");
    if (test) { test.innerHTML = myHTML; }
  }
}

function updateFromDatabase( table ) {
  // This takes list with [tablename,id1,updated1,id2,updated2,...]
  // and sends it to checkForUpdates
  // which returns a list of the format
  // it returns a list of updated (newer than the updated value) entries from tablename as follows
  //   [tablename,id1,{attribute_assoc_array},id2,...]
  // for Pawns this format is
  //   [tablename,id1,attribute_assoc_array,modifierlist,id2,...]
  //   where modifierlist is [mod1_attribute_assoc_array,mod2_attribute_assoc_array,...]
  // Only entities which need updating are returned

  // callback object defines functions that handle success and failure of request
  var callback = {
    success: function(req) {
      updateListHTML += "<p>";
      //updateListHTML += req.responseText;
      var entries = JSON.parse(req.responseText);
      var table = entries.shift();
      updateListHTML += table + "<br>";
      while (entries.length > 1) {
        var id = table.toLowerCase() + entries.shift();
        updateListHTML += id + "<br>";
        var attribute = entries.shift();
        updateListHTML += attribute['updated'] + "<br>";
        updateTransform(table,id,attribute);
        updateVisibility(table,id,attribute);
        if (table == "Pawn") {
          var modifierList = entries.shift();
          //updateListHTML += modifierList + "<br>";
          updateHeightAndAttackRange(table,id,attribute);
          updateModifiers(table,id,attribute,modifierList);
        }
        document.getElementById(id).setAttribute("updated",attribute["updated"]);
      }
      updateDisplayVisibility();
      updateListHTML += "</p>";
      if (testDebug == "visList") {
        var test = document.getElementById("visList2");
        if (test) { test.innerHTML = updateListHTML; }
      }
    },
    failure: function(req) {
      updateListHTML += 'An error has occurred.';
    }
  }
  // arguments: url, callback object, request method, data (stringified), data type
  dw_makeXHRRequest( 'checkForUpdates', callback, 'POST', JSON.stringify(table), 'application/json' );
}

function updateDisplayVisibility(){
  var divs = document.getElementsByTagName("div")
  for (i = 0; i < divs.length; i++) {
      var maps = divs[i].getElementsByClassName("Map")
      isVisible = (maps.length > 0) ? false : true;
      for (j = 0; j < maps.length; j++) {
          if (maps[j].getAttribute("visibility") != "hidden") {isVisible = true}
      }
      if (isVisible) {
          divs[i].setAttribute("class",divs[i].getAttribute("id") + "Visible")
      } else {
          divs[i].setAttribute("class",divs[i].getAttribute("id") + "Hidden")
      }
  }
}


function updateHeightAndAttackRange(table,id,attribute) {
  if (table == "Pawn") {
    var myE = document.getElementById(id);
    if (myE.getAttribute("attacktype")!="Height") {myE.setAttribute("attacktype",attribute["attackType"]);}
    var groups = myE.getElementsByTagName("g");
    for(gIndex = 0; gIndex < groups.length; gIndex++) {
      updateListHTML += groups[gIndex].id + "<br>";
      if (groups[gIndex].id == "height") {
        var myText = groups[gIndex].getElementsByTagName("tspan");
        if (attribute["height"] != 0) {
          myText[0].innerHTML = 1*attribute["height"];
        } else {
          myText[0].innerHTML = "";
        }
        updateListHTML += table + " Height = " + attribute["height"]+ "<br>";
      } else if (groups[gIndex].id == "attackRange") {
        if (attribute["attackType"] == "None") {
          // scale all attack range display to 0
          groups[gIndex].setAttribute("transform","scale(0)");
          updateListHTML += table + " attackRange Off<br>";
        }
        var attackGroups = groups[gIndex].getElementsByTagName("g");
        for(agIndex = 0; agIndex < attackGroups.length; agIndex++) {
          if (attackGroups[agIndex].id.substr(0,6) == "attack") {
            updateListHTML += table + " " + attackGroups[agIndex].id ;
            if (attackGroups[agIndex].id == "attack"+attribute["attackType"]) {
              // turn on this attack range display
              updateListHTML += " show<br>";
              attackGroups[agIndex].setAttribute("visibility",myE.getAttribute("visibility"));
              var heightScale = 0;
              if (attribute["attackRange"] > Math.abs(attribute["height"])) {
                // let assume the height indicator is showing height of the attacker relative to a height=0 defender
                // then the size of the circle on the grid shown scale as per this height
                // Even a Cone attack is spherical in its furthest extend, tough parabolic on the sides and back
                heightScale = Math.sqrt(Math.pow(1*attribute["attackRange"],2)-Math.pow(1*attribute["height"],2));
              }
              var attackScale = heightScale/attribute["sizeFeet"];
              var tX = 285 - (attackScale*502.5);
              var tY = 45 - (attackScale*502.5);
              // adjust the parent attackRange group
              groups[gIndex].setAttribute("transform","translate("+ tX +" "+ tY +") scale("+ attackScale +")");
            } else {
              // hide this attack range display
              updateListHTML += " hide<br>";
              attackGroups[agIndex].setAttribute("visibility","hidden")
            }
          }
        }
      }
    }
  }
}

function updateTransform(table,id,attribute) {
  updateListHTML += table+" transform: ";
  var myE = document.getElementById(id);
  if (table == "Map") {myE = document.getElementById(id+"g");}
  var myTransform = unpackTransform(myE.getAttribute("transform"),table.toLowerCase());
  myTransform[0] = attribute["rotate"];
  myTransform[3] = attribute["translateX"];
  myTransform[4] = attribute["translateY"];
  if (table == "Pawn") {
    myTransform[1] = 1*attribute["translateX"] + (285.0 * attribute['sizeFeet']*myE.getAttribute("pawnscale"))
    myTransform[2] = 1*attribute["translateY"] + (350.0 * attribute['sizeFeet']*myE.getAttribute("pawnscale"))
    myTransform[5] = attribute['sizeFeet']*myE.getAttribute("pawnscale");
  } else if (table == "Tile") {
    myTransform[1] = 1*attribute["translateX"] + (attribute["imageWidth"] * attribute["scale"] / 2.0);
    myTransform[2] = 1*attribute["translateY"] + (attribute["imageHeight"] * attribute["scale"] / 2.0);
    myTransform[5] = attribute['scale'];
  } else {
    // this does not currently do the full rotation center calculate for Maps
    myTransform[1] = attribute["scale"]*myTransform[1]/myTransform[6]
    myTransform[2] = attribute["scale"]*myTransform[2]/myTransform[6]
    myTransform[5] = attribute['scale'];
  }
  updateListHTML += packTransform(myTransform,table.toLowerCase()) + "<br>";
  myE.setAttribute("transform",packTransform(myTransform,table.toLowerCase()));
}

function updateVisibility(table,id,attribute) {
  updateListHTML += table+" visibility: ";
  var myE = document.getElementById(id);
  var but = document.getElementById(table.toLowerCase()+"Button"+id.slice(table.length));
  if (attribute["visible"] == 1) {
    if (but) {but.setAttribute("class","toggleListVisible");}
    updateListHTML += "visible ";
    if (table == "Map") {
      myE.setAttribute("visibility","visible");
      myE.setAttribute("width",myE.getAttribute("widthvisible"));
      myE.setAttribute("height",myE.getAttribute("heightvisible"));
    } else {
      myE.setAttribute("visibility","visible");
      myE.setAttribute("opacity",1.0);
    }
  } else if ((attribute["dmVisible"] == 1) && (mapMode == "dm")) {
    if (but) {but.setAttribute("class","toggleListOpaque");}
    if (table == "Map") {
      myE.setAttribute("visibility","hidden");
      myE.setAttribute("width","0");
      myE.setAttribute("height","0");
      updateListHTML += "hidden ";
    } else {
      myE.setAttribute("visibility","visible");
      myE.setAttribute("opacity",0.5);
      updateListHTML += "dim ";
    }
  } else {
    if (but) {but.setAttribute("class","toggleListOpaque");}
    myE.setAttribute("visibility","hidden");
    if (table == "Map") {
      myE.setAttribute("width","0");
      myE.setAttribute("height","0");
    }
    updateListHTML += "hidden ";
  } 
  updateListHTML += "<br>";
}

function updateModifiers(table,id,attribute,modifierList) {
  updateListHTML += "total modifiers: "
  var pawn = document.getElementById(id)
  var modE = undefined;
  var modInsertHTML = ""
  var groups = pawn.getElementsByTagName("g");
  for(index = 0; index < groups.length; index++) {
    if (groups[index].id == "modifiers") {modE = groups[index];}
  }
  if (! ((mapMode == "pc") && (pawn.getAttribute("visibility") == "hidden"))) {
    var count = 0
    for(index = 0; index < modifierList.length; index++) {
      modInsertHTML += modifierList[index]["shapeSvg"];
      count++;
    }
    updateListHTML += count + "<br>";
  }
  if (modE) { modE.innerHTML = modInsertHTML; }
}

/* dw_makeXHRRequest function
 * required arguments: url, callback
 * optional arguments: method, postData, and dataType
 */
function dw_makeXHRRequest( url, callback, method, postData, dataType ) {
    if ( !window.XMLHttpRequest ) {
        return null;
    }
    // create request object
    var req = new XMLHttpRequest();
    // assign defaults to optional arguments
    method = method || 'GET';
    postData = postData || null;
    dataType = dataType || 'text/plain';
    // pass method and url to open method
    req.open( method, url );
    // set Content-Type header 
    req.setRequestHeader('Content-Type', dataType);
    // handle readystatechange event
    req.onreadystatechange = function() {
        // check readyState property
        if ( req.readyState === 4 ) { // 4 signifies DONE
            // req.status of 200 means success
            if ( req.status === 200 ) {
                callback.success(req); 
            } else { // handle request failure
                callback.failure(req); 
            }
        }
    }
    req.send( postData ); // send request
    return req; // return request object
}

function toggleVisibility(table,id) {
  //myHTML += "table=" + table + " id=" + id + "<br>\n";
  toggleList.push(table);
  toggleList.push(id);
}

function toggleModifier(id) {
  if (selectedTileOrPawn.id) {
    if (selectedTileOrPawn.getAttribute("class") == "Pawn") {
      modifiersList.push(selectedTileOrPawn.id.slice(4));
      modifiersList.push(id);
    }
  }
}

function doToggleVisibility(table,id) {
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "toggleVisibility", true);
  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhttp.send("table=" + table + "&id=" + id);
}

function doToggleModifier(pawnId,modifierId) {
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "toggleModifier", true);
  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhttp.send("pawnId=" + pawnId + "&modifierId=" + modifierId);
}

function updateModifierSelectors(pawnId) {
  var callback = {
    // The callback needs to loop through the selectors
    //  and turn each either On or Off dependent on if the id
    //  is in the list
    success: function(req) {
      modifierListHTML += "<p>";
      var modifierStatus = JSON.parse(req.responseText);
      var selectors = document.getElementsByName("modifierSelector");
      for(index = 0; index < selectors.length; index++) {
        modifierListHTML += selectors[index].id+": "+modifierStatus[selectors[index].id]+"<br>";
        if (modifierStatus[selectors[index].id]) {
          selectors[index].setAttribute("class","modifierSelectorOn")
        } else {
          selectors[index].setAttribute("class","modifierSelectorOff")
        }
      }
      modifierListHTML += "<p>";
      if (testDebug == "modifierList") {
        var test = document.getElementById("modifierList");
        if (test) { test.innerHTML = modifierListHTML; }
      }
    },
    failure: function(req) {
      modifierListHTML += 'An error has occurred.';
    }
  }
  // find all the modifiers entries for this pawn
  // the XML needs to return with modiferIds (ie. "modifier2,modifier5")
  // as keys to a modifierStatus array
  dw_makeXHRRequest( 'checkPawnModifiers', callback, 'POST', 
                       JSON.stringify(pawnId), 'application/json' );
}

function adjustPawnIndicator(pawnId,indicator,multi,adjust) {
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "adjustPawnIndicator", true);
  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhttp.send("pawnId=" + pawnId + "&indicator=" + indicator + "&multi=" + multi + "&adjust=" + adjust);
}

function updatePawnAttackType(pawnId,attackType) {
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "updatePawnAttackType", true);
  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhttp.send("pawnId=" + pawnId + "&attackType=" + attackType);
}

function inactivateModifierSelectors() {
  var selectors = document.getElementsByName("modifierSelector");
  for(index = 0; index < selectors.length; index++) {
    selectors[index].setAttribute("class","modifierSelectorInactive")
  }
}

function startMapMove(ev,id) {
  ev = ev || event || window.event;
  // starts a Map move by storing the start variables
  // Maps can be moved with a mouse left click and drag,
  //  rotated with a Shift-left click and drag,
  //  and scaled with a Ctrl-left click and drag
  startX = ev.clientX;
  startY = ev.clientY;
  startR = ev.clientX;
  startS = ev.clientY;
  var map = document.getElementById(id);
  oldTransform = unpackTransform(map.getAttribute("transform"),"map");
}

function endMapMove(ev,id) {
  // ends a Map move by
  // resetting the start positions back to 0
  ev = ev || event || window.event;
  startX = 0;
  startY = 0;
  startR = 0;
  startS = 0;
  mode = "t";
  moveRes = globalScale;
  rotRes = 22.5;
  scaleRes = 0.1;
}

function doingMapMove(ev,id) {
  // do a Map move by transforming the element
  // based on the mouse movement
  if ((startX != 0) && (startY != 0)) {
    ev = ev || event || window.event;
    if (ev.altKey) { mode = "s"; }
    if (ev.ctrlKey) { mode = "r"; }
    if (ev.shiftKey) { moveRes = 1.0; rotRes = 1.0; scaleRes = 0.001; }
    var map = document.getElementById(id);
    var newTransform = unpackTransform(map.getAttribute("transform"),"map");
    var mapPixelsPerInch = 1.0*standardMapPixelsPerInch;
    if (map.getAttribute("pixelsperinch") > 0) {mapPixelsPerInch = 1.0*map.getAttribute("pixelsperinch")}
    if (mode == "r") {
      newTransform[0] = 1*oldTransform[0]+Math.floor((ev.clientX-startR)/2.0/rotRes)*rotRes;
      newTransform[0] = newTransform[0] % 360;
      // since I set up the rotations to rotate about the center of the object
      // I should not have to adust the rotation center
      myHTML += oldTransform[0]+"<br>"+newTransform[0]+"<br>" ;
    } else if (mode == "s") {
      newTransform[5] = 1*oldTransform[5]+Math.floor((ev.clientY-startS)/500.0/scaleRes)*scaleRes;
      newTransform[6] = newTransform[5];
      // since the scale is applied first, if I want it to scale about the center of the object
      // I have to adjust the translation as well
      // Since I want to scale about the same center as the rotation, I will use it 
      // as the standard point
      newTransform[3] = 1*oldTransform[1] - (1*oldTransform[1] - 1*oldTransform[3])*(1*newTransform[5] / (1*oldTransform[5]));
      newTransform[4] = 1*oldTransform[2] - (1*oldTransform[2] - 1*oldTransform[4])*(1*newTransform[5] / (1*oldTransform[5]));
      myHTML += oldTransform[5]+"<br>"+newTransform[5]+"<br>" ;
    } else {
      // since the translation is applied before the rotation
      // if I want the Map to move relative to its current rotation
      // I have to back rotate the user's mouse move
      var cr = Math.cos(-1*oldTransform[0]*Math.PI/180);
      var sr = Math.sin(-1*oldTransform[0]*Math.PI/180);
      //var dX = Math.floor((ev.clientX-startX)/moveRes)*moveRes*standardMapPixelsPerInch/globalScale;
      //var dY = Math.floor((ev.clientY-startY)/moveRes)*moveRes*standardMapPixelsPerInch/globalScale;
      var dX = Math.floor((ev.clientX-startX)/moveRes)*moveRes*mapPixelsPerInch/globalScale;
      var dY = Math.floor((ev.clientY-startY)/moveRes)*moveRes*mapPixelsPerInch/globalScale;
      newTransform[3] = 1*oldTransform[3]+dX*cr-dY*sr;
      newTransform[4] = 1*oldTransform[4]+dX*sr+dY*cr;
      // since the rotation is set to rotate about the center of the view box
      // I think it should stay there for rotating maps.  This will not be the case for pawns or tiles
      myHTML += "dX:"+dX+"<br>"+oldTransform[3]+"<br>"+newTransform[3]+"<br>" ;
      myHTML += "dY:"+dY+"<br>"+oldTransform[4]+"<br>"+newTransform[4]+"<br>" ;
    }
    map.setAttribute("transform",packTransform(newTransform),"map");
  }
}

function unpackTransform(trs,type) {
  // unpack the transform string into and 7 member array
  // of rotate,rotate_center_x,rotate_center_y,scale_x,scale_y,translate_x,translate_y
  var r = trs.match(/rotate\s*\((\s*[^)]+\s*)\)/i)[1].split(" ");
  if (r.length < 3) {r[1]=0;r[2]=0;}
  var t = trs.match(/translate\s*\((\s*[^)]+\s*)\)/i)[1].split(" ");
  if (t.length < 2) {t[1]=0;}
  var s = trs.match(/scale\s*\((\s*[^)]+\s*)\)/i)[1].split(" ");
  if (s.length < 2) {s[1]=s[0];}
  return r.concat(t).concat(s);
}

function packTransform(tra,type) {
  return "rotate("+tra[0]+" "+tra[1]+" "+tra[2]+") translate("+tra[3]+" "+tra[4]+") scale("+tra[5]+")";
}

function moveTileOrPawn(elem,type,mode,dir,res) {
  myHTML += elem.id+" move: "+mode+" "+dir+" "+res+"<br>";
  var step = 1*{up:1,down:-1}[dir]*res
  var oldTransform = unpackTransform(elem.getAttribute("transform"),type);
  var newTransform = unpackTransform(elem.getAttribute("transform"),type);
  var mapPixelsPerInch = document.getElementById(elem.getAttribute("idmap")).getAttribute("pixelsperinch");
  if (mapPixelsPerInch <= 0) {mapPixelsPerInch = standardMapPixelsPerInch;};
  if (mode == "r") {
    newTransform[0] = 1*oldTransform[0]+step;
    newTransform[0] = newTransform[0] % 360;
    myHTML += oldTransform[0]+"<br>"+newTransform[0]+"<br>" ;
  } else if ((mode == "s")&&(mapMode != 'pc')) {
    newTransform[5] = 1*oldTransform[5]+step
    newTransform[6] = newTransform[5];
    // since the scale is applied first, if I want it to scale about the center of the object
    // I have to adjust the translation as well
    // Since I want to scale about the same center as the rotation, I will use it 
    // as the standard point
    newTransform[3] = 1*oldTransform[1] - (1*oldTransform[1] - 1*oldTransform[3])*(1*newTransform[5] / (1*oldTransform[5]));
    newTransform[4] = 1*oldTransform[2] - (1*oldTransform[2] - 1*oldTransform[4])*(1*newTransform[5] / (1*oldTransform[5]));
    myHTML += oldTransform[5]+"<br>"+newTransform[5] ;
  } else {
    // since Tiles and Pawns are inside maps they already
    // have the transformation imposed on them from the map
    // to get the X and Y to behave the way I want
    // I need to back rotate from the map
    var mapTransform = unpackTransform(elem.parentElement.getAttribute("transform"),type)
    // since the translation is applied before the rotation
    // if I want the Map to move relative to its current rotation
    // I have to back rotate the step
    //var cr = Math.cos((-1*oldTransform[0]-1*mapTransform[0])*Math.PI/180);
    //var sr = Math.sin((-1*oldTransform[0]-1*mapTransform[0])*Math.PI/180);
    var cr = Math.cos((-1*mapTransform[0])*Math.PI/180);
    var sr = Math.sin((-1*mapTransform[0])*Math.PI/180);
    //var dX = step*standardMapPixelsPerInch/globalScale;
    //var dY = -1*step*standardMapPixelsPerInch/globalScale;
    var dX = step*mapPixelsPerInch/globalScale;
    var dY = -1*step*mapPixelsPerInch/globalScale;
    if (mode == "x") { dY = 0.0; } else { dX = 0.0; }
    newTransform[3] = 1*oldTransform[3]+dX*cr-dY*sr;
    newTransform[4] = 1*oldTransform[4]+dX*sr+dY*cr;
    // Keep the center of rotation on the tile or pawn center
    newTransform[1] = 1*oldTransform[1]+dX*cr-dY*sr;
    newTransform[2] = 1*oldTransform[2]+dX*sr+dY*cr;
    myHTML += "dX:"+dX+","+oldTransform[3]+"to"+newTransform[3]+"<br>" ;
    myHTML += "dY:"+dY+","+oldTransform[4]+"to"+newTransform[4]+"<br>" ;
  }
  elem.setAttribute("transform",packTransform(newTransform,type));
  if (type == "pawn") {saveOne("Pawn",elem);}
  needsSave = true;
}

function interpretKeyUp(ev) {
  // reset the key hold flag when a key is released
  keyHold = null;
}

function interpretKeyDown(ev) {
  ev = ev || event || window.event;
  var key = ev.which || ev.keyCode;
  var keyHTML = "pressed: "+key+" = " + String.fromCharCode(key).toLowerCase() + "<br>";
  if ((key == 83) && (! keyHold)) { 
    // save on an "s" but do not repeat if held
    forceSave() 
  } else if ((key >= 37) && (key <= 40) && selectedTileOrPawn.id) {
    var type = selectedTileOrPawn.getAttribute("class").toLowerCase();
    // 37 -> left arrow
    // 38 -> up arrow
    // 39 -> right arrow
    // 40 -> down arrow
    // normal translate mode without modifiers
    // this can repeat if held
    var mode = {37:"x",38:"y",39:"x",40:"y"}[key]
    // shift is fine resolution
    var res = globalScale; if (ev.shiftKey) {res = 1.0;}
    // ctrl is rotate/translate
    if (ev.ctrlKey) {mode = {37:"r",38:"s",39:"r",40:"s"}[key]}
    // shift is fine resolution for both
    if (mode == "s") { 
      res = 0.1;
      if (type == "pawn") {res = 5.0*selectedTileOrPawn.getAttribute("pawnscale");}
      if (ev.shiftKey) {
        res = 0.001;
        if (type == "pawn") {res = 1.0*selectedTileOrPawn.getAttribute("pawnscale");}
      }
    } else if (mode == "r") { res = 15.0;if (ev.shiftKey) {res = 0.15;}}
    switch(key) {
      case 37:
        if (selectedTileOrPawn.getAttribute("leader")=="1") {
          var role = selectedTileOrPawn.getAttribute("role");
          var pawns = document.getElementsByClassName("Pawn");
          for(index = 0; index < pawns.length; index++) {
            if ((pawns[index].getAttribute("role") == role) &&
                (pawns[index].getAttribute("visibility") == "visible")) {
              moveTileOrPawn(pawns[index],type,mode,"down",res);
            }
          }
        } else {
          moveTileOrPawn(selectedTileOrPawn,type,mode,"down",res);
        }
        break;
      case 38:
        if (selectedTileOrPawn.getAttribute("leader")=="1") {
          var role = selectedTileOrPawn.getAttribute("role");
          var pawns = document.getElementsByClassName("Pawn");
          for(index = 0; index < pawns.length; index++) {
            if ((pawns[index].getAttribute("role") == role) &&
                (pawns[index].getAttribute("visibility") == "visible")) {
              moveTileOrPawn(pawns[index],type,mode,"up",res);
            }
          }
        } else {
          moveTileOrPawn(selectedTileOrPawn,type,mode,"up",res);
        }
        break;
      case 39:
        if (selectedTileOrPawn.getAttribute("leader")=="1") {
          var role = selectedTileOrPawn.getAttribute("role");
          var pawns = document.getElementsByClassName("Pawn");
          for(index = 0; index < pawns.length; index++) {
            if ((pawns[index].getAttribute("role") == role) &&
                (pawns[index].getAttribute("visibility") == "visible")) {
              moveTileOrPawn(pawns[index],type,mode,"up",res);
            }
          }
        } else {
          moveTileOrPawn(selectedTileOrPawn,type,mode,"up",res);
        }
        break;
      case 40:
        if (selectedTileOrPawn.getAttribute("leader")=="1") {
          var role = selectedTileOrPawn.getAttribute("role");
          var pawns = document.getElementsByClassName("Pawn");
          for(index = 0; index < pawns.length; index++) {
            if ((pawns[index].getAttribute("role") == role) &&
                (pawns[index].getAttribute("visibility") == "visible")) {
              moveTileOrPawn(pawns[index],type,mode,"down",res);
            }
          }
        } else {
          moveTileOrPawn(selectedTileOrPawn,type,mode,"down",res);
        }
        break;
      default:
        keyHTML += "pressed: "+key+" on "+type+" "+selectedTileOrPawn.id+"<br>";
        break;
    }
  } else if ((key == 86) && selectedTileOrPawn.id && (mapMode != 'pc') && (! keyHold)) {
    // toggle visibility of selected Tile or Pawn if "v" is pressed (no repeat if held)
    var table = selectedTileOrPawn.getAttribute("class");
    var id = selectedTileOrPawn.id.slice(table.length);
    toggleVisibility(table,id);
  } else if (((key == 65)||(key == 72)||(key == 74)||(key == 75)||(key == 76)||(key == 190)||(key == 187)||(key == 188)) && selectedTileOrPawn.id && (! keyHold)) {
    // setting leader, ranges, height, etc with no repeat
    var table = selectedTileOrPawn.getAttribute("class");
    if (table == "Pawn") {
      if (key == 65) {
        // toggle leadership of selected Pawn if "a" is pressed
        var pawns = document.getElementsByClassName("Pawn");
        var alreadyLeader = false;
        if (selectedTileOrPawn.getAttribute("leader")=="1") {
          alreadyLeader = true;
        }
        for(index = 0; index < pawns.length; index++) {
          // unassign all other pawns of the same role (i.e. pc,npc,monster,etc)
          if (pawns[index].getAttribute("role") == 
              selectedTileOrPawn.getAttribute("role")) {
            pawns[index].setAttribute("leader",0);
          }
        }
        if (! alreadyLeader) {
          selectedTileOrPawn.setAttribute("leader",1);
        }
      } else if ((key == 72) && selectedTileOrPawn.id) {
        // h to turn off attackRange to adjust height
        // only set the attribute attacktype to Height so I can leave on the 
        // attackRange display while adjusting the height
        // this causes a mismatch with the database however
        //updatePawnAttackType(selectedTileOrPawn.id.slice(4),"Height");
        if (selectedTileOrPawn.getAttribute("attacktype") == "Height") {;
          selectedTileOrPawn.setAttribute("attacktype","None");
          adjustPawnIndicator(selectedTileOrPawn.id.slice(4),"attackRange",1,0);
        } else {
          selectedTileOrPawn.setAttribute("attacktype","Height");
        }
      } else if ((key == 74) && selectedTileOrPawn.id) {
        // j to toggle attackSphere display
        if (selectedTileOrPawn.getAttribute("attacktype") != "Sphere") {
          // set the attribute only to None so that height mode is turned off
          selectedTileOrPawn.setAttribute("attacktype","None");
          updatePawnAttackType(selectedTileOrPawn.id.slice(4),"Sphere");
        } else {
          updatePawnAttackType(selectedTileOrPawn.id.slice(4),"None");
        }
        adjustPawnIndicator(selectedTileOrPawn.id.slice(4),"attackRange",1,0)
      } else if ((key == 75) && selectedTileOrPawn.id) {
        // k to toggle attackCone display
        if (selectedTileOrPawn.getAttribute("attacktype") != "Cone") {
          // set the attribute only to None so that height mode is turned off
          selectedTileOrPawn.setAttribute("attacktype","None");
          updatePawnAttackType(selectedTileOrPawn.id.slice(4),"Cone");
        } else {
          updatePawnAttackType(selectedTileOrPawn.id.slice(4),"None");
        }
        adjustPawnIndicator(selectedTileOrPawn.id.slice(4),"attackRange",1,0)
      } else if ((key == 76) && selectedTileOrPawn.id) {
        // l to toggle attackLine display
        if (selectedTileOrPawn.getAttribute("attacktype") != "Line") {
          // set the attribute only to None so that height mode is turned off
          selectedTileOrPawn.setAttribute("attacktype","None");
          updatePawnAttackType(selectedTileOrPawn.id.slice(4),"Line");
        } else {
          updatePawnAttackType(selectedTileOrPawn.id.slice(4),"None");
        }
        adjustPawnIndicator(selectedTileOrPawn.id.slice(4),"attackRange",1,0)
      } else if ((key == 190)||(key == 109)||(key == 187)||(key == 188)) {
        var adjust = 0;
        var multi = 1;
        // 190 is "." to increase heightIndicator by 5
        // 188 is "," to decrease heightIndicator by 5
        // 187 is "=" to set heightIndicator to 0
        if (key == 190) { adjust = 5; }
        if (key == 188) { adjust = -5; }
        if (key == 187) { multi = 0; }
        if ((selectedTileOrPawn.getAttribute("attacktype") != "None")&&(selectedTileOrPawn.getAttribute("attacktype") != "Height")) {
          adjustPawnIndicator(selectedTileOrPawn.id.slice(4),"attackRange",multi,adjust)
        } else {
          adjustPawnIndicator(selectedTileOrPawn.id.slice(4),"height",multi,adjust)
        }
      }
    }
  } else if (! keyHold) {
    // all other key presses, but only once, not if held
    var pawns = document.getElementsByClassName("Pawn");
    for(index = 0; index < pawns.length; index++) {
      // check that the pawn is on a currently visible map
      if (document.getElementById("map"+pawns[index].getAttribute("idmap").slice(3)).getAttribute("visibility") == "visible") {
        if ((pawns[index].hasAttribute("selectkey")) &&  
            ((pawns[index].getAttribute("selectkey") == String.fromCharCode(key).toUpperCase()) ||
             (pawns[index].getAttribute("selectkey") == String.fromCharCode(key).toLowerCase()))) {
          keyHTML += "keySelect "+pawns[index].id+"<br>";
          selectTileOrPawn(pawns[index].id);
          break;
        } else {
          //keyHTML += pawns[index].id + " " + pawns[index].getAttribute("selectkey") + "<br>";
        }
      }
    }
  }
  if (testDebug == "keyPress") {
    var test = document.getElementById("keyPress");
    if (test) { test.innerHTML = keyHTML; }
  }
  keyHold = key;
}

function selectTileOrPawn(id) {
  selectHTML = selectedTileOrPawn.id+" -> ";
  var newSelectedTileOrPawn = document.getElementById(id);
  var newType = newSelectedTileOrPawn.getAttribute("class");
  var highlightOn = {"Pawn":"outline: 20px solid orange; outline-offset: 2px;",
                     "Tile":"outline: thick solid orange; outline-offset: 2px;"}[newType];
  var highlightOff = "outline: none; outline-offset: 0px;"
  if (selectedTileOrPawn.id) {
    // remove outline from previously selected Tile or Pawn
    selectedTileOrPawn.setAttribute("style",highlightOff);
    // select the new Tile or Pawn if it is not the same one
    if (selectedTileOrPawn.id != id) {
      selectedTileOrPawn = newSelectedTileOrPawn;
      selectedTileOrPawn.setAttribute("style",highlightOn);
      if ((newType == "Pawn") && (mapMode != 'pc')) {updateModifierSelectors(selectedTileOrPawn.id.slice(4));}
      if (selectedTileOrPawn.getAttribute("rulelink") && document.getElementById("ruleLink")) {
        selectHTML += selectedTileOrPawn.getAttribute("rulelink");
        document.getElementById("ruleLink").setAttribute("href",selectedTileOrPawn.getAttribute("rulelink"));
        document.getElementById("ruleLink").innerHTML = selectedTileOrPawn.getAttribute("name");
      }
    } else {
      // deselect Tile or Pawn
      selectedTileOrPawn = {};
      inactivateModifierSelectors();
      if (document.getElementById("ruleLink")) {
        document.getElementById("ruleLink").setAttribute("href","http://paizo.com/prd/");
        document.getElementById("ruleLink").innerHTML = "PRD";
      }
    }
  } else {
    // select the new Tile or Pawn
    selectedTileOrPawn = newSelectedTileOrPawn;
    selectedTileOrPawn.setAttribute("style",highlightOn);
    if ((newType == "Pawn") && (mapMode != 'pc')) {updateModifierSelectors(selectedTileOrPawn.id.slice(4))}
    if (selectedTileOrPawn.getAttribute("rulelink") && document.getElementById("ruleLink")) {
      selectHTML += selectedTileOrPawn.getAttribute("rulelink");
      document.getElementById("ruleLink").setAttribute("href",selectedTileOrPawn.getAttribute("rulelink"));
      document.getElementById("ruleLink").innerHTML = selectedTileOrPawn.getAttribute("name");
    }
  }
  selectHTML += selectedTileOrPawn.id+"<br>";
}

function saveOne(table,myElement) {
  var saveHTML = "saveOne<br>";
  var saveList = [table,myElement.id.slice(4)]
  var attribute = {};
  for (ai = 0; ai < myElement.attributes.length; ai++) {
    attribute[myElement.attributes.item(ai).name] = myElement.attributes.item(ai).value;
  }
  saveList.push(attribute);
  var callback = {
    success: function(req) {
      saveHTML += req.responseText;
      if (testDebug == "saveList") {
        var test = document.getElementById("saveList");
        if (test) { test.innerHTML = saveHTML; }
      }
    },
    failure: function(req) {
      saveHTML += 'An error has occured.';
    }
  }
  //saveHTML += JSON.stringify(saveList) + "<br>";
  dw_makeXHRRequest( 'saveMapTilePawn', callback, 'POST', JSON.stringify(saveList), 'application/json' );
}

function saveStuff(myT) {
  if (needsSave) {
    var saveHTML = "saveList<br>";
    //var myT= ["Map","Tile","Pawn"];
    var x,i;
    for (x in myT) {
      var saveList = [myT[x]];
      var elements = document.getElementsByClassName(myT[x]);
      for(index = 0; index < elements.length; index++) {
        saveList.push(elements[index].id.slice(myT[x].length));
        var attribute = {};
        var myElement = elements[index]
        if (myT[x] == "Map") {
          myElement = document.getElementById("map"+elements[index].id.slice(myT[x].length)+"g");
        }
        for (ai = 0; ai < myElement.attributes.length; ai++) {
          attribute[myElement.attributes.item(ai).name] = myElement.attributes.item(ai).value;
        }
        saveList.push(attribute);
      }
      var callback = {
        success: function(req) {
          saveHTML += req.responseText;
          if (testDebug == "saveList") {
            var test = document.getElementById("saveList");
            if (test) { test.innerHTML = saveHTML; }
          }
        },
        failure: function(req) {
          saveHTML += 'An error has occured.';
        }
      }
      //saveHTML += JSON.stringify(saveList) + "<br>";
      dw_makeXHRRequest( 'saveMapTilePawn', callback, 'POST', JSON.stringify(saveList), 'application/json' );
    }
  }
  if (testDebug == "saveList") {
    var test = document.getElementById("saveList");
    if (test) { test.innerHTML = saveHTML; }
  }
  needsSave = false;
}

function forceSave() {
  needsSave = true;
  saveStuff(["Map","Tile","Pawn"]);
}

</script>
<style>
<?php
// select displays and order by depth
$displays = $conn->query("SELECT * FROM Display ORDER BY depth DESC");
// loop through each and create a div CSS block for each
if ($displays->num_rows > 0) {
  while($d = $displays->fetch_assoc()) {
    // output div CSS block for each display
   echo "div.display".$d["idDisplay"]."Visible {\n";
    if ($d["position"] != NULL) {echo "  position: ".$d["position"].";\n";}
    if ($d["width"] != NULL) {echo "  width: ".$d["width"].";\n";}
    if ($d["height"] != NULL) {echo "  height: ".$d["height"].";\n";}
    if ($d["top"] != NULL) {echo "  top: ".$d["top"].";\n";}
    if ($d["bottom"] != NULL) {echo "  bottom: ".$d["bottom"].";\n";}
    if ($d["left"] != NULL) {echo "  left: ".$d["left"].";\n";}
    if ($d["right"] != NULL) {echo "  right: ".$d["right"].";\n";}
    if ($d["transform"] != NULL) {echo "  transform: ".$d["transform"].";\n";}
    if ($d["backgroundColor"] != NULL) {echo "  background-color: ".$d["backgroundColor"].";\n";}
    if (strpos($d['name'],"List") or strpos($d['name'],"Selectors")) { echo "  overflow-x: hidden;\n  overflow-y: auto;\n";}
    echo "  visibility: inherit;\n";
    #echo "  border:1px solid #A0A0A0;\n";
    echo "}\n";
   echo "div.display".$d["idDisplay"]."Hidden {\n";
    if ($d["position"] != NULL) {echo "  position: ".$d["position"].";\n";}
    echo "  width: 0;\n";
    if ($d["height"] != NULL) {echo "  height: ".$d["height"].";\n";}
    if ($d["top"] != NULL) {echo "  top: ".$d["top"].";\n";}
    if ($d["bottom"] != NULL) {echo "  bottom: ".$d["bottom"].";\n";}
    if ($d["left"] != NULL) {echo "  left: ".$d["left"].";\n";}
    if ($d["right"] != NULL) {echo "  right: ".$d["right"].";\n";}
    if ($d["transform"] != NULL) {echo "  transform: ".$d["transform"].";\n";}
    if ($d["backgroundColor"] != NULL) {echo "  background-color: ".$d["backgroundColor"].";\n";}
    if (strpos($d['name'],"List") or strpos($d['name'],"Selectors")) { echo "  overflow-x: hidden;\n  overflow-y: auto;\n";}
    echo "  visibility: inherit;\n";
    #echo "  border:1px solid #000000;\n";
    echo "}\n";
  }
}
// reset the select table back to the start
$displays->data_seek(0);
?>
button.toggleListVisible {
  margin: 0px;
  border: 0px;
  padding: 1px;
  background-color: LightGreen;
  color: Red;
}
button.toggleListOpaque {
  margin: 0px;
  border: 0px;
  padding: 1px;
  background-color: LightGreen;
  color: Yellow;
}
button.modifierSelectorInactive {
  margin: 0px;
  border: 0px;
  padding: 1px;
  background-color: transparent;
  color: Grey;
}
button.modifierSelectorOn {
  margin: 0px;
  border: 0px;
  padding: 1px;
  background-color: Yellow;
  color: Black;
}
button.modifierSelectorOff {
  margin: 0px;
  border: 0px;
  padding: 1px;
  background-color: transparent;
  color: Black;
}
</style>
</head>
<body onkeydown="interpretKeyDown(event)" onkeyup="interpretKeyUp(event)">
<?php 
// loop through displays again
if ($displays->num_rows > 0) {
  while($d = $displays->fetch_assoc()) {
    // Check if this a List display (i.e. likely no map)
    // List displays and modifierSelectors only exist for the DM
    if (strpos($d['name'],"List") && $mapMode == "dm") {
      // output div element for display
      echo '<div id="display'.$d["idDisplay"].'" class="display'.$d["idDisplay"].'Visible">'."\n";
      // select all the DM visible Maps for this list
      $maps = $conn->query("SELECT * FROM MapDmVisibleOnDisplay WHERE mtName=\"".str_replace("List","",$d['name'])."\" AND idAdventure=".$aId." ORDER BY mName ASC");
      // Lets put buttons to toggle the PC visibility for each DM visible map of this type
      if ($maps->num_rows > 0) {
        while($m = $maps->fetch_assoc()) {
          echo '<button id="mapButton'.$m["idMap"].'" class="';
          if ($m['mVis']==1) {echo 'toggleListVisible';} else {echo 'toggleListOpaque';}
          echo '" onclick="toggleVisibility(\'Map\','.$m["idMap"].')">'.$m["mName"]."</button><br>\n";
        }
      }
    } elseif (($d['name'] == "modifierSelectors") && $mapMode == "dm") {
      // output div element for display
      echo '<div id="display'.$d["idDisplay"].'" class="display'.$d["idDisplay"].'Visible">'."\n";
      // select all the Modifiers for this list
      $modifiers = $conn->query("SELECT * FROM Modifier ORDER BY name");
      // Lets put buttons to toggle the toggle modfiers for selected Pawns
      if ($modifiers->num_rows > 0) {
        while($m = $modifiers->fetch_assoc()) {
          echo '<button id="modifier'.$m["idModifier"].'" name="modifierSelector" class="modifierSelectorInactive" onclick="toggleModifier('.$m["idModifier"].')">'.$m["name"]."</button>\n";
        }
      }
      echo '<a id="ruleLink" href="http://paizo.com/prd/" target="_blank">PRD</a>';
      echo '<button id="saveButton" onclick="forceSave()">Save</button>';
    } elseif (($d['name'] == "modifierSelectors") && $mapMode == "pc") {
      // output div element for display
      echo '<div id="display'.$d["idDisplay"].'" class="display'.$d["idDisplay"].'Visible">'."\n";
      // give the PCs a save button
      echo '<button id="saveButton" onclick="forceSave()">Save</button>';
      //echo '<button id="saveButton" onclick="fillOutPawns()">Pawn&nbsp;Redraw</button>';
    } elseif ((! strpos($d['name'],"List")) && ($d['name'] != "modifierSelectors")) {
      // output div element for each display
      echo '<div id="display'.$d["idDisplay"].'" class="display'.$d["idDisplay"].'Visible">'."\n";
    } 

    // select maps
    // if a map is associated with a display it is assumed to be active (not necessarily visible)
    $maps = $conn->query("SELECT * FROM MapMapType WHERE idDisplay = ".$d["idDisplay"]." AND idAdventure=".$aId." ORDER BY depth DESC");
    //loop through maps for each display
    if ($maps->num_rows > 0) {
      while($m = $maps->fetch_assoc()) {
        // Outer most svg element
        //  this contains the visibility information as well as the scale and size
        //  for the overal mapping area
        // elements which visibility needs to be able to change are given a class
        echo '<svg class="Map" ';
        // Map visibility, only if visible for PC
        if (isVisible($m,"pc")) {
          echo 'visibility="visible" ';
        } elseif (isVisible($m,$mapMode)) {
          echo 'visibility="hidden" ' ;
        }
        // Map element id 
        echo 'id="map'.$m["idMap"].'" ';
        //echo 'updated="'.$m["updated"].'" ';
        echo 'updated="2000-01-01 01:00:00" ';
        // scaling for Maps which need to have a real word scale for physical pawns
        $dWidth = str_replace("px","",$d["width"]);
        $dHeight = str_replace("px","",$d["height"]);
        $bx = 0; $by = 0;
        if (($m["pixelsPerFoot"] != NULL) && ($m["feetPerInch"] != NULL)) {
          $vbx = NULL; $vby = NULL;
          $vbxz = 0; $vbyz = 0;
          if ($m["widthInches"] != NULL) {
            // When Maps are "hidden" they are also shrunk to 0 so they do not block each other
            // The widthVisible and heightVisibly store the original size
            if (isVisible($m,"pc")) { echo 'width="'.$globalScale*$m["widthInches"].'" ';
            } else {echo 'width="0" ';}
            echo 'widthvisible="'.$globalScale*$m["widthInches"].'" ';
            $bx = $m["widthInches"] * $m["pixelsPerFoot"] * $m["feetPerInch"];
            $vbx = $bx / $pawnGridReduce;
            $vbxz = ($pawnGridReduce - 1.0) * $bx / 2.0 ;
          }
          if ($m["heightInches"] != NULL) {
            // When Maps are "hidden" they are also shrunk to 0 so they do not block each other
            // The widthVisible and heightVisibly store the original size
            if (isVisible($m,"pc")) { echo 'height="'.$globalScale*$m["heightInches"].'" ';
            } else {echo 'height="0" ';}
            echo 'heightvisible="'.$globalScale*$m["heightInches"].'" ';
            $by = $m["heightInches"] * $m["pixelsPerFoot"] * $m["feetPerInch"];
            $vby = $by / $pawnGridReduce;
            $vbyz = ($pawnGridReduce - 1.0) * $by / 2.0 ;
          }
          if (($vbx != NULL) && ($vby != NULL)) {echo 'viewBox="'. $vbxz .' '. $vbyz .' '. $vbx .' '. $vby .'" ';}
          echo 'pixelsperinch="'. ($m["pixelsPerFoot"] * $m["feetPerInch"]) .'" ';
        } else {
          // other map types get set to the same size as the display
          // I may want to change this for overviewMaps versus illustrations or not
          if (isVisible($m,"pc")) { echo 'width="'.$dWidth.'" height= "'.$dHeight.'" ';
          } else { echo 'width="0" height= "0" ';}
          echo 'widthvisible="'.$dWidth.'" heightvisible= "'.$dHeight.'" ';
          echo 'viewBox="0 0 '.$dWidth.' '.$dHeight.'" '; 
        }
        if ($m["mapType"] == "pawnGrid") {
          // pawnGrids need to not change aspect 
          echo 'preserveAspectRatio="xMinYMin slice" ';
          // put map move controls here so that the mouse active area does not change when the map's transformation does
          echo 'onmousedown="startMapMove(event,\'map'.$m["idMap"].'g\')" onmouseup="endMapMove(event,\'map'.$m["idMap"].'g\')" onmousemove="doingMapMove(event,\'map'.$m["idMap"].'g\')" ';
          echo 'style="border:1px solid #EEEEEE" '; // red for testing
        }
        //echo 'style="border:1px solid #FF0000" '; // red for testing
        echo 'xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" ';
        echo ">\n";
        // Outer most g element for map transformation
        //  this positions the map within its window.
        //  can be used to scroll map.  Perhaps add a drag event?
        echo '<g id="map'.$m["idMap"].'g" ';
        if ($m["mapType"] == "pawnGrid") {
          echo 'pixelsperinch="'. ($m["pixelsPerFoot"] * $m["feetPerInch"]) .'" ';
        }
        echo 'transform="';
        // pawnGrid map types use pixelsPerFoot and feetPerInch to determine scale
        if ($m["mapType"] == "pawnGrid") {
         echo 'rotate('. $m["rotate"] .' '. $m["scale"]*$bx/2 .' '. $m["scale"]*$by/2 .') ';
         echo 'translate('. $m["translateX"] .' '. $m["translateY"] .') ';
         echo 'scale('. $m["scale"] .') ';
        // non pawnGrid map types use a straigt scale factor
        } else {
         echo 'rotate('. $m["rotate"] .' '. $m["scale"]*$dWidth/2 .' '. $m["scale"]*$dHeight/2 .') ';
         echo 'translate('. $m["translateX"] .' '. $m["translateY"] .') ';
         echo 'scale('. $m["scale"] .') ';
        }
        echo "\"> \n";

        // select Tiles within the Map
        $tiles = $conn->query("SELECT * FROM TileImageSourceLocation WHERE idMap = ".$m["idMap"]." ORDER BY depth DESC");
        // loop through tiles for display on this map
        if ($tiles->num_rows > 0) {
          while($t = $tiles->fetch_assoc()){
            // again class name assigned for element that needs to be able to change its visibility
            echo '<g class="Tile" ';
            echo 'style="outline: none; outline-offset: 2px;" ';
            // in DM mode, those tiles which are dmVisible but PC invisible are patially opace and
            //  double clickable to toggle their PC visibiliy
            if (isVisible($t,$mapMode)) {
              echo 'visibility="visible" ';
              if (($mapMode == "dm") && (! isVisible($t,"pc")))  { echo 'opacity=0.5 ' ; }
            } else {
              echo 'visibility="hidden" ' ;
            }
            // id for the element
            echo 'id="tile'.$t["idTile"].'" ';
            echo 'idmap="map'.$t["idMap"].'" ';
            echo 'rulelink="'.$t["ruleLink"].'" ';
            echo 'name="'.$t["name"].'" ';
            //echo 'updated="'. $t["updated"] .'" ';
            echo 'updated="2000-01-01 01:00:00" ';
            if ($mapMode == "dm") { 
              // add the dbl click event in DM mode
              echo 'ondblclick="toggleVisibility(\'Tile\','.$t["idTile"].')" '; 
              // add a click event for selecting to move in DM mode
              echo 'onclick="selectTileOrPawn(\'tile'.$t["idTile"].'\')" ';
            }
            // transformation for the tile within the map
            echo 'transform="' ;
            echo 'rotate(' . $t["rotate"] .' '. ($t["translateX"] + ($t["scale"] * $t["imageWidth"] / 2.0)) ;
            echo ' '. ($t["translateY"] + ($t["scale"] * $t["imageHeight"] / 2.0)) .') ';
            echo 'translate('. $t["translateX"] .' '. $t["translateY"] .') ';
            echo 'scale('. $t["scale"] .') ';
            echo '">'." \n";
            // image associated with this Tile
            echo "<image width=".$t["imageWidth"]." height=".$t["imageHeight"];
            echo ' xlink:href="'. $appRoot . getDirName($conn,$t["idLocation"],$t["treeDepth"])."/".$t["filename"].'"></image>'."\n";
            echo "</g> <!-- close tile-->\n";
          }
        }

        // select Pawns within the Map
        $pawns = $conn->query("SELECT * FROM PawnRoleImageSourceLocation WHERE idMap = ".$m["idMap"]." ORDER BY depth DESC");
        // loop through pawns for display on this map
        if ($pawns->num_rows > 0) {
          while($p = $pawns->fetch_assoc()){
            // again class name assigned for element that needs to be able to change its visibility
            echo '<g class="Pawn" ';
            echo 'style="outline: none; outline-offset: 2px;" ';
            // in DM mode, those pawns which are dmVisible but PC invisible are patially opace and
            //  double clickable to toggle their PC visibiliy
            if (isVisible($p,$mapMode)) {
              echo 'visibility="visible" ';
              if (($mapMode == "dm") && (! isVisible($p,"pc")))  { echo 'opacity=0.5 ' ; }
            } else {
              echo 'visibility="hidden" ' ;
            }
            // id for the element
            echo 'id="pawn'.$p["idPawn"].'" ';
            echo 'idmap="map'.$p["idMap"].'" ';
            echo 'rulelink="'.$p["ruleLink"].'" ';
            echo 'name="'.$p["name"].'" ';
            //echo 'updated="'. $p["updated"]. '" ';
            echo 'updated="2000-01-01 01:00:00" ';
            echo 'leader="0" ';
            echo 'role="'. $p["idRole"]. '" ';
            echo 'rolename="'. $p["roleName"]. '" ';
            echo 'pawnimagehref="'. $appRoot . getDirName($conn,$p["idLocation"],$p["treeDepth"])."/".rawurlencode($p["filename"]) .'" ';
            if ($p["selectKey"] && (($p["roleName"] == "pc")||($mapMode == "dm"))) {echo 'selectkey="'.$p["selectKey"].'" ';}
            //echo 'selectkey="'.$p["selectKey"].'" ';
            if ($mapMode == "dm") { 
              // add the dbl click event in DM mode
              echo 'ondblclick="toggleVisibility(\'Pawn\','.$p["idPawn"].')" '; 
            }
            if (($p["roleName"] == "pc")||($mapMode == "dm")) {
              // add a click event for selecting to move
              echo 'onclick="selectTileOrPawn(\'pawn'.$p["idPawn"].'\')" ';
            }
            // transformation for the pawn within the map
            echo 'transform="';
            $pawnScale = $m["pixelsPerFoot"]/$standardPawnPixelsPerFoot/$standardPawnSizeFeet;
            // The pawn size before scaling is 570pix x 700pix
            echo 'rotate('. $p["rotate"] .' '. ($p["translateX"] + (285.0 * $p["sizeFeet"] * $pawnScale));
            echo ' '. ($p["translateY"] + (350.0 * $p["sizeFeet"] * $pawnScale)) .') ';
            echo 'translate('. $p["translateX"] .' '. $p["translateY"] .') ';
            echo 'scale('. ($p["sizeFeet"] * $pawnScale) .') ';
            echo '" ';
            echo 'pawnscale="'. $pawnScale .'" ';
            echo 'attacktype="'. $p["attackType"] .'" ';
            echo '>'." \n";
            // svg associated with this Pawn
            // echo $p["pawnShape"];
            $attackScale = 0;
            if ($p["attackRange"]  > 0) {$attackScale = $p["attackRange"]/$p["sizeFeet"];};
            echo '<g id="attackRange" visibility="inherit" transform="translate('. (285 - ($attackScale*502.5)) .' '. (45 - ($attackScale*502.5)) .') scale('. $attackScale .')">' ."\n";
            include "pawn_attackRange.svg";
            echo "</g>\n";
            include 'pawn_defs.svg';
            include "pawn_" . $p["roleName"] . ".svg";
            echo "</g> <!-- close Pawn-->\n";
          }
        }
        echo "</g> <!--close mapg-->\n";
        echo "</svg> <!--close Map-->\n";
      }
    }
    //echo "div test -&gt; scale:".$globalScale." mode ".$mapMode."<br>\n";
    // close div element for display
    // List displays only exist for the DM
    if (strpos($d['name'],"List") && $mapMode == "dm") {
      echo "</div>\n";
    } elseif (($d['name'] == "modifierSelectors") && $mapMode == "dm") {
      echo "</div>\n";
    } elseif ((! strpos($d['name'],"List")) && ($d['name'] != "modifierSelectors")) {
      echo "</div>\n";
    }
  }
}
?>
<?php $conn->close(); ?>
<p id="<?php if (array_key_exists("test",$_GET)) {echo $_GET['test'];} ?>">
</p>
<p id="<?php if (array_key_exists("test",$_GET)) {echo $_GET['test'];} ?>2">
</p>
<script>
var updateTimer = setInterval(updateAll,1000);
//Don't think I want to save automatic
var saveTimer;
var singleUpdate = setTimeout(fillOutPawns,500);
<?php if ($browserAlert) {echo "alert('$browserAlert')";} ?>
</script>
</body>
</html>

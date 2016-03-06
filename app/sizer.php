<!DOCTYPE html>
<html>
<head>
<?php
// Create connection
$conn = db_connect($app->config('db'));
?>
<style type="text/css">
div#main {
	background-color: white;	
	position: fixed;
	border:1px solid #000000;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
}
div#displayIntro {
	position: static;
}
div#displayInfo {
	position: static;
}
div#controls {
	position: fixed;
	background-color: white;	
        padding:2px;
	border:2px solid orange;
	bottom: 0%;
	left: 10%;
	right: 10%;
}
div#controlsList {
  font-size: 75%;
  overflow-y: auto;
}
div#adventureSelect {
	position: fixed;
	background-color: white;	
        padding:2px;
	border:2px solid #00FF00;
	top: 30%;
	right: 50%;
}
th,td {
  padding-right: 10px;
}
div#theGrid {
	position: static;
}
</style>
<script>
var globalScale = 0.348;
var controlsHTML = "<tr><td style=\"text-align:right; font-weight:bold;\">mouse click</td><td>select/deselect a pawn or tile</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">1, 2, or 3</td><td>select/deselect a specific PC pawn</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">q, w, e, r, t, or y</td><td>select/deselect a specific monster pawn</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">mouse dbl-click</td><td>toggle visibility of a pawn or tile</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">v</td><td>toggle visibility of the selected pawn or tile</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">arrow keys</td><td>coarse translate selected pawn or tile</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">Ctrl-left arrow, Ctrl-right arrow</td><td>coarse rotate selected pawn or tile</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">Ctrl-up arrow, Ctrl-right arrow</td><td>coarse scale selected pawn or tile</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">Shift ...</td><td>enable fine control of movement and scale of arrow key based commands</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">mouse click-and-drag</td><td>translate whole pawn grid</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">Ctrl mouse click-and-drag left&amp;right</td><td>rotate whole pawn grid</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">Alt mouse click-and-drag up&amp;down</td><td>scale whole pawn grid</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">Shift ...</td><td>enable fine control of click-and-drag based commands</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">s</td><td>save new position of pawn grid or tile movements to database.  Pawn movements and visibility changes are auto-saved</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">a</td><td>turn selected pawn into a leader of its group such that its movements apply to all in the group</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">l</td><td>toggle indicator of line based attack ranges</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">k</td><td>toggle indicator of conical based attack ranges</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">j</td><td>toggle indicator of spherical based attack ranges</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">h</td><td>toggle selection of height adjustment</td></tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">,</td><td>decrease attack range or height (as selected above) by five feet</td</tr>" +
"<tr><td style=\"text-align:right; font-weight:bold;\">.</td><td>increase attack range or height (as selected above) by five feet</td></tr>" 
function useScale() {
  var inpObj = document.getElementById("globalScaleInp");
  if(inpObj.checkValidity() == false) {
    document.getElementById("globalScaleInvalidP").innerHTML = inpObj.validationMessage;
    globalScale = 1.0;
  } else {
    globalScale = inpObj.value;
    document.getElementById("globalScaleInvalidP").innerHTML = "";
    //document.getElementById("globalScaleInvalidP").innerHTML = globalScale;
    reScale();
  }
}
function mouseOver() {
  if (document.getElementById('controlsTable').innerHTML == "") {
   document.getElementById('controlsTable').innerHTML = controlsHTML;
  }
}
function mouseOut() {
  document.getElementById('controlsTable').innerHTML = "";
}
function reScale() {
  // even with the capability of specifiying units in inches, being able 
  // to get the window size and the pixel ratio.  It is still
  // not possible to set a display to be properly scaled such that
  // a ruler layed on the map would be correct
  //
  // To do this I need some user input.  So I am asu
  var w = window.innerWidth
  || document.documentElement.clientWidth
  || document.body.clientWidth;
  
  var h = window.innerHeight
  || document.documentElement.clientHeight
  || document.body.clientHeight;
  var x = document.getElementById("displayDetail");
  var y = document.getElementById("grid");
  //var globalScale = 96.0*1.075*1.075;
  var myScale = 96.0*globalScale;
  y.setAttribute("width",myScale*10.0);
  y.setAttribute("height",myScale*10.0);
  x.innerHTML = "Browser inner window width: " + w + ", height: " + h + ".<br>" +
     "Map width (dips): " + y.getAttribute("width") + ", height: " + y.getAttribute("height") + ".<br>" +
     "viewBox (set to 50pix/in): " + y.getAttribute("viewBox") + ".<br>" +
     "Pixel Ratio (physical pixels/dips): " + window.devicePixelRatio + ".<br>" +
     "96 * " + globalScale + " = " + myScale + " dips / inch.<br>";
  document.getElementById("globalScaleInp").setAttribute("value",globalScale);
  var adventures = document.getElementsByClassName("adventureLink");
  for(index = 0; index < adventures.length; index++) {
    aId = adventures[index].id.slice(6);
    mode = adventures[index].id.substr(0,2);
    //adventures[index].setAttribute("href","adventure.php?id=" + aId + "&mode=pc&scale=" + globalScale);
    adventures[index].setAttribute("href","map/" + mode + "/" + aId + "/?scale=" + globalScale);
  }
}
</script>
<meta charset="utf-8"></meta>
<title>Configure Display Scale</title>
</head>
<body>
<!-- the division is where I should define the display -->
<div id="main">
<div id="displayIntro">
<h2>DragonberryPi</h2>
<h3>pawn grid sizer</h3>
<p id="globalScaleP">
The box below should be 10 inches x 10 inches with 1 inch squares.<br>
Enter a global scale factor so this is the case on your display.
</p>
<p id="globalScaleInvalidP"></p>
<input id="globalScaleInp" type="number" name="globalScale" 
       min="0.1" max=10.0" step="0.001" onchange="useScale()">
</div>
<div id="adventureSelect">
<?php 
$adventures = $conn->query("SELECT * FROM Adventure ORDER BY idAdventure");
if ($adventures->num_rows > 0) {
  echo "<table style=\"text-align:center\">\n";
  echo "<tr>\n";
  echo '<th>id</th>';
  echo '<th>PC mode</th>';
  echo '<th>DM mode</th>';
  echo "</tr>\n";
  while($a = $adventures->fetch_assoc()) {
    echo "<tr>\n";
    echo '<td>'.$a["idAdventure"].'</td>';
    echo '<td><a id="pclink'.$a["idAdventure"].'" class="adventureLink">'.$a["name"].'</a></td>';
    echo '<td><a id="dmlink'.$a["idAdventure"].'" class="adventureLink" target="_blank">'.$a["name"].'</a></td>';
    echo "</tr>\n";
  }
  echo "</table>\n";
}
$conn->close();
?>
</div>
<div id="controls" onmouseover="mouseOver()" onmouseout="mouseOut()">
<p>Choose an adventure in the green box.  The DM mode will have the full controls and visibility, whereas the PC mode will have controls for the PCs only and visibility only for those parts which the DM allows.  Mouse over this box to see the full controls</p>
<div id="controlsList">
<table id="controlsTable"></table>
</div>
</div>
<div id="theGrid">
<svg id="grid" 
     width="10in" height="10in" viewBox="0 0 500 500" preserveAspectRatio="xMinYMin slice"
     style="border:1px solid #FF0000" 
     xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
>
<?php
for ($x = 0;$x < 500; $x+=50){
  for ($y = 0;$y < 500; $y+=50){
    echo '<rect id="',$x,',',$y,'" x="',$x,'" y="',$y,'" width="50" height="50"',"\n";
    echo 'style="fill:none;stroke-width:1;stroke:rgb(0,0,0)"/>',"\n";
  }
}
?>
</svg>
</div>
<div id="displayIntro">
<p id="displayDetail"></p>
</div>
</div>
<script>
reScale()
</script>
</table>
</body>
</html>

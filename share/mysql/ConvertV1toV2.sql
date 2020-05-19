# This is used to convert from Version 1 DragonberryPi to Version 2
SET @olddb = 'DragonberryPiv1', @newdb = 'DragonberryPi';

SET @oldcols = 'idSource,name,description,copyright,updated,updatedBy', 
    @newcols = 'idSource,name,description,copyright,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.Source (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Source;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @oldcols = 'idLocation,name,depth,idParent,updated,updatedBy', 
    @newcols = 'idLocation,name,depth,idParent,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.Location (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Location;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @oldcols = 'idImage,idLocation,filename,type,width,height,ruleLink,idSource,updated,updatedBy', 
    @newcols = 'idImage,idLocation,filename,type,width,height,ruleLink,idSource,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.Image (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Image;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @oldcols = 'idDisplay,`name`,position,width,height,top,bottom,`left`,`right`,transform,backgroundColor,depth,updated,updatedBy',
    @newcols = 'idDisplay,`name`,position,width,height,top,bottom,`left`,`right`,transform,backgroundColor,depth,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.Display (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Display;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
#INSERT INTO DragonberryPi.Display (idDisplay,`name`,position,width,height,top,bottom,`left`,`right`,transform,backgroundColor,depth,updated,updatedBy) SELECT idDisplay,`name`,position,width,height,top,bottom,`left`,`right`,transform,backgroundColor,depth,updated,updatedBy FROM DragonberryPiv1.Display;

SET @oldcols = 'idModifier,name,shapeSvg,updated,updatedBy',
    @newcols = 'idModifier,name,shapeSvg,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.Modifier (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Modifier;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @oldcols = 'idAdventure,name,description,updated,updatedBy',
    @newcols = 'idAdventure,name,description,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.Adventure (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Adventure;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @oldcols = 'idMapType,name,description,updated,updatedBy',
    @newcols = 'idMapType,name,description,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.MapType (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.MapType;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

# The idAdventure for the new Map table needs to come from the join of Map and Adventure Map from the old database
SET @oldcols = 'Map.idMap,name,pixelsPerFoot,feetPerInch,widthInches,heightInches,rotate,scale,scaleY,translateX,translateY,visible,dmVisible,showName,dmShowName,depth,backgroundColor,idAdventure,idMapType,idDisplay,Map.updated,Map.updatedBy',
    @newcols = 'idMap,name,pixelsPerFoot,feetPerInch,widthInches,heightInches,rotate,scale,scaleY,translateX,translateY,visible,dmVisible,showName,dmShowName,depth,backgroundColor,idAdventure,idMapType,idDisplay,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.Map (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Map,',@olddb,'.AdventureMap WHERE Map.idMap = AdventureMap.idMap');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @oldcols = 'idTile,name,rotate,scale,translateX,translateY,visible,dmVisible,depth,backgroundColor,ruleLink,idImage,idMap,updated,updatedBy',
    @newcols = 'idTile,name,rotate,scale,translateX,translateY,visible,dmVisible,depth,backgroundColor,ruleLink,idImage,idMap,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.Tile (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Tile;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @oldcols = 'idRole,name,updated,updatedBy',
    @newcols = 'idRole,name,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.Role (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Role;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

# To fill the PawnMask table for starting, I need to create a PawnMask entries from the Role table
# I am using the same convention as used in the old adventure.php code to find the SVF file
SET @oldcols = 'CONCAT("pawn_",SUBSTR(`name`,1,LOCATE(" ",CONCAT(`name`,SPACE(1)))-1)),SUBSTR(`name`,1,LOCATE(" ",CONCAT(`name`,SPACE(1)))-1),updated,updatedBy',
    @newcols = '`name`,description,updated,updatedBy';
SET @q = CONCAT('INSERT IGNORE INTO ', @newdb, '.PawnMask (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Role;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

# Since I did not have a PawnMask table before I need to add the svn data here:
# PC
SET @q = CONCAT('UPDATE ',@newdb,'.PawnMask SET shapeSvg = \'',
'<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="570"
   height="700"
   viewBox="0 0 570 700"
   id="pawns"
   version="1.1"
   inkscape:version="0.91 r13725"
   sodipodi:docname="pawns.svg"
   enable-background="new">
  <defs
     id="defsPawnsClipPath">
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath5421">
      <circle
         cy="802.36218"
         cx="250"
         id="circle5423"
         style="opacity:1;fill:none;fill-opacity:0.60264905;stroke:#000000;stroke-width:1;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
         r="250" />
    </clipPath>
  </defs>
  <metadata
     id="metadata4171">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     inkscape:groupmode="layer"
     id="background"
     inkscape:label="background"
     style="display:inline"
     sodipodi:insensitive="true">
    <circle
       style="display:inline;fill:#ff00ff;fill-opacity:1;fill-rule:evenodd;stroke:none"
       id="path3046"
       cx="285"
       cy="350"
       r="210" />
  </g>
  <g
     inkscape:label="roundImage"
     inkscape:groupmode="layer"
     id="roundImage"
     transform="translate(35.101634,-452.36219)"
     style="display:inline"
     sodipodi:insensitive="true">
    <image
       sodipodi:absref="/home/pi/DragonberryPi/app/public/images/blank.png"
       y="552.36218"
       x="-0.101634"
       id="imageRoundImage"
       xlink:href="/images/blank.png"
       preserveAspectRatio="none"
       height="500"
       width="500"
       clip-path="url(#clipPath5421)"
       style="fill:none;stroke:none"
       transform="matrix(1.0002033,0,0,1,-0.101634,0)" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringColor"
     inkscape:label="ringColor"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 426.67506,73.223332 a 250,250 0 0 0 -353.55339,0 250,250 0 0 0 0,353.553388 250,250 0 0 0 353.55339,0 250,250 0 0 0 0,-353.553388 z M 397.68368,101.5076 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98484,0 210,210 0 0 1 0,-296.98485 210,210 0 0 1 296.98484,0 z"
       id="pathRingColor"
       inkscape:connector-curvature="0" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringShading"
     inkscape:label="ringShading"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       inkscape:connector-curvature="0"
       style="fill:url(#radialGradient7227);fill-opacity:1;stroke:none"
       d="m 426.67511,73.223276 a 250,250 0 0 0 -353.553384,0 250,250 0 0 0 -5.7e-5,353.553444 250,250 0 0 0 353.553441,-6e-5 250,250 0 0 0 0,-353.553384 z m -28.99137,28.284264 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98491,6e-5 210,210 0 0 1 6e-5,-296.98491 210,210 0 0 1 296.98485,0 z"
       id="pathRingShading" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="arrowColor"
     inkscape:label="arrowColor"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 235.26454,-88.65423 -268.700582,268.70058 0.0055,0.006 a 20,10 45 0 0 0.824495,12.97514 20,10 45 0 0 14.153185,14.29681 20,10 45 0 0 13.3010661,1.0068 L 263.54881,-60.369959 235.26454,-88.65423 Z"
       id="pathArrowColor-1"
       inkscape:connector-curvature="0" />
    <path
       inkscape:connector-curvature="0"
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 235.26457,-60.369996 268.70058,268.700576 0.006,-0.006 a 10,20 45 0 0 12.97514,-0.8245 10,20 45 0 0 14.29681,-14.15318 10,20 45 0 0 1.00681,-13.30108 L 263.54884,-88.654267 235.26457,-60.369996 Z"
       id="pathArrowColor-2" />
    <circle
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       id="pathArrowColor-3"
       cx="128.17694"
       cy="-224.53735"
       r="24.507805"
       transform="matrix(0.70710678,0.70710678,-0.70710678,0.70710678,0,0)" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="arrowShading"
     inkscape:label="arrowShading"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <circle
       style="fill:url(#radialGradient7371);fill-opacity:1;stroke:none"
       id="pathArrowShading-1"
       cx="128.26566"
       cy="-224.44861"
       r="24.596193"
       transform="matrix(0.70710678,0.70710678,-0.70710678,0.70710678,0,0)" />
    <path
       inkscape:connector-curvature="0"
       style="fill:url(#radialGradient7462);fill-opacity:1;stroke:none"
       d="m -33.430542,180.05235 a 20,10 45 0 0 0.824495,12.97514 20,10 45 0 0 14.153185,14.29681 20,10 45 0 0 13.3010629,1.0068 L -33.430542,180.05235 Z"
       id="pathArrowShading-2" />
    <path
       style="fill:url(#linearGradient7442);fill-opacity:1;stroke:none"
       d="m 235.26451,-88.653761 -3.24966,3.249653 a 24.596193,24.596193 0 0 1 1.86997,-1.684903 20,20 0 0 1 1.37969,-1.56475 z m -3.24966,3.249653 L -33.436067,180.04683 -5.1517991,208.3311 246.7467,-43.567417 a 24.596193,24.596193 0 0 1 -14.73323,-7.051734 24.596193,24.596193 0 0 1 10e-4,-34.784957 z"
       id="pathArrowShading-3"
       inkscape:connector-curvature="0" />
    <path
       style="fill:url(#radialGradient7462-1);fill-opacity:1;stroke:none"
       d="m 532.24383,180.05235 a 10,20 45 0 1 -0.8245,12.97514 10,20 45 0 1 -14.15318,14.29681 10,20 45 0 1 -13.30107,1.0068 l 28.27875,-28.27875 z"
       id="pathArrowShading-4"
       inkscape:connector-curvature="0" />
    <path
       style="fill:url(#linearGradient7530);fill-opacity:1;stroke:none"
       d="m 263.54878,-88.653761 a 20,20 0 0 1 1.44183,1.646233 24.596193,24.596193 0 0 1 1.80782,1.60342 l -3.24965,-3.249653 z m 3.24965,3.249653 a 24.596193,24.596193 0 0 1 10e-4,34.784957 24.596193,24.596193 0 0 1 -14.74566,7.039304 L 503.96508,208.3311 532.24935,180.04683 266.79843,-85.404108 Z"
       id="pathArrowShading-5"
       inkscape:connector-curvature="0" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="modifiers"
     inkscape:label="modifiers">
  </g>
  <g
     inkscape:groupmode="layer"
     id="heightIndicator"
     inkscape:label="heightIndicator"
     style="display:inline"
     sodipodi:insensitive="true">
    <g
       id="height"
       transform="matrix(1.44,0,0,1.44,-236.90908,-280.32315)"
       style="opacity:1">
      <title
         id="title4706">height</title>
      <text
         inkscape:transform-center-y="-96.226167"
         inkscape:transform-center-x="15.193596"
         sodipodi:linespacing="125%"
         id="textHeight"
         y="676.94495"
         x="331.96698"
         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:121.52777863px;line-height:125%;font-family:sans-serif;-inkscape-font-specification:\\\'sans-serif, Bold\\\';text-align:start;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:start;fill:#000000;fill-opacity:1;stroke:#ffff00;stroke-width:3.47222233;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
         xml:space="preserve"><tspan
           y="676.94495"
           x="331.96698"
           id="tspanHeight"
           sodipodi:role="line"></tspan></text>
    </g>
  </g>
</svg>',
'\' WHERE `name` = "pawn_pc"'); 
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

#NPC
SET @q = CONCAT('UPDATE ',@newdb,'.PawnMask SET shapeSvg = \'',
'<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="570"
   height="700"
   viewBox="0 0 570 700"
   id="pawns"
   version="1.1"
   inkscape:version="0.91 r13725"
   sodipodi:docname="pawns.svg"
   enable-background="new">
  <defs
     id="defsPawnsClipPath">
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath5421">
      <circle
         cy="802.36218"
         cx="250"
         id="circle5423"
         style="opacity:1;fill:none;fill-opacity:0.60264905;stroke:#000000;stroke-width:1;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
         r="250" />
    </clipPath>
  </defs>
  <metadata
     id="metadata4171">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     inkscape:groupmode="layer"
     id="background"
     inkscape:label="background"
     style="display:inline"
     sodipodi:insensitive="true">
    <circle
       style="display:inline;fill:#ff00ff;fill-opacity:1;fill-rule:evenodd;stroke:none"
       id="path3046"
       cx="285"
       cy="350"
       r="210" />
  </g>
  <g
     inkscape:label="roundImage"
     inkscape:groupmode="layer"
     id="roundImage"
     transform="translate(35.101634,-452.36219)"
     style="display:inline"
     sodipodi:insensitive="true">
    <image
       sodipodi:absref="/home/pi/DragonberryPi/app/public/images/blank.png"
       y="552.36218"
       x="-0.101634"
       id="imageRoundImage"
       xlink:href="/images/blank.png"
       preserveAspectRatio="none"
       height="500"
       width="500"
       clip-path="url(#clipPath5421)"
       style="fill:none;stroke:none"
       transform="matrix(1.0002033,0,0,1,-0.101634,0)" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringColor"
     inkscape:label="ringColor"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 426.67506,73.223332 a 250,250 0 0 0 -353.55339,0 250,250 0 0 0 0,353.553388 250,250 0 0 0 353.55339,0 250,250 0 0 0 0,-353.553388 z M 397.68368,101.5076 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98484,0 210,210 0 0 1 0,-296.98485 210,210 0 0 1 296.98484,0 z"
       id="pathRingColor"
       inkscape:connector-curvature="0" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringShading"
     inkscape:label="ringShading"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       inkscape:connector-curvature="0"
       style="fill:url(#radialGradient7227);fill-opacity:1;stroke:none"
       d="m 426.67511,73.223276 a 250,250 0 0 0 -353.553384,0 250,250 0 0 0 -5.7e-5,353.553444 250,250 0 0 0 353.553441,-6e-5 250,250 0 0 0 0,-353.553384 z m -28.99137,28.284264 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98491,6e-5 210,210 0 0 1 6e-5,-296.98491 210,210 0 0 1 296.98485,0 z"
       id="pathRingShading" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="arrowColor"
     inkscape:label="arrowColor"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 235.26454,-88.65423 -268.700582,268.70058 0.0055,0.006 a 20,10 45 0 0 0.824495,12.97514 20,10 45 0 0 14.153185,14.29681 20,10 45 0 0 13.3010661,1.0068 L 263.54881,-60.369959 235.26454,-88.65423 Z"
       id="pathArrowColor-1"
       inkscape:connector-curvature="0" />
    <path
       inkscape:connector-curvature="0"
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 235.26457,-60.369996 268.70058,268.700576 0.006,-0.006 a 10,20 45 0 0 12.97514,-0.8245 10,20 45 0 0 14.29681,-14.15318 10,20 45 0 0 1.00681,-13.30108 L 263.54884,-88.654267 235.26457,-60.369996 Z"
       id="pathArrowColor-2" />
    <circle
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       id="pathArrowColor-3"
       cx="128.17694"
       cy="-224.53735"
       r="24.507805"
       transform="matrix(0.70710678,0.70710678,-0.70710678,0.70710678,0,0)" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="arrowShading"
     inkscape:label="arrowShading"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <circle
       style="fill:url(#radialGradient7371);fill-opacity:1;stroke:none"
       id="pathArrowShading-1"
       cx="128.26566"
       cy="-224.44861"
       r="24.596193"
       transform="matrix(0.70710678,0.70710678,-0.70710678,0.70710678,0,0)" />
    <path
       inkscape:connector-curvature="0"
       style="fill:url(#radialGradient7462);fill-opacity:1;stroke:none"
       d="m -33.430542,180.05235 a 20,10 45 0 0 0.824495,12.97514 20,10 45 0 0 14.153185,14.29681 20,10 45 0 0 13.3010629,1.0068 L -33.430542,180.05235 Z"
       id="pathArrowShading-2" />
    <path
       style="fill:url(#linearGradient7442);fill-opacity:1;stroke:none"
       d="m 235.26451,-88.653761 -3.24966,3.249653 a 24.596193,24.596193 0 0 1 1.86997,-1.684903 20,20 0 0 1 1.37969,-1.56475 z m -3.24966,3.249653 L -33.436067,180.04683 -5.1517991,208.3311 246.7467,-43.567417 a 24.596193,24.596193 0 0 1 -14.73323,-7.051734 24.596193,24.596193 0 0 1 10e-4,-34.784957 z"
       id="pathArrowShading-3"
       inkscape:connector-curvature="0" />
    <path
       style="fill:url(#radialGradient7462-1);fill-opacity:1;stroke:none"
       d="m 532.24383,180.05235 a 10,20 45 0 1 -0.8245,12.97514 10,20 45 0 1 -14.15318,14.29681 10,20 45 0 1 -13.30107,1.0068 l 28.27875,-28.27875 z"
       id="pathArrowShading-4"
       inkscape:connector-curvature="0" />
    <path
       style="fill:url(#linearGradient7530);fill-opacity:1;stroke:none"
       d="m 263.54878,-88.653761 a 20,20 0 0 1 1.44183,1.646233 24.596193,24.596193 0 0 1 1.80782,1.60342 l -3.24965,-3.249653 z m 3.24965,3.249653 a 24.596193,24.596193 0 0 1 10e-4,34.784957 24.596193,24.596193 0 0 1 -14.74566,7.039304 L 503.96508,208.3311 532.24935,180.04683 266.79843,-85.404108 Z"
       id="pathArrowShading-5"
       inkscape:connector-curvature="0" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="modifiers"
     inkscape:label="modifiers">
  </g>
  <g
     inkscape:groupmode="layer"
     id="heightIndicator"
     inkscape:label="heightIndicator"
     style="display:inline"
     sodipodi:insensitive="true">
    <g
       id="height"
       transform="matrix(1.44,0,0,1.44,-236.90908,-280.32315)"
       style="opacity:1">
      <title
         id="title4706">height</title>
      <text
         inkscape:transform-center-y="-96.226167"
         inkscape:transform-center-x="15.193596"
         sodipodi:linespacing="125%"
         id="textHeight"
         y="676.94495"
         x="331.96698"
         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:121.52777863px;line-height:125%;font-family:sans-serif;-inkscape-font-specification:\\\'sans-serif, Bold\\\';text-align:start;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:start;fill:#000000;fill-opacity:1;stroke:#ffff00;stroke-width:3.47222233;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
         xml:space="preserve"><tspan
           y="676.94495"
           x="331.96698"
           id="tspanHeight"
           sodipodi:role="line"></tspan></text>
    </g>
  </g>
</svg>
',
'\' WHERE `name` = "pawn_npc"'); 
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

#MONSTER
SET @q = CONCAT('UPDATE ',@newdb,'.PawnMask SET shapeSvg = \'',
'<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="570"
   height="700"
   viewBox="0 0 570 700"
   id="pawns"
   version="1.1"
   inkscape:version="0.91 r13725"
   sodipodi:docname="pawns.svg"
   enable-background="new">
  <defs
     id="defsPawnsClipPath">
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath5421">
      <circle
         cy="802.36218"
         cx="250"
         id="circle5423"
         style="opacity:1;fill:none;fill-opacity:0.60264905;stroke:#000000;stroke-width:1;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
         r="250" />
    </clipPath>
  </defs>
  <metadata
     id="metadata4171">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     inkscape:groupmode="layer"
     id="background"
     inkscape:label="background"
     style="display:inline"
     sodipodi:insensitive="true">
    <circle
       style="display:inline;fill:#ff00ff;fill-opacity:1;fill-rule:evenodd;stroke:none"
       id="path3046"
       cx="285"
       cy="350"
       r="210" />
  </g>
  <g
     inkscape:label="roundImage"
     inkscape:groupmode="layer"
     id="roundImage"
     transform="translate(35.101634,-452.36219)"
     style="display:inline"
     sodipodi:insensitive="true">
    <image
       sodipodi:absref="/home/pi/DragonberryPi/app/public/images/blank.png"
       y="552.36218"
       x="-0.101634"
       id="imageRoundImage"
       xlink:href="/images/blank.png"
       preserveAspectRatio="none"
       height="500"
       width="500"
       clip-path="url(#clipPath5421)"
       style="fill:none;stroke:none"
       transform="matrix(1.0002033,0,0,1,-0.101634,0)" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringColor"
     inkscape:label="ringColor"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 426.67506,73.223332 a 250,250 0 0 0 -353.55339,0 250,250 0 0 0 0,353.553388 250,250 0 0 0 353.55339,0 250,250 0 0 0 0,-353.553388 z M 397.68368,101.5076 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98484,0 210,210 0 0 1 0,-296.98485 210,210 0 0 1 296.98484,0 z"
       id="pathRingColor"
       inkscape:connector-curvature="0" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringShading"
     inkscape:label="ringShading"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       inkscape:connector-curvature="0"
       style="fill:url(#radialGradient7227);fill-opacity:1;stroke:none"
       d="m 426.67511,73.223276 a 250,250 0 0 0 -353.553384,0 250,250 0 0 0 -5.7e-5,353.553444 250,250 0 0 0 353.553441,-6e-5 250,250 0 0 0 0,-353.553384 z m -28.99137,28.284264 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98491,6e-5 210,210 0 0 1 6e-5,-296.98491 210,210 0 0 1 296.98485,0 z"
       id="pathRingShading" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="arrowColor"
     inkscape:label="arrowColor"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 235.26454,-88.65423 -268.700582,268.70058 0.0055,0.006 a 20,10 45 0 0 0.824495,12.97514 20,10 45 0 0 14.153185,14.29681 20,10 45 0 0 13.3010661,1.0068 L 263.54881,-60.369959 235.26454,-88.65423 Z"
       id="pathArrowColor-1"
       inkscape:connector-curvature="0" />
    <path
       inkscape:connector-curvature="0"
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 235.26457,-60.369996 268.70058,268.700576 0.006,-0.006 a 10,20 45 0 0 12.97514,-0.8245 10,20 45 0 0 14.29681,-14.15318 10,20 45 0 0 1.00681,-13.30108 L 263.54884,-88.654267 235.26457,-60.369996 Z"
       id="pathArrowColor-2" />
    <circle
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       id="pathArrowColor-3"
       cx="128.17694"
       cy="-224.53735"
       r="24.507805"
       transform="matrix(0.70710678,0.70710678,-0.70710678,0.70710678,0,0)" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="arrowShading"
     inkscape:label="arrowShading"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <circle
       style="fill:url(#radialGradient7371);fill-opacity:1;stroke:none"
       id="pathArrowShading-1"
       cx="128.26566"
       cy="-224.44861"
       r="24.596193"
       transform="matrix(0.70710678,0.70710678,-0.70710678,0.70710678,0,0)" />
    <path
       inkscape:connector-curvature="0"
       style="fill:url(#radialGradient7462);fill-opacity:1;stroke:none"
       d="m -33.430542,180.05235 a 20,10 45 0 0 0.824495,12.97514 20,10 45 0 0 14.153185,14.29681 20,10 45 0 0 13.3010629,1.0068 L -33.430542,180.05235 Z"
       id="pathArrowShading-2" />
    <path
       style="fill:url(#linearGradient7442);fill-opacity:1;stroke:none"
       d="m 235.26451,-88.653761 -3.24966,3.249653 a 24.596193,24.596193 0 0 1 1.86997,-1.684903 20,20 0 0 1 1.37969,-1.56475 z m -3.24966,3.249653 L -33.436067,180.04683 -5.1517991,208.3311 246.7467,-43.567417 a 24.596193,24.596193 0 0 1 -14.73323,-7.051734 24.596193,24.596193 0 0 1 10e-4,-34.784957 z"
       id="pathArrowShading-3"
       inkscape:connector-curvature="0" />
    <path
       style="fill:url(#radialGradient7462-1);fill-opacity:1;stroke:none"
       d="m 532.24383,180.05235 a 10,20 45 0 1 -0.8245,12.97514 10,20 45 0 1 -14.15318,14.29681 10,20 45 0 1 -13.30107,1.0068 l 28.27875,-28.27875 z"
       id="pathArrowShading-4"
       inkscape:connector-curvature="0" />
    <path
       style="fill:url(#linearGradient7530);fill-opacity:1;stroke:none"
       d="m 263.54878,-88.653761 a 20,20 0 0 1 1.44183,1.646233 24.596193,24.596193 0 0 1 1.80782,1.60342 l -3.24965,-3.249653 z m 3.24965,3.249653 a 24.596193,24.596193 0 0 1 10e-4,34.784957 24.596193,24.596193 0 0 1 -14.74566,7.039304 L 503.96508,208.3311 532.24935,180.04683 266.79843,-85.404108 Z"
       id="pathArrowShading-5"
       inkscape:connector-curvature="0" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="modifiers"
     inkscape:label="modifiers">
  </g>
  <g
     inkscape:groupmode="layer"
     id="heightIndicator"
     inkscape:label="heightIndicator"
     style="display:inline"
     sodipodi:insensitive="true">
    <g
       id="height"
       transform="matrix(1.44,0,0,1.44,-236.90908,-280.32315)"
       style="opacity:1">
      <title
         id="title4706">height</title>
      <text
         inkscape:transform-center-y="-96.226167"
         inkscape:transform-center-x="15.193596"
         sodipodi:linespacing="125%"
         id="textHeight"
         y="676.94495"
         x="331.96698"
         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:121.52777863px;line-height:125%;font-family:sans-serif;-inkscape-font-specification:\\\'sans-serif, Bold\\\';text-align:start;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:start;fill:#000000;fill-opacity:1;stroke:#ffff00;stroke-width:3.47222233;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
         xml:space="preserve"><tspan
           y="676.94495"
           x="331.96698"
           id="tspanHeight"
           sodipodi:role="line"></tspan></text>
    </g>
  </g>
</svg>
',
'\' WHERE `name` = "pawn_monster"'); 
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

#LABEL
SET @q = CONCAT('UPDATE ',@newdb,'.PawnMask SET shapeSvg = \'',
'<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="570"
   height="700"
   viewBox="0 0 570 700"
   id="pawns"
   version="1.1"
   inkscape:version="0.91 r13725"
   sodipodi:docname="pawns.svg"
   enable-background="new">
  <defs
     id="defsPawnsClipPath">
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath5421">
      <circle
         cy="802.36218"
         cx="250"
         id="circle5423"
         style="opacity:1;fill:none;fill-opacity:0.60264905;stroke:#000000;stroke-width:1;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
         r="250" />
    </clipPath>
  </defs>
  <metadata
     id="metadata4171">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     inkscape:groupmode="layer"
     id="background"
     inkscape:label="background"
     style="display:inline"
     sodipodi:insensitive="true">
    <circle
       transform="translate(4.6484375e-7,4.6582031e-6)"
       style="display:inline;fill:#ff00ff;fill-opacity:1;fill-rule:evenodd;stroke:none"
       id="path3046"
       cx="285"
       cy="350"
       r="210" />
  </g>
  <g
     inkscape:label="roundImage"
     inkscape:groupmode="layer"
     id="roundImage"
     transform="translate(35.101634,-452.36219)"
     style="display:inline"
     sodipodi:insensitive="true">
    <image
       sodipodi:absref="/home/pi/DragonberryPi/app/public/images/blank.png"
       y="552.36218"
       x="-0.101634"
       id="imageRoundImage"
       xlink:href="/images/blank.png"
       preserveAspectRatio="none"
       height="500"
       width="500"
       clip-path="url(#clipPath5421)"
       style="fill:none;stroke:none"
       transform="matrix(1.0002033,0,0,1,-0.101634,0)" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringColor"
     inkscape:label="ringColor"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 426.67506,73.223332 a 250,250 0 0 0 -353.55339,0 250,250 0 0 0 0,353.553388 250,250 0 0 0 353.55339,0 250,250 0 0 0 0,-353.553388 z M 397.68368,101.5076 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98484,0 210,210 0 0 1 0,-296.98485 210,210 0 0 1 296.98484,0 z"
       id="pathRingColor"
       inkscape:connector-curvature="0" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringShading"
     inkscape:label="ringShading"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       inkscape:connector-curvature="0"
       style="fill:url(#radialGradient7227);fill-opacity:1;stroke:none"
       d="m 426.67511,73.223276 a 250,250 0 0 0 -353.553384,0 250,250 0 0 0 -5.7e-5,353.553444 250,250 0 0 0 353.553441,-6e-5 250,250 0 0 0 0,-353.553384 z m -28.99137,28.284264 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98491,6e-5 210,210 0 0 1 6e-5,-296.98491 210,210 0 0 1 296.98485,0 z"
       id="pathRingShading" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="modifiers"
     inkscape:label="modifiers">
  </g>
  <g
     inkscape:groupmode="layer"
     id="heightIndicator"
     inkscape:label="heightIndicator"
     style="display:inline"
     sodipodi:insensitive="true">
    <g
       id="height"
       transform="matrix(1.44,0,0,1.44,-236.90908,-280.32315)"
       style="opacity:1">
      <title
         id="title4706">height</title>
      <text
         inkscape:transform-center-y="-96.226167"
         inkscape:transform-center-x="15.193596"
         sodipodi:linespacing="125%"
         id="textHeight"
         y="676.94495"
         x="331.96698"
         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:121.52777863px;line-height:125%;font-family:sans-serif;-inkscape-font-specification:\\\'sans-serif, Bold\\\';text-align:start;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:start;fill:#000000;fill-opacity:1;stroke:#ffff00;stroke-width:3.47222233;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
         xml:space="preserve"><tspan
           y="676.94495"
           x="331.96698"
           id="tspanHeight"
           sodipodi:role="line"></tspan></text>
    </g>
  </g>
</svg>
',
'\' WHERE `name` = "pawn_label"'); 
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

#TRAP
SET @q = CONCAT('UPDATE ',@newdb,'.PawnMask SET shapeSvg = \'',
'<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="570"
   height="700"
   viewBox="0 0 570 700"
   id="pawns"
   version="1.1"
   inkscape:version="0.91 r13725"
   sodipodi:docname="pawns.svg"
   enable-background="new">
  <defs
     id="defsPawnsClipPath">
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath5421">
      <circle
         cy="802.36218"
         cx="250"
         id="circle5423"
         style="opacity:1;fill:none;fill-opacity:0.60264905;stroke:#000000;stroke-width:1;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
         r="250" />
    </clipPath>
  </defs>
  <metadata
     id="metadata4171">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
        <dc:title />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     inkscape:groupmode="layer"
     id="background"
     inkscape:label="background"
     style="display:inline"
     sodipodi:insensitive="true">
    <circle
       style="display:inline;fill:#ff00ff;fill-opacity:1;fill-rule:evenodd;stroke:none"
       id="path3046"
       cx="285"
       cy="350"
       r="210" />
  </g>
  <g
     inkscape:label="roundImage"
     inkscape:groupmode="layer"
     id="roundImage"
     transform="translate(35.101634,-452.36219)"
     style="display:inline"
     sodipodi:insensitive="true">
    <image
       sodipodi:absref="/home/pi/DragonberryPi/app/public/images/blank.png"
       y="552.36218"
       x="-0.101634"
       id="imageRoundImage"
       xlink:href="http://localhost/images/blank.png"
       preserveAspectRatio="none"
       height="500"
       width="500"
       clip-path="url(#clipPath5421)"
       style="fill:none;stroke:none"
       transform="matrix(1.0002033,0,0,1,-0.101634,0)" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringColor"
     inkscape:label="ringColor"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       style="fill:#00ffff;fill-opacity:1;stroke:none"
       d="m 426.67506,73.223332 a 250,250 0 0 0 -353.55339,0 250,250 0 0 0 0,353.553388 250,250 0 0 0 353.55339,0 250,250 0 0 0 0,-353.553388 z M 397.68368,101.5076 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98484,0 210,210 0 0 1 0,-296.98485 210,210 0 0 1 296.98484,0 z"
       id="pathRingColor"
       inkscape:connector-curvature="0" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringSketchOutline"
     inkscape:label="ringSketchOutline"
     style="display:inline"
     sodipodi:insensitive="true">
    <path
       style="display:inline;fill:none;stroke:#000000;stroke-opacity:1"
       d="M 459.62992,176.21137 C 441.3349,156.82052 417.94887,142.12819 392.66873,130.97522 m 16.08316,-1.29437 c -21.32442,-12.20651 -43.06086,-20.60457 -65.26564,-25.53004 m 8.4495,9.68591 c -24.95049,-7.55082 -49.03111,-11.63624 -73.25393,-12.84495 m 22.26848,3.18651 c -30.28379,-0.78846 -62.84192,3.00226 -91.98414,14.0464 m 17.99188,-16.0674 c -28.51917,5.2996 -52.82147,15.8717 -73.51373,29.70995 m 18.2961,-4.04716 c -23.64464,12.21621 -43.06958,25.24918 -58.97766,39.87557 m 5.79451,-7.8527 c -5.4991,4.48309 -10.65161,9.1634 -15.46998,14.02802 -12.484104,12.60395 -22.685868,26.40543 -30.855573,41.14822 m 14.335365,-17.74105 c -13.473189,18.63146 -25.605915,40.3214 -35.402364,64.16991 m 4.542789,-12.53524 c -11.599134,28.7825 -19.815145,57.37194 -22.174313,85.79455 m 5.684267,-26.50837 c -5.098393,31.46068 -2.571879,62.0889 6.000821,93.81726 m -8.975204,-23.45846 c 4.535954,27.67841 11.343128,53.79967 22.843505,78.13379 M 46.162186,433.044 c 12.143712,28.90835 26.599435,53.44162 46.076223,74.2443 M 75.903361,496.08747 c 8.260778,10.83927 17.152466,21.4467 26.846529,31.80628 10.74129,11.47869 22.41199,22.59345 35.2211,33.33812 m -12.83374,-19.99332 c 17.94632,16.89834 38.70617,30.61358 60.12275,42.71478 m -12.37904,-12.87917 c 23.76428,11.10242 48.1656,19.49063 72.63063,23.55215 m -17.72421,-0.70563 c 29.3797,7.6456 61.79453,9.01983 94.4653,6.23925 m -25.61422,0.86371 c 33.11494,-0.71587 64.53495,-11.1261 94.13004,-28.90807 m -28.00928,11.53808 c 31.25888,-9.48493 60.48587,-24.76298 86.54563,-42.69 m -25.19043,10.90755 c 13.2309,-8.75518 25.9416,-19.07833 38.03378,-30.73511 8.79307,-8.47646 17.2327,-17.63245 25.2944,-27.37174 m -24.7005,24.85142 c 21.08583,-23.1774 37.68249,-49.10598 51.61207,-78.25354 m -9.14749,22.82436 c 14.58026,-28.60119 22.65342,-59.97817 24.86384,-93.48362 m -0.32668,27.62363 c 5.3789,-33.79425 7.07059,-64.54295 2.40258,-95.20517 m 0.97077,30.01384 c -2.52943,-32.13666 -11.14725,-65.08498 -25.19921,-98.80035 m 4.62367,32.29691 C 500.40429,234.07902 484.22478,205.77749 463.16452,181.26751 M 451.70139,159.39059 C 430.6121,140.3063 404.13006,124.97131 375.63917,117.38231 m 25.70093,12.5264 c -21.50376,-11.14307 -44.27846,-18.76642 -68.29964,-22.68296 m 17.94766,6.26471 c -27.8087,-8.42946 -57.12652,-10.51637 -85.59818,-8.12518 m 20.0684,-0.28414 c -25.95587,0.3963 -50.78319,3.6193 -75.2654,10.33788 m 15.45647,-2.75621 c -27.3887,6.94186 -52.5621,15.93128 -74.58886,27.71501 m 12.55308,-17.34297 c -23.12106,10.93683 -43.12257,27.17986 -60.20351,46.72869 -5.136323,5.87843 -9.999531,12.04511 -14.599403,18.44319 m 20.229523,-13.62038 c -1.61411,1.60217 -3.20005,3.21398 -4.75777,4.83629 -17.963696,18.70844 -32.0792,38.71564 -42.371901,61.21338 m 19.670252,-26.07269 c -14.518331,23.64292 -25.61605,49.38521 -32.231248,76.68775 m 2.278806,-16.88351 c -8.885318,29.10969 -14.754817,60.77849 -15.89926,93.60288 m 0.694986,-32.93635 c -2.055874,31.04921 2.86974,63.1089 13.188365,93.63845 m -2.357091,-31.15753 c 7.774557,29.13898 18.150368,57.85677 33.661582,85.65951 m -21.786404,-9.22886 c 11.483249,23.00341 27.390429,43.42926 46.672103,61.31082 4.09124,3.79415 8.32917,7.46901 12.70286,11.02621 M 99.180114,512.69346 c 2.000046,2.15483 4.068996,4.29821 6.202166,6.42509 14.09524,14.05367 30.92337,27.31641 49.10715,38.39839 m -9.65734,2.72387 c 28.16278,18.24165 55.02846,30.77591 81.57853,35.99027 m -15.1793,-2.38265 c 31.57888,10.67389 63.18224,14.53596 96.24926,12.87733 M 270.32414,590.5781 c 24.4198,1.41104 49.67531,-0.16066 75.06399,-4.21322 m -15.0848,17.76278 c 28.02488,-4.79767 58.67186,-16.58386 87.8221,-33.59299 m -26.34361,5.84074 c 25.26965,-13.46342 50.56224,-28.14524 73.53189,-46.056 2.23715,-1.74443 4.44883,-3.51699 6.63276,-5.3192 m -16.79431,20.99569 c 4.54355,-4.00023 8.9681,-8.16312 13.25728,-12.48218 13.41486,-13.50829 25.44405,-28.48236 35.62513,-44.68017 m -11.34905,9.75006 C 506.59001,478.7836 518.54684,455.31 526.268,430.63951 m -9.69659,15.56926 c 8.09926,-22.61029 14.57531,-45.8656 17.60284,-69.58238 m -4.29059,20.73163 c 4.68976,-28.29469 5.41001,-59.67133 1.91443,-90.63691 m 1.02516,22.15639 c -3.11841,-32.83003 -12.45588,-64.26755 -27.19358,-92.48189 m 6.38051,22.8139 c -10.29451,-28.99615 -25.72857,-54.5513 -43.32814,-76.95101 m 16.05615,18.09154 c -5.54494,-7.51534 -11.72623,-14.70119 -18.51524,-21.54072 m -6.7173,-5.29585 c -20.89812,-22.83558 -49.683,-41.36916 -81.21193,-56.86003 m 27.82762,8.85738 C 378.28319,109.1748 348.51835,100.33348 316.79542,96.559138 m 33.74357,9.268152 C 323.34733,99.718554 295.00586,96.045144 267.34778,96.2964 m 12.68834,-3.267691 c -29.39628,-0.921898 -56.41251,6.81845 -82.21941,20.247091 m 12.47584,0.84265 c -25.19757,7.17729 -48.44343,18.00283 -68.66261,32.63705 m 19.22082,-17.70695 c -20.42293,11.12679 -39.67448,25.0761 -57.12958,41.16244 -6.843476,6.30684 -13.389818,12.92271 -19.607421,19.80078 m 24.545191,-15.59273 c -0.26936,0.2599 -0.53779,0.52034 -0.8053,0.78134 -19.911188,19.426 -34.616423,41.78571 -45.557922,67.23873 m 5.588663,-22.5396 c -14.82162,22.08116 -23.368698,49.10182 -26.541327,77.45299 m 11.121329,-24.57885 c -7.680233,24.74089 -13.245701,52.27343 -16.515338,80.93013 m -8.68502,-18.46829 c -0.679338,30.1458 3.996707,59.0731 16.342235,86.01037 m -1.8603,-26.04638 c 4.724655,28.12876 15.574684,57.84701 29.114231,86.52091 M 58.213522,463.32412 c 12.660845,24.01264 27.983918,45.16022 46.616308,62.60497 3.40666,3.18952 6.91921,6.25066 10.54047,9.17884 M 99.234962,518.15006 c 2.702628,2.89545 5.514038,5.76701 8.428508,8.60413 15.05133,14.65189 32.7716,28.30792 52.31954,39.58186 m -18.33725,-16.77782 c 19.51218,13.68209 41.92215,24.60151 65.46365,32.25436 m -12.32964,4.52504 c 27.17492,11.7357 59.30042,17.58783 91.51137,18.89873 m -28.41656,-6.93778 c 23.90721,2.66262 49.68232,2.40274 76.26445,-0.55776 m -11.73469,5.95353 c 25.29525,-4.12672 49.79353,-10.53354 72.27837,-20.77907 m -15.17802,1.26852 c 23.23001,-9.41691 43.04041,-20.28707 60.03091,-33.81111 m -19.25838,14.67392 c 14.55547,-8.60457 27.95652,-19.52291 40.39386,-32.07192 7.14384,-7.20798 13.95577,-14.93955 20.48102,-23.0633 m -16.36341,7.0705 c 17.95481,-18.66548 32.07351,-40.24516 42.74473,-63.51365 m -3.28569,19.28384 c 14.82031,-28.1496 24.38922,-60.399 25.06138,-93.99096 m 1.26995,21.62992 c 5.16518,-27.91859 9.05509,-55.87941 8.90936,-84.32175 m 1.8601,31.19733 c -0.44857,-25.13837 -4.14,-49.56779 -10.93198,-73.69267 m -5.3332,15.77 c -7.29756,-25.2056 -19.08165,-51.42024 -36.11114,-75.00748 m 19.66199,14.00762 C 498.63061,207.49651 483.78724,190.12941 465.50568,175.5097 m -10.017,-9.44106 c -24.05626,-22.16443 -49.05266,-40.0095 -77.13207,-54.85007 m 19.74837,14.76699 c -20.25165,-10.54058 -43.32814,-18.82125 -67.36814,-23.76352 m 10.08521,8.62051 c -22.76341,-5.6796 -45.32524,-8.65289 -66.74378,-8.157 m 16.5749,-6.059536 c -25.38112,-0.141242 -48.28836,2.030887 -69.6859,7.654806 m 20.72161,-1.43069 c -26.85066,5.14904 -53.40276,13.70942 -79.23324,25.41206 m 8.39089,-7.63859 c -26.40342,10.98813 -49.0451,30.34476 -66.49323,54.12735 -2.36836,3.22818 -4.639152,6.53527 -6.809281,9.91094 m 21.894131,-23.6894 c -4.61607,3.76368 -9.021,7.77579 -13.21966,12.01723 C 92.601959,186.745 81.198864,202.86694 71.791886,220.6766 M 86.841491,201.57138 C 74.308098,219.71684 62.166557,241.69256 52.401188,265.5924 m 0.986964,-10.2179 c -10.42391,23.04456 -16.427084,45.07871 -19.387077,66.67473 m 5.00977,-12.98066 c -4.773841,26.33287 -5.765915,53.56983 -3.090314,80.32873 m -5.64612,-24.85235 c 2.254067,24.52241 8.545044,48.92115 19.592451,71.53403 m -9.354725,-20.41305 c 6.511778,23.46582 17.816448,45.5185 32.67754,66.4973 m -7.417614,-11.54836 c 10.734852,18.01781 24.791124,35.38945 41.690267,50.86071 2.57648,2.35878 5.21746,4.67194 7.92103,6.93521 m -12.58576,-3.85473 c 1.45038,1.6671 2.9424,3.30993 4.47404,4.92828 14.97483,15.8225 33.67383,29.23993 54.19046,40.12867 m -15.24301,-13.96726 c 25.12391,17.37352 51.06611,28.89678 77.05407,36.19083 m -13.42863,-2.52606 c 22.30365,7.12721 46.06139,10.87345 70.41403,10.55153 m -27.81308,2.02667 c 29.03495,2.62736 59.74763,0.22367 90.82311,-7.75627 m -26.10392,-4.01346 c 24.36077,-2.92571 49.75163,-10.27756 73.41117,-19.71626 m -14.5178,12.92185 c 26.80098,-10.49857 54.45244,-28.49068 78.98884,-50.34331 m -8.77838,8.39276 c 8.48991,-6.92907 16.3461,-13.98931 23.57773,-21.28789 9.61869,-9.70774 18.10036,-19.80512 25.47319,-30.52011 m -12.99798,18.88214 c 20.9948,-23.98962 35.89317,-54.60019 45.8086,-87.4436 m -8.44805,23.51716 c 10.94431,-24.59124 17.98996,-48.54071 21.65808,-71.29255 m -10.22823,20.7456 c 4.29806,-31.54398 4.61936,-66.03483 -2.39034,-98.74452 m -3.2969,27.99875 c -3.46795,-24.83 -9.27089,-48.88147 -18.4004,-72.06456 m 12.43397,23.392 c -10.01178,-29.90667 -27.95808,-61.59216 -49.56685,-89.32918 m 21.82477,15.43827 c -6.01189,-9.39895 -12.73028,-17.93113 -19.98766,-25.69083 M 460.46952,162.3267 c -19.9898,-19.1623 -45.56855,-35.3279 -72.31727,-46.3337 m 16.41607,14.92128 C 378.23651,116.29523 348.57247,105.89845 316.44325,98.367014 m 28.2154,9.424046 C 321.62468,103.40468 297.88244,99.512529 273.4823,97.461729 m 14.81545,3.052901 c -32.07607,0.67042 -63.35141,6.53004 -93.96797,19.61011 m 29.6196,-6.34298 c -27.05711,5.73241 -51.10612,17.63322 -72.91282,32.62489 m 14.43425,-15.41987 c -19.86558,10.7006 -38.06816,24.72846 -53.67642,40.89615 -6.176,6.39736 -11.930503,13.11384 -17.211217,20.07006 m 11.711117,-17.43646 c -0.12194,0.13368 -0.24376,0.26746 -0.36545,0.40133 -21.42614,23.57103 -38.661245,49.87938 -46.692536,79.53187 m 8.051063,-32.40366 C 55.842035,242.4779 46.759139,264.81773 40.401932,288.35956 m 11.573003,-9.31032 c -10.281074,30.41478 -14.111108,61.38942 -14.804618,92.3982 m 5.604934,-23.37024 c -1.701354,29.14443 2.537336,60.25506 9.83196,89.07607 m -7.621794,-25.05294 c 5.986184,23.22712 14.321091,46.06673 24.964224,67.37067 m -7.310186,-17.34565 c 11.335643,23.33383 28.190339,45.41303 48.941125,65.30701 M 93.758719,508.95323 c 4.042083,4.60764 8.272051,9.15399 12.678861,13.61687 15.5966,15.79503 33.29719,30.43168 52.54517,43.00017 m -17.38646,-12.21315 c 22.43439,16.07256 49.23674,28.02681 78.52858,35.75104 m -25.72567,-6.6632 c 22.98157,7.79745 49.08216,14.57017 75.45016,17.98511 m -14.34221,-0.63178 c 29.97339,4.26259 62.02387,2.70946 92.10641,-3.13598 m -33.14077,0.86748 c 30.71979,-3.96006 62.86342,-17.3494 91.36985,-37.25816 m -19.8549,15.98233 c 28.99901,-12.58845 51.49416,-31.12231 69.52661,-55.06648 1.49456,-1.98453 2.95766,-4.00514 4.3906,-6.06141 m -11.7318,26.56229 c 5.53038,-4.39828 10.82987,-9.05721 15.89233,-13.93472 13.26533,-12.78071 24.84556,-27.00611 34.68058,-41.89417 m -12.57126,8.82363 c 17.52109,-25.076 31.41295,-54.53162 37.56093,-85.47022 m -9.49843,31.80096 c 10.15916,-27.35231 18.21566,-61.56608 22.11404,-97.59305 m 3.00991,31.44885 c 3.46978,-29.0303 -1.4696,-59.40875 -13.18107,-87.3356 m 10.18421,23.334 C 530.65681,283.50978 520.598,254.57796 504.53154,227.2158 m 9.85836,27.23427 c -11.25419,-22.73562 -25.07817,-46.44392 -42.38976,-69.48368 m 13.4919,8.59373 c -6.32002,-7.60937 -12.78162,-14.70724 -19.44834,-21.23562 m -29.91044,32.77186 c 21.49541,21.55274 38.38436,46.75585 50.46906,73.39009 m -9.29001,-28.15283 c 10.02002,23.17388 17.66457,48.67329 20.40173,75.76428 m -6.18282,-9.4545 c 4.40816,24.89669 5.33125,51.64832 2.38711,76.77752 m -3.66789,-15.68926 c -3.3205,24.11334 -10.25746,48.00174 -21.42493,69.81202 m 9.2855,-14.42058 c -10.10462,23.93692 -23.55659,44.91212 -39.88042,60.64262 m 2.11261,-21.45052 c -4.78017,6.12162 -9.91267,12.10042 -15.35003,17.90094 -10.90755,11.63605 -22.97157,22.48008 -35.78404,32.29394 m 21.96573,-4.43648 c -20.54311,16.53396 -43.99856,28.90948 -67.86167,38.41582 m 9.44334,-12.27287 c -23.01105,8.23884 -46.80585,12.8657 -70.13695,13.58946 m 7.65135,-2.41591 c -29.25158,1.76359 -60.45782,-1.46385 -88.69771,-10.50033 m 28.48037,15.27401 c -28.55264,-6.3329 -57.75618,-21.05965 -83.43082,-40.8306 m 26.84331,0.36496 c -12.84917,-8.77924 -25.29636,-18.06266 -36.6866,-27.94075 -6.22701,-5.40032 -12.10586,-10.95095 -17.5264,-16.65264 m 17.49749,22.7437 C 118.96109,477.63368 103.23306,453.70896 91.355939,427.07915 M 87.25155,440.40813 C 76.03035,413.97685 70.337681,387.98185 72.564368,361.84906 m 8.26872,19.8731 C 77.1414,352.67167 79.242899,322.831 88.436708,294.27241 m -4.822904,17.89456 c 3.536364,-25.76047 11.141587,-49.50045 21.177416,-70.15295 m -12.383435,20.04476 c 10.695945,-21.28016 24.607835,-41.00238 41.780115,-57.97613 1.0838,-1.07127 2.18004,-2.13104 3.28871,-3.17905 m -2.73147,11.95928 c 2.63325,-3.22706 5.37906,-6.37131 8.22418,-9.4306 18.73216,-20.14218 41.50761,-36.3325 64.44053,-48.35402 m -33.04122,16.02918 c 20.04143,-10.91819 43.71859,-20.10302 68.98851,-25.72634 m -10.78821,-2.33702 c 28.11115,-6.02825 59.5245,-6.93292 90.79744,0.61724 m -28.99248,-5.41855 c 33.65626,2.91349 64.66255,12.09441 90.95593,29.65839 0,0 0.008,0.005 0.008,0.005 m -30.61313,-12.94605 c 23.88661,8.83607 46.95073,22.85598 68.40191,39.67199 m 4.90406,8.42277 c 20.21773,20.78214 36.61462,42.94037 48.86964,65.39031 m -14.17922,-18.36079 c 13.54426,24.75753 22.05583,52.56163 27.55425,82.29926 m 6.49882,-15.16706 c 5.94786,26.64324 2.84294,53.85519 -6.72936,78.93736 m 2.72799,-23.95384 c -2.96919,32.45998 -16.61991,65.59273 -36.70378,96.1762 m 11.48984,-21.55161 c -10.42249,19.89044 -24.32635,39.8612 -41.53508,57.76726 -6.04167,6.28648 -12.47014,12.29679 -19.26958,17.94234 m 20.75488,-30.04142 c -0.45031,0.47671 -0.903,0.95099 -1.35805,1.42281 -19.61913,20.34258 -43.38835,35.9101 -67.88204,45.47134 m 27.58462,-0.67605 c -27.88867,13.95452 -63.77346,23.04656 -100.60387,22.04975 m 37.49694,-2.95987 c -25.70576,4.32493 -50.60932,4.06572 -75.21503,0.10763 m 10.24064,2.78135 c -30.0392,-4.05625 -56.91636,-15.732 -79.76625,-35.32345 m 23.73664,19.76402 c -23.56313,-10.63317 -43.90573,-25.44809 -61.92878,-44.20722 -4.31104,-4.48712 -8.48051,-9.19049 -12.5237,-14.10489 m 8.37793,15.31267 c -1.70707,-1.6933 -3.39587,-3.41656 -5.0636,-5.16892 -16.44377,-17.27813 -30.685772,-37.22871 -40.17541,-58.8311 m 4.207816,22.25893 C 80.118762,435.7853 72.058232,403.99483 72.654313,370.21293 m 5.476026,22.64969 c -6.693019,-30.00434 -4.853285,-62.56739 5.977778,-92.07065 m -3.972976,23.28796 c 4.157462,-26.39724 11.127174,-54.94468 22.905889,-81.51739 m -15.527034,19.4689 c 10.609717,-25.14692 26.569754,-46.09184 47.222334,-62.71267 2.43533,-1.95991 4.93359,-3.85782 7.49331,-5.69386 m -13.75538,15.90487 c 3.31763,-3.46652 6.70204,-6.86833 10.15765,-10.1889 15.88772,-15.26686 33.13221,-28.66898 51.95002,-38.63354 m -11.87602,7.81274 c 20.00982,-13.14996 42.50451,-21.29828 66.26924,-24.73057 m -25.76866,8.09041 c 27.06295,-9.14342 59.47755,-10.70972 92.27071,-5.77472 m -30.81609,-8.1145 c 29.52403,-0.0853 61.91087,6.51669 92.05182,18.01508 m -20.73911,-8.13654 c 27.66629,8.5112 50.89933,24.15764 70.26396,44.66606 m -8.65589,-17.17541 c 7.13331,5.52841 13.93603,11.5034 20.33337,17.93886 m 8.20768,9.81628 c 16.81471,18.33588 31.62726,40.45722 42.71639,64.20111 m -6.3787,-16.72779 c 14.70142,29.4321 21.79292,59.54443 22.29641,90.90306 m -11.26721,-19.92932 c 3.63181,32.59122 3.8382,61.94417 -1.04652,90.07878 m 5.92059,-24.3632 c -4.88911,29.97587 -19.90237,60.12876 -41.70592,84.52784 m 14.83256,-18.71591 c -10.48255,18.08898 -21.84984,33.64192 -34.79358,47.18015 -9.02783,9.44246 -18.76117,17.83978 -29.39545,25.39462 m 22.34861,-28.39819 c -22.2936,19.7565 -46.38788,34.79354 -72.51102,45.13583 m 19.90283,0.87606 c -29.24784,12.00868 -62.34863,21.61112 -95.2215,23.87616 m 27.9287,-7.10446 c -29.89594,2.33569 -59.89943,-0.22072 -89.34935,-8.71679 m 20.43519,1.42761 c -24.52454,-5.41991 -46.48186,-14.22781 -65.88107,-26.49123 m 20.88142,3.56374 c -19.18231,-8.84217 -37.20611,-21.78649 -53.94229,-37.15949 -9.40216,-8.63636 -18.34724,-17.99102 -26.85096,-27.76062 m 17.13491,30.02251 C 110.23533,473.86923 94.931901,449.15741 86.10795,421.00033 m 8.225277,18.43639 C 84.153367,416.98963 77.594488,394.42942 75.607969,371.43875 m -1.352468,19.38328 c -5.64872,-30.21249 -5.4311,-59.08442 0.591786,-85.86781 m -2.425205,19.79632 c 2.589795,-32.10318 16.174436,-63.36428 35.194808,-88.87066 m -7.52172,29.0964 c 9.22316,-20.55654 22.9979,-40.4885 39.43644,-58.89827 1.56151,-1.74876 3.14593,-3.48257 4.75158,-5.20082 m -13.37728,6.62886 c 2.26078,-2.51144 4.6087,-4.96884 7.03817,-7.36656 20.46836,-20.20082 46.49352,-35.93707 74.47893,-44.23303 m -25.42991,11.07221 c 25.34916,-14.1272 54.31165,-22.65025 82.14056,-23.80995 m -20.06919,-3.23117 c 28.63301,-5.06113 58.89972,-3.27427 85.63962,7.0086 m -22.56397,-4.59372 c 30.52334,2.72548 59.00628,12.58628 84.66565,26.35117 m -25.44387,-4.55653 c 20.32384,11.02454 40.55925,23.95062 58.25189,39.76266 m 3.99491,0.0862 c 18.81976,22.48468 36.72651,47.7092 49.74816,76.37325 M 469.40904,264.9638 c 11.62271,24.49037 20.13966,51.2833 24.5838,77.59164 m 1.37526,-27.34468 c 4.37708,26.24124 1.06495,53.14205 -8.84539,79.508 m 8.29291,-15.46297 c -3.3456,24.71812 -10.20638,48.12978 -20.20225,70.73655 m -0.5356,-25.19772 c -9.7059,23.90548 -25.35876,47.11051 -44.64339,67.88897 -1.46826,1.58198 -2.9565,3.1488 -4.46365,4.69981 m 19.14534,-12.30776 c -3.15282,3.77314 -6.52067,7.45897 -10.07742,11.03623 -14.32599,14.40861 -31.61684,26.95653 -50.10057,36.37278 m 10.10988,-6.68384 c -21.01334,14.08739 -44.44688,24.56153 -68.51341,31.43564 m 12.65628,-10.11577 c -29.52856,9.44392 -63.32885,11.21223 -94.35657,5.20375 m 28.355,7.40197 c -24.4167,-1.82616 -47.9057,-6.02813 -70.03311,-13.98967 m 27.69116,5.38296 c -25.83267,-7.28776 -51.78067,-20.06576 -75.94496,-35.83288 m 17.59892,1.00957 c -10.85215,-7.16394 -21.47728,-15.38008 -31.72615,-24.42843 -8.51864,-7.5208 -16.73727,-15.58094 -24.58806,-24.04669 m 8.51764,13.2654 C 107.43072,460.86599 95.13388,439.43444 87.247139,415.85172 m 0.579319,23.79222 C 75.139422,408.61243 67.395977,378.77762 67.398721,348.56043 m 11.905822,24.08695 c -3.564986,-26.25549 -2.317176,-52.05769 1.82477,-77.87242 m -10.801412,17.31748 c 4.607275,-31.10374 16.467221,-59.54669 32.718009,-86.41639 m -0.9955,27.01011 c 9.51457,-16.97776 21.56272,-32.98178 35.58438,-46.40043 4.56463,-4.36831 9.32794,-8.45241 14.26648,-12.1985 m -24.27134,6.51609 c 20.39447,-20.84066 45.14735,-35.82147 73.0846,-45.3833 m -12.89744,9.33798 c 25.55622,-12.353 52.46209,-20.53211 80.79311,-22.83538 m -21.97021,4.49698 c 29.84888,-5.24164 62.42023,-5.64005 93.04121,-0.0733 m -28.86186,-5.11346 c 24.21384,3.52573 49.03841,12.87647 72.95856,27.9263 m -17.07403,-12.84923 c 23.56544,11.59945 44.76673,24.98352 62.27377,41.71789 m -2.18781,4.52247 c 18.10404,19.16544 34.22653,39.95805 46.75624,61.47089 m -5.04269,-20.86953 c 11.24102,22.61097 19.39805,49.91226 21.48642,77.97693 m -1.45224,-17.05371 c 3.92395,23.72085 4.20725,49.50248 -0.73498,74.34389 M 498.11384,367.477 c -2.17263,30.02804 -12.7309,61.76149 -29.5265,89.40945 m 7.95981,-22.43444 c -10.30291,22.70516 -25.24618,44.21224 -44.685,62.66902 m 16.1137,-12.77353 c -4.64167,5.7187 -9.49195,11.12391 -14.56155,16.23629 -17.48979,17.63737 -37.41953,31.61985 -60.08284,42.98093 m 19.50485,-16.50028 c -22.68846,14.08096 -47.02493,22.82674 -73.08264,25.97342 m 27.24874,4.50411 c -32.89276,10.50877 -67.19006,9.77301 -102.49794,1.28665 m 25.64962,-2.61522 c -25.10913,-2.01113 -47.97393,-6.27066 -69.41656,-13.76518 m 15.30252,9.66855 c -30.88279,-9.43111 -56.53351,-26.85309 -75.65963,-49.01713 m 18.09474,16.2196 c -7.40937,-6.35225 -14.81347,-12.92672 -22.0746,-19.81921 -10.66134,-10.12008 -20.91664,-20.8343 -30.2943,-32.35687 m 10.53846,9.13972 C 100.80994,453.95552 87.743476,430.30628 78.592716,404.0416 m 8.912827,16.68622 C 76.77806,397.00859 71.331097,370.6703 68.983297,344.49037 m 7.63135,23.32882 c -3.550607,-27.48224 -0.140353,-55.63927 7.348781,-82.02752 m -4.219346,12.81905 c 6.737439,-25.06017 15.913358,-48.66313 29.248948,-70.04455 m -7.65034,24.04598 c 9.92754,-18.75943 22.24701,-34.79486 36.87619,-48.6464 3.39249,-3.21216 6.90459,-6.30254 10.53434,-9.27894 m -15.53752,1.52609 c 0.61689,-0.66008 1.23746,-1.31318 1.86169,-1.95932 21.62656,-22.3858 47.44397,-36.22196 75.32922,-42.4673 m -19.90637,10.2763 c 26.6683,-12.2814 51.64541,-21.00611 76.33757,-24.07503 m -19.46471,3.92858 c 23.95724,-4.25173 47.7694,-4.16338 70.97966,0.0865 m -13.15185,-1.03502 c 26.93611,2.59709 52.20446,8.03486 75.82642,16.13623 m -16.96287,1.47903 c 25.22652,11.2887 49.26243,24.78038 69.36468,41.5192 m 51.07571,238.46374 -83.76021,96.87222 M 215.33668,141.04333 343.37083,138.34942 M 64.372499,357.66021 97.22827,233.88421 M 91.447514,176.04381 29.362789,301.52484 M 542.79507,323.71733 491.76921,193.34724"
       id="pathRingSketchOutline"
       inkscape:connector-curvature="0"
       inkscape:path-effect="#path-effect3858"
       inkscape:original-d="m 461.2551,172.87321 a 250,250 0 0 0 -353.55339,0 250,250 0 0 0 0,353.55339 250,250 0 0 0 353.55339,0 250,250 0 0 0 0,-353.55339 z m -28.99138,28.28427 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98484,0 210,210 0 0 1 0,-296.98485 210,210 0 0 1 296.98484,0 z" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="ringShading"
     inkscape:label="ringShading"
     style="display:inline"
     transform="translate(35.101634,99.999975)"
     sodipodi:insensitive="true">
    <path
       inkscape:connector-curvature="0"
       style="fill:url(#radialGradient7227);fill-opacity:1;stroke:none"
       d="m 426.67511,73.223276 a 250,250 0 0 0 -353.553384,0 250,250 0 0 0 -5.7e-5,353.553444 250,250 0 0 0 353.553441,-6e-5 250,250 0 0 0 0,-353.553384 z m -28.99137,28.284264 a 210,210 0 0 1 0,296.98485 210,210 0 0 1 -296.98491,6e-5 210,210 0 0 1 6e-5,-296.98491 210,210 0 0 1 296.98485,0 z"
       id="pathRingShading" />
  </g>
  <g
     inkscape:groupmode="layer"
     id="modifiers"
     inkscape:label="modifiers"
  </g>
  <g
     inkscape:groupmode="layer"
     id="heightIndicator"
     inkscape:label="heightIndicator"
     style="display:inline"
     sodipodi:insensitive="true">
    <g
       id="height"
       transform="matrix(1.44,0,0,1.44,-236.90908,-280.32315)"
       style="opacity:1">
      <title
         id="title4706">height</title>
      <text
         inkscape:transform-center-y="-96.226167"
         inkscape:transform-center-x="15.193596"
         sodipodi:linespacing="125%"
         id="textHeight"
         y="676.94495"
         x="331.96698"
         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:121.52777863px;line-height:125%;font-family:sans-serif;-inkscape-font-specification:\\\'sans-serif, Bold\\\';text-align:start;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:start;fill:#000000;fill-opacity:1;stroke:#ffff00;stroke-width:3.47222233;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
         xml:space="preserve"><tspan
           y="676.94495"
           x="331.96698"
           id="tspanHeight"
           sodipodi:role="line"></tspan></text>
    </g>
  </g>
</svg>
',
'\' WHERE `name` = "pawn_trap"'); 
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


# The idPawnMask need to be selected from the role name
# For PawnMask entries I need to name them the same as the Role Table and then enter the approriate SVG entries
#SELECT Pawn.*,PawnMask.idPawnMask from DragonberryPiv1.Pawn,DragonberryPiv1.Role,DragonberryPi.PawnMask WHERE Pawn.idRole = Role.idRole AND PawnMask.name = CONCAT('pawn_',Role.name) ;
SET @oldcols = 'idPawn,Pawn.name,rotate,sizeFeet,translateX,translateY,color,height,attackRange,attackType,visible,dmVisible,depth,backgroundColor,ruleLink,idImage,imageX,imageY,imageScale,idMap,Pawn.idRole,PawnMask.idPawnMask,Pawn.updated,Pawn.updatedBy',
    @newcols = 'idPawn,name,rotate,sizeFeet,translateX,translateY,color,height,attackRange,attackType,visible,dmVisible,depth,backgroundColor,ruleLink,idImage,imageX,imageY,imageScale,idMap,idRole,idPawnMask,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.Pawn (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Pawn,',@olddb,'.Role,',@newdb,'.PawnMask WHERE Pawn.idRole = Role.idRole AND PawnMask.name = CONCAT(\'pawn_\',Role.name)');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @oldcols = 'idPawn,idModifier,updated,updatedBy',
    @newcols = 'idPawn,idModifier,updated,updatedBy';
SET @q = CONCAT('INSERT INTO ', @newdb, '.PawnModifier (',@newcols,') SELECT ',@oldcols,' FROM ',@olddb,'.Modifiers;');
PREPARE stmt FROM @q;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

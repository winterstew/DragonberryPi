<?php 
$controlsText = '' .
'mouse click   ---> select/deselect a pawn or tile\n' .
'mouse dbl-click   ---> toggle visibility of a pawn or tile\n' .
'1, 2, 3, etc   ---> select/deselect a specific PC pawn\n' .
'q, w, e, etc   ---> select/deselect a specific monster pawn\n' .
'v   ---> toggle visibility of the selected pawn or tile\n' .
'arrow keys   ---> coarse translate selected pawn or tile\n' .
'Ctrl-left, Ctrl-right   ---> coarse rotate selected pawn or tile\n' .
'Ctrl-up, Ctrl-down   ---> coarse scale selected pawn or tile\n' .
'Shift ...   ---> enable fine control of movement and scale of arrow key based commands\n' .
'mouse click-and-drag   ---> translate whole pawn grid\n' .
'Ctrl click-and-drag left&right   ---> rotate whole pawn grid\n' .
'Alt click-and-drag up&down   ---> scale whole pawn grid\n' .
'Shift mouse ...   ---> enable fine control of click-and-drag based commands\n' .
's   ---> save new position of pawn grid or tile movements to database. Pawn movements and visibility changes are auto-saved\n' .
'a   ---> turn selected pawn into a leader of its group such that its movements apply to all in the group\n' .
'l   ---> toggle indicator of line based attack ranges\n' .
'k   ---> toggle indicator of conical based attack ranges\n' .
'j   ---> toggle indicator of spherical based attack ranges\n' .
'h   ---> toggle selection of height adjustment\n' .
'<   ---> decrease attack range or height (as selected above) by 5 feet\n' .
',   ---> decrease attack range or height (as selected above) by 10 feet\n' .
'Ctrl-,   ---> decrease attack range or height (as selected above) by 25 feet\n' .
'>   ---> increase attack range or height (as selected above) by 5 feet\n' .
'.   ---> increase attack range or height (as selected above) by 10 feet\n' .
'Ctrl-.   ---> increase attack range or height (as selected above) by 25 feet\n' .
'b   ---> toggle display of a map pointer\n' .
'd   ---> force reload of browser\n' .
'f   ---> flip keyboard controls upside-down\n' ;
$controlsHTML = "<tr><td style=\"text-align:right; font-weight:bold;\">mouse click</td><td>select/deselect a pawn or tile</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">1, 2, or 3</td><td>select/deselect a specific PC pawn</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">q, w, e, r, t, or y</td><td>select/deselect a specific monster pawn</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">mouse dbl-click</td><td>toggle visibility of a pawn or tile</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">v</td><td>toggle visibility of the selected pawn or tile</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">arrow keys</td><td>coarse translate selected pawn or tile</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">Ctrl-left arrow, Ctrl-right arrow</td><td>coarse rotate selected pawn or tile</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">Ctrl-up arrow, Ctrl-down arrow</td><td>coarse scale selected pawn or tile</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">Shift ...</td><td>enable fine control of movement and scale of arrow key based commands</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">mouse click-and-drag</td><td>translate whole pawn grid</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">Ctrl mouse click-and-drag left&amp;right</td><td>rotate whole pawn grid</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">Alt mouse click-and-drag up&amp;down</td><td>scale whole pawn grid</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">Shift ...</td><td>enable fine control of click-and-drag based commands</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">s</td><td>save new position of pawn grid or tile movements to database.  Pawn movements and visibility changes are auto-saved</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">a</td><td>turn selected pawn into a leader of its group such that its movements apply to all in the group</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">l</td><td>toggle indicator of line based attack ranges</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">k</td><td>toggle indicator of conical based attack ranges</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">j</td><td>toggle indicator of spherical based attack ranges</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">h</td><td>toggle selection of height adjustment</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">,</td><td>decrease attack range or height (as selected above) by five feet</td</tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">.</td><td>increase attack range or height (as selected above) by five feet</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">b</td><td>toggle display of a map pointer</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">d</td><td>force reload of browser</td></tr>" .
"<tr><td style=\"text-align:right; font-weight:bold;\">f</td><td>flip keyboard controls upside-down</td></tr>" ;
?>

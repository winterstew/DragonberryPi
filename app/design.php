<!DOCTYPE html>
<html>
<head>
<title>Adventure Design</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
}

/* Style the header */
.header {
    background-color: #f1f1f1;
    /*padding: 50px;*/
    text-align: center;
}

/* Create three equal columns that floats next to each other */
.column {
    float: left;
    width: 16%;
    display: table-cell;
    padding: 10px;
}
.entryColumn {
    width: 20%;
}
.collapse {
    width: 0px;
    padding: 0px;
    visibility: collapse;
    border-collapse: collapse;
}
.hidden {
    width: 20%;
    padding: 10px;
    visibility: hidden;
    border-collapse: collapse;
}


.recordInputs {
    white-space: nowrap; 
    height: 100%;
    max-height: 400px;
    overflow-x: auto;
    overflow-y: auto;
}
.inputRow {
    border: 0px;
    padding: 0px;
    margin: 0px;
}
.recordList {
    white-space: nowrap; 
    height: 100%;
    max-height: 400px;
    overflow-x: auto;
    overflow-y: auto;
    /* transform:rotateX(180deg); */
    /* -ms-transform:rotateX(180deg); /* IE 9 */
    /* -webkit-transform:rotateX(180deg); /* Safari and Chrome */
}
.short {
    max-height: 100px;
}

/* Clear floats after the columns */
.row::after {
    content: "";
    display: table;
    clear: both;
}

.hiddenCell {
    visibility: hidden;
}

.tableHeadName {
    float: left;
}

.tableHeadSort {
    float: right;
    font-size: 0.65em;
}

table {
    border-collapse: collapse;
}

.recordListTable {
    /* transform:rotateX(180deg); */
    /* -ms-transform:rotateX(180deg); /* IE 9 */
    /* -webkit-transform:rotateX(180deg); /* Safari and Chrome */
}

table, th, td {
    border: 0px;
}

th, td {
    padding: 0px;
}

tr:hover {
    background-color: #f5f5f5
}

.selected {
    background-color: hsl(270,50%,90%);
}

.active {
    background-color: hsl(270,100%,75%);
}

.selector {
    background-color: hsl(30,100%,60%);
}

.collapseCol {
    visibility: collapse;
    background-color: yellow;
}

.visibleCol {
    visibility: visible;
}

.collapseCell {
    visibility: collapse;
}

.visibleCell {
    visibility: visible;
}

/* Style the footer */
.footer {
    background-color: #f1f1f1;
    /*padding: 10px;*/
    text-align: center;
}

.previews {
    position: absolute;
    bottom: 30px;
    right: 30px;
    height: 30%;
    max-width: 50%;
    overflow-y: auto;
    background-color: #EEEEEE;
}

.gallery {
    float: right;
    display: table-cell;
}

.galleryName {
    color: green;
    text-align: center;
}

.color1 {
    color: hsl(0, 100%, 30%);
}
.color2 {
    color: hsl(60, 100%, 30%);
}
.color3 {
    color: hsl(120, 100%, 30%);
}
.color4 {
    color: hsl(180, 100%, 30%);
}
.colorEntry {
    color: hsl(0, 50%, 50%);
}

/* Responsive layout - makes the three columns stack on top of each other instead of next to each other */
@media (max-width: 600px) {
    .column {
        width: 100%;
    }
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
var appRoot = "<?php echo $app->config('root') ?>"
var columnsToShow = ["name","filename"];
$(document).ready(function(){
    $(".tableHead").on("click",onClickTableHead);
    $(".entryHead").on("click",onClickEntryHead);
    $("button.entryButton").on("click",onClickEntry);
    $("input").keyup(onClickTableHead);
    $(".tableHead").click();
    //$(".tableHeadSort").addClass("material-icons");
    //$(".tableHeadSort").html('arrow_drop_downsortarrow_drop_down&nbsparrow_drop_downsort_by_alphaarrow_drop_down&nbsp;arrow_drop_upaccess_timearrow_drop_down');
    $(".tableHeadSort").html('<i class="fa fa-sort-numeric-asc"></i>&nbsp;&nbsp;' +
                             '<i class="fa fa-sort-numeric-desc"></i>&nbsp;&nbsp;' +
                             '<i class="fa fa-sort-alpha-asc"></i>&nbsp;&nbsp;' +
                             '<i class="fa fa-sort-alpha-desc"></i>&nbsp;&nbsp;' +
                             '<i class="fa fa-long-arrow-up"></i>' +
                             '<i class="fa fa-clock-o"></i>' +
                             '<i class="fa fa-long-arrow-down"></i>' +
                             '');
    $(".fa-sort-numeric-asc").click(onClickSort);
    $(".fa-sort-numeric-desc").click(onClickSort);
    $(".fa-sort-alpha-asc").click(onClickSort);
    $(".fa-sort-alpha-desc").click(onClickSort);
    $(".fa-long-arrow-up").click(onClickSort);
    $(".fa-long-arrow-down").click(onClickSort);
    $("#divAdventureMap").hide();
    $(".previews").empty();
    $(".previews").hide();
});
function showGalleryImage(id) {
    var idimage = 0;
    $(".previews").show();
    switch(id.slice(0,4)) {
        case "Pawn":
        case "Tile":
            idimage = $("#"+id).attr("idimage");
            //$(".footer").find("p").text(id +  $("#"+id+"_name").val());
            break;
        case "Imag":
            idimage = id.slice(5);
            //$(".footer").find("p").text(id +  $("#"+id+"_filename").val());
            break;
    }
    if (idimage) {
        if (! $("#PreviewImage"+idimage).length) {
            createPreviewGallery("idImage = "+idimage);
        } else {
            $("#PreviewImage"+idimage).show(); 
        }
    }
}
function createPreviewGallery(where) {
    var select = 'Image.idImage, Image.filename, idTree as idLocationTree,treeDepth as depth,Image.updated as updated,name0,name1,name2,name3,name4,name5,name6,name7,name8';
    var table = "LocationTree";
    var order = "Image.idImage";
    var extrajoin = "JOIN Image ON Image.idLocation = idTree";
    $.post("select",
    JSON.stringify({
        select: select,
        table: table,
        extrajoin: extrajoin,
        where: where,
        order: order
    }),selectPreviewGalleryCallback,"json");
}
function selectPreviewGalleryCallback(rtnData,rtnStatus,xhr){
    if (rtnStatus == "success") {
        var table = rtnData.shift();
        //$(selector).append(getRowList(table,rtnData,["name","filename","updated"],"selected"));
        for (i in rtnData) {
            var row = rtnData[i];
            var file = row["name" + row["depth"]] + "/" + row["filename"];
            var galleryPic = '<div class="gallery" id="PreviewImage'+row["idImage"]+'">';
            galleryPic += '<a target="_black" href="'+appRoot+file+'">';
            galleryPic += '<img src="'+appRoot+file+'" alt="'+row["filename"]+'" height="200">';
            galleryPic += '</a>';
            galleryPic += '<div class="galleryName">'+row["filename"]+'</div>';
            galleryPic += '</div>';
            $(".previews").append(galleryPic);
        }
    } 
}
function onClickSort(){
    $(this).closest(".tableHead").find(".fa").removeClass("selected")
    $(this).addClass("selected");
}
function getWhere(el) {
    var table = $(el).closest("div").attr("id").slice(3);
    var where = $(el).closest("div").find("input").val();
    var rtn = '';
    if (where) {
        if (table == "Image") {
            rtn += "file";
        }
        rtn += 'name LIKE ';
        if ((where.indexOf("%") < 0) && (where.indexOf("_") < 0)) {
            rtn += '"%' + where + '%"';
        } else {
            rtn += '"' + where + '"';
        }
    } else {
        rtn = "true"
    }
    $(".footer").find("p").text(rtn);
    return rtn;
}
function getOrder(el) {
    var table = $(el).closest("div").attr("id").slice(3);
    var order = "true";
    var classes =  $(el).find(".selected").attr("class");
    if (classes) {
        if (classes.indexOf("sort-numeric") >= 0) { order = "id" + table; };
        if (classes.indexOf("sort-alpha") >= 0) { if (table == "Image") { order = "binary(filename)"; } else { order = "binary(name)"; }};
        if (classes.indexOf("long-arrow") >= 0) { order = "updated"; };
        if (classes.indexOf("-asc") >= 0) { order += " ASC"; 
        } else { if (classes.indexOf("-up") >= 0) { order += " ASC"; 
            } else { if (classes.indexOf("-desc") >= 0) { order += " DESC"; 
                } else { if (classes.indexOf("-down") >= 0) { order += " DESC"; }}}}
    } 
    //$(".footer").find("p").text(order)
    return order;
}
function onClickEntry(event){
    var url = $(event.target).attr("name") + 'Record';
    var table = $(".entryHead").text();
    var id = 0;
    var idList = '';
    var setList = '';
    var val = "NULL"
    $(".recordInputs").children().each(function() {
        if ($(this).is("input")) {
            if ($(this).attr("name") == "id"+table) {
                id = $(this).val();
            } else if ( $(this).attr("name") == "idList" ) {
                if ( $(this).val() ) {
                    idList = "UPDATE " + $(this).val() + ";";
                }
            } else {
                if (($(this).val()) && 
                    ($(this).val() != "#000000") && 
                    ( $(this).val() != "null")) {
                    setList += $(this).attr("name") + '="' + $(this).val() + '", ';
                } else {
                    setList += $(this).attr("name") + '=NULL, ';
                }
            }
        }
    });
    setList = setList.slice(0,setList.length-2)
    $.post(url,
    JSON.stringify({
        table: table,
        id: id,
        idList: idList,
        setList: setList
    }),entryCallback,"json");
    $(".footer").find("p").html("<b>" + url + " <i>" + table+"</i></b> SET <b>"+setList+"</b>");
}

function onClickTableHead(event){
    var table = $(this).closest("div").attr("id").slice(3);
    if (table == "Null") { return; };
    var where = getWhere(this);
    var order = getOrder(this);
    if (event.ctrlKey) { 
        $.post("showColumns",
        JSON.stringify({
            table: table
        }),createInputFormColumnCallback,"json");
        return;
    };
    $.post("select",
    JSON.stringify({
        table: table,
        where: where,
        order: order
    }),selectRowListCallback,"json");
};
function onClickEntryHead(event){
    var table = $(".entryHead").text();
    $(".entryButton").attr("name","insert");
    $(".entryButton").text("new");
    $("input").text("new");
    $("input[name='id"+table+"']").val('');
}
function onDblClickRecordRow(el){
    $(".recordRow").removeClass('selector');
    $(el).addClass('selector');
    var table = $(el).closest("div").attr("id").slice(3);
    if (table == "Null") { return; };
    var id = $(el).attr("id").slice(table.length); 
    var select = "*";
    switch(table) {
        case "Adventure":
            selectList = ["Map.*",
                          "Tile.*",
                          "Pawn.*"];
            tableList = ["Map JOIN AdventureMap ON AdventureMap.idMap = Map.idMap JOIN Adventure ON AdventureMap.idAdventure = Adventure.idAdventure",
                         "Tile JOIN AdventureMap ON AdventureMap.idMap = Tile.idMap JOIN Adventure ON AdventureMap.idAdventure = Adventure.idAdventure",
                         "Pawn JOIN AdventureMap ON AdventureMap.idMap = Pawn.idMap JOIN Adventure ON AdventureMap.idAdventure = Adventure.idAdventure"];
            whereList = ["Adventure.idAdventure = " + id,
                         "Adventure.idAdventure = " + id,
                         "Adventure.idAdventure = " + id];
            orderList = [getOrder("#divMap .tableHead"),
                         getOrder("#divTile .tableHead"),
                         getOrder("#divPawn .tableHead")];
            break;
        case "Map":
            selectList = ["*","*"];
            tableList = ["Tile","Pawn"];
            whereList = ["Tile.idMap = " + id,"Pawn.idMap = " + id];
            orderList = [getOrder("#divTile .tableHead"),
                         getOrder("#divPawn .tableHead")];
            break;
        case "Display":
            selectList = ["Map.*"];
            tableList = ["Map"];
            whereList = ["Map.idDisplay = " + id];
            orderList = [getOrder("#divMap .tableHead")];
            break;
        case "MapType":
            selectList = ["Map.*"];
            tableList = ["Map"];
            whereList = ["Map.idMapType = " + id];
            orderList = [getOrder("#divMap .tableHead")];
            break;
        case "Role":
            selectList = ["Pawn.*"];
            tableList = ["Pawn"];
            whereList = ["Pawn.idRole = " + id];
            orderList = [getOrder("#divPawn .tableHead")];
            break;
        case "Location":
        case "LocationTree":
            selectList = ["Image.*"];
            tableList = ["Image"];
            whereList = ["Image.idLocation = " + id];
            orderList = [getOrder("#divImage .tableHead")];
            break;
        case "Pawn":
        case "Tile":
            selectList = ["Image.*"];
            tableList = ["Image JOIN " + table + " ON " + table + ".idImage = Image.idImage"];
            whereList = [table + ".id" + table + " = " + id];
            orderList = [getOrder("#divImage .tableHead")];
            break;
        case "Image":
            selectList = ["*","*"];
            tableList = ["Tile","Pawn"];
            whereList = ["Tile.idImage = " + id,"Pawn.idImage = " + id];
            orderList = [getOrder("#divTile .tableHead"),
                         getOrder("#divPawn .tableHead")];
            break;
    }
    for (i in selectList) {
        $.post("select",
        JSON.stringify({
            table: tableList[i],
            select: selectList[i],
            where: whereList[i],
            order: orderList[i]
        }),selectRowListCallbackSelected,"json");
        if ((table == "LocationTree") && (tableList[i] == "Image")) {
            $(".previews").show();
            createPreviewGallery(whereList[i])
        }
    }
}
function onHoverInputRow(el){
    $(".previews").hide();
    $(".gallery").hide();
}
function onHoverRecordRow(el){
    $(".previews").hide();
    $(".gallery").hide();
    if ($(el).attr("id")) {
        var id = $(el).attr("id")
        switch(id.slice(0,4)) {
            case "Imag":
                showGalleryImage(id);
                $(".footer").find("p").html("<b>" + id + "</b> <i>" + $("#"+ id + "_filename").text()+"</i>");
                break;
            case "Pawn":
            case "Tile":
                showGalleryImage(id);
            default:
                $(".footer").find("p").html("<b>" + id + "</b> <i>" + $("#"+ id + "_name").text()+"</i>");
                break;
        }
    }
}
function onClickRecordRow(el){
    var table = $(el).closest("div").attr("id").slice(3); 
    var id = $(el).attr("id").slice(table.length); 
    // deselect all other recordRows and select the current one
    if (event.altKey) {
        if ($("input[name='id"+table+"']")) {
            $("input[name='id"+table+"']").val(id);
        } else {
            var v = $("input[name='idList']").val();
            if (v && (v.slice(0,table.length) == table)) {
              $("input[name='idList']").val( v + " OR " + "id" + table + "=" + id );
              //$("input[name='idList']").val( v + "," + "id" + table + "=" + id );
            } else {
              $("input[name='idList']").val( table + " SET id%s=%s WHERE id" + table + "=" + id  );
              //$("input[name='idList']").val( table + "," + "id" + table + "=" + id  );
            }
        }
        $(el).addClass('active');
        return;
    }
    $(".recordRow").removeClass('active');
    $(".recordRow").removeClass('selected');
    if (event.ctrlKey) { 
        $.post("select",
        JSON.stringify({
            table: table,
            where: 'id'+table+' = '+id,
            order: "true LIMIT 1"
        }),createInputFormModifyCallback,"json");
        $(el).addClass('active');
    };
    //$(el).closest(".recordRow").addClass('active');
    $(el).addClass('active');
    selectRelatedRows(-1,el);
}
function selectRelatedRows(idx,el){
    // find related rows in other tables
    var table = $(el).closest("div").attr("id").slice(3); 
    var id = $(el).attr("id").slice(table.length); 
    var idadventure =  $(el).attr("idadventure");
    var idadventuremap = $(el).attr("idadventuremap");
    var idmap = $(el).attr("idmap");
    var idmaptype = $(el).attr("idmaptype");
    var iddisplay = $(el).attr("iddisplay");
    var idrole = $(el).attr("idrole");
    var idtile = $(el).attr("idtile");
    var idpawn = $(el).attr("idpawn");
    var idimage = $(el).attr("idimage");
    var idlocation = $(el).attr("idlocation");
    // recursive functin to select ros for each table?
    switch(table) {
        case "Adventure":
            //$(".idAdventure"+id).closest(".recordRow").addClass('selected');
            //$(".idAdventure"+id).closest(".recordRow").click();
            $(".recordRow[idadventure='"+id+"']").addClass('selected');
            if ( idx < 0 ) { $(".recordRow[idadventure='"+id+"']").each(selectRelatedRows); };
            break;
        case "AdventureMap":
            //$(".idMap").closest(".recordRow").addClass('selected');
            //$(".idMap").closest(".recordRow").click();
            //$(".recordRow[idadventuremap='"+id+"']").addClass('selected');
            $(".recordRow[id='Adventure"+idadventure+"']").addClass('selected');
            $(".recordRow[id='Map"+idmap+"']").addClass('selected');
            break;
        case "Map":
            $(".recordRow[idmap='"+id+"']").addClass('selected');
            $(".recordRow[id='MapType"+idmaptype+"']").addClass('selected');
            $(".recordRow[id='Display"+iddisplay+"']").addClass('selected');
            if ( idx < 0 ) { $(".recordRow[idmap='"+id+"']").each(selectRelatedRows); };
            break;
        case "Tile":
            //$(".recordRow[idtile='"+id+"']").addClass('selected');
            $(".recordRow[id='Image"+idimage+"']").addClass('selected');
            $(".recordRow[id='Map"+idmap+"']").addClass('selected');
            break;
        case "Pawn":
            //$(".recordRow[idpawn='"+id+"']").addClass('selected');
            $(".recordRow[id='Image"+idimage+"']").addClass('selected');
            $(".recordRow[id='Map"+idmap+"']").addClass('selected');
            $(".recordRow[id='Role"+idrole+"']").addClass('selected');
            break;
        case "Display":
            $(".recordRow[iddisplay='"+id+"']").addClass('selected');
            break;
        case "MapType":
            $(".recordRow[idmaptype='"+id+"']").addClass('selected');
            break;
        case "Role":
            $(".recordRow[idrole='"+id+"']").addClass('selected');
            break;
        case "Image":
            $(".recordRow[id='Location"+idlocation+"']").addClass('selected');
            $(".recordRow[id='LocationTree"+idlocation+"']").addClass('selected');
            $(".recordRow[idimage='"+id+"']").addClass('selected');
            break;
        case "Location":
        case "LocationTree":
            $(".recordRow[idlocation='"+id+"']").addClass('selected');
            break;
    }
}
function entryCallback(rtnData,rtnStatus,xhr) {
    $(".footer").find("p").text(rtnStatus);
    if (rtnStatus == "success") {
    }
}
function createInputFormModifyCallback(rtnData,rtnStatus,xhr){
    createInputFormCallback(rtnData,rtnStatus,xhr,true);
}
function createInputFormCallback(rtnData,rtnStatus,xhr,modify){
    if (rtnStatus == "success") {
        var table = rtnData.shift();
        var row = rtnData.shift();
        $("p.recordInputs").empty();
        $("p.recordInputs").append();
        $("p.recordInputs").append(createInputForm(table,row,modify));
    } 
}
function createInputFormColumnCallback(rtnData,rtnStatus,xhr){
    if (rtnStatus == "success") {
        var table = rtnData.shift();
        $("p.recordInputs").empty();
        $("p.recordInputs").append();
        $("p.recordInputs").append(createDefaultInputForm(table,rtnData));
    } 
}

function selectRowListCallback(rtnData,rtnStatus,xhr){
    if (rtnStatus == "success") {
        var table = rtnData.shift();
        var selector = "#div" + table + " > p:first-of-type";
        if ($("#div" + table).parent().hasClass("row2")) { $(selector).toggleClass("short") }
        $(selector).empty();
        $(selector).append(getRowList(table,rtnData,columnsToShow));
    } 
    $(".active").click();
}
function selectRowListCallbackSelected(rtnData,rtnStatus,xhr){
    //alert("Data: " + rtnData + "\nStatus: " + rtnStatus + "\nHTTP Request: " + xhr);
    if (rtnStatus == "success") {
        var table = rtnData.shift();
        var selector = "#div" + table + " > p:first-of-type";
        if ($("#div" + table).parent().hasClass("row2")) { $(selector).toggleClass("short") }
        $(selector).empty();
        $(selector).append(getRowList(table,rtnData,columnsToShow,"selected"));
    } 
}
function createDefaultInputForm(table,rows) {
    var rtn = '';
    $(".entryHead").text(table);
    $(".entryButton").attr("name","insert");
    $(".entryButton").text("new");
    for (i in rows) {
        var ro = '';
        var type = '';
        var name = rows[i]["Field"];
        var val = 'value = "' +rows[i]["Default"]+'" ';
        if (! rows[i]["Default"]) { val = ''; };
        if ((name.indexOf("color") >= 0) || (name.indexOf("Color") >= 0)) { type = 'type = "color" '; };
        if (name.slice(0,2) == "id") { ro = "readonly"; };
        if (name.slice(0,6) != "update") { 
            rtn += '<input onmouseover="onHoverInputRow()" size=15 name="'+name+'" '+ val + type + ro +'><span class="colorEntry"> ' + name +'</span><br>';
        }
    }
    //rtn += '<input size=15 name="idList" style="display: none;" readonly>';
    rtn += '<input size=15 name="idList" readonly>';
    return rtn;
}
function createInputForm(table,row,modify) {
    var rtn = '';
    $(".entryHead").text(table);
    if (modify) {
        $(".entryButton").attr("name","update");
        $(".entryButton").text("update");
    } else {
        $(".entryButton").attr("name","insert");
        $(".entryButton").text("new");
    }
    for (i in row) {
        var ro = '';
        var val = '';
        var type = '';
        if (i.slice(0,6) != "update") {
            if (i.slice(0,2) == "id") { ro = "readonly"; };
            if (modify) { val = 'value="' + row[i] + '" '; };
            if ((i.indexOf("color") >= 0) || (i.indexOf("Color") >= 0)) { type = 'type = "color" '; };
//            rtn += '<p onmouseover="onHoverInputRow()" class="inputRow">';
            rtn += '<input onmouseover=""onHoverInputRow()" size=15 name="'+i+'" ' + type + val + ro + '><span class="colorEntry"> ' + i +'</span><br>';
//            rtn += '</p>';
        }
    }
    //rtn += '<input size=15 name="idList" style="display: none;" readonly>';
//    rtn += '<p onmouseover="onHoverInputRow()" class="inputRow"';
    rtn += '<input size=15 name="idList" readonly>';
//    rtn += '</p>';
    return rtn;
}
function getRowList(table,rows,cols,extrarowclass,hasHeader) {
    var rtn = "<table class=\"recordListTable\">";
    var i,j,thisId,thatId,vis;
    rtn += "<colgroup>"
    for (j in rows[0]) {
        if (j.slice(2) == table) { continue };
        if (cols.indexOf(j) >= 0) { vis = "visible" } else { vis = "collapse" }
        rtn += "<col class=\"" + vis + "Col\">"
    }
    rtn += "</colgroup>"
    if (hasHeader) {
        rtn += "<tr>"
        for (j in rows[0]) {
            if (j.slice(2) == table) { continue };
            rtn += "<th>" + j + "</th>"
        }
        rtn += "</tr>"
    }
    for (i in rows) {
        thisId = table + rows[i]["id" + table];
        rtn += "<tr class=\"recordRow";
        if (extrarowclass) { rtn += " " + extrarowclass; };
        if (table.slice(0,3) == "Map") {
            rtn += " color" + rows[i]["idMapType"];
        }
        rtn += "\" onmouseover=\"onHoverRecordRow(this)\" ";
        rtn += "\" onclick=\"onClickRecordRow(this)\" ";
        rtn += "\" ondblclick=\"onDblClickRecordRow(this)\" id=\"" + thisId + "\" ";
        // attrebutes for each index
        for (j in rows[i]) {
            if (j.slice(2) == table) { continue };
            if (j.slice(0,2) == "id") { rtn += j + "=\"" + rows[i][j] + "\"" }
        }
        rtn += ">"
        for (j in rows[i]) {
            var c = "";
            if (j.slice(2) == table) { continue };
            if (j.slice(0,2) == "id") { c = " " + j + rows[i][j] };
            if ((j == "name") && (table == "LocationTree")) {
                rows[i][j] = rows[i]["name" + rows[i]["depth"]];
                if (rows[i]["depth"] == 0) { rows[i][j] = "/"; };
                if (rows[i]["depth"] == 1) { rows[i][j] = rows[i]["name0"]; };
            };
            if (cols.indexOf(j) >= 0) { vis = "visible" } else { vis = "collapse" };
            thatId = thisId + "_" + j;
            rtn += "<td id=\"" + thatId + "\" class=\"" + vis + "Cell" + c + "\">"
            rtn += rows[i][j]
            rtn += "</td>"
        }
        rtn += "</tr>"
    }
    rtn += "</table>";
    return rtn;
}
</script>
</head>
<body>

<div class="header">
<h2>Adventure Design</h2>
</div>

<div class="row row1">
<div id="divAdventure" class="column"><h3 class="tableHead"><span class="tableHeadName">Adventure</span><span class="tableHeadSort">#^A^T^</span><span style="clear: both;"><br></span></h3><input class="filter" value=""><p class="recordList"></p> </div>
<div id="divMap" class="column"><h3 class="tableHead"><span class="tableHeadName">Map</span><span class="tableHeadSort">#^A^T^</span><span style="clear: both;"><br></span></h3><input class="filter" value=""><p class="recordList"></p></div>
<div id="divTile" class="column"><h3 class="tableHead"><span class="tableHeadName">Tile</span><span class="tableHeadSort">#^A^T^</span><span style="clear: both;"><br></span></h3><input class="filter" value=""><p class="recordList"></p></div>
<div id="divPawn" class="column"><h3 class="tableHead"><span class="tableHeadName">Pawn</span><span class="tableHeadSort">#^A^T^</span><span style="clear: both;"><br></span></h3><input class="filter" value=""><p class="recordList"></p></div>
<div id="divImage" class="column"><h3 class="tableHead"><span class="tableHeadName">Image</span><span class="tableHeadSort">#^A^T^</span><span style="clear: both;"><br></span></h3><input class="filter" value=""><p class="recordList"></p></div>
<div id="divEntry" class="column entryColumn"><h3 class="entryHead colorEntry">entry</h3><button type="button" name="Null" class="entryButton"></button><p class="recordInputs" onmouseover="onHoverInputRow()"><p></div>
</div>
<div class="row row2">
<div id="divAdventureMap" class="column"><h3 class="tableHead"><span class="tableHeadName">AdventureMap</span><span class="tableHeadSort">#^A^T^</span><span style="clear: both;"><br></span></h3><p class="recordList"></p> </div>
<div id="divDisplay" class="column"><h3 class="tableHead"><span class="tableHeadName">Display</span><span class="tableHeadSort">#^A^T^</span><span style="clear: both;"><br></span></h3><p class="recordList"></p></div>
<div id="divMapType" class="column"><h3 class="tableHead"><span class="tableHeadName">MapType</span><span class="tableHeadSort">#^A^T^</span><span style="clear: both;"><br></span></h3><p class="recordList"></p></div>
<div id="divNull" class="column"></div>
<div id="divRole" class="column"><h3 class="tableHead"><span class="tableHeadName">Role</span><span class="tableHeadSort">#^A^T^</span><span style="clear: both;"><br></span></h3><p class="recordList"></p></div>
<div id="divLocationTree" class="column"><h3 class="tableHead"><span class="tableHeadName">LocationTree</span><span class="tableHeadSort">#^A^T^</span><span style="clear: both;"><br></span></h3><p class="recordList"></p></div>
</div>

<div class="footer">
    <p>Footer</p>
</div>
<div class="previews"></div>

</body>
</html>


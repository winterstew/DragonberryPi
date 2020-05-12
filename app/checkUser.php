<?php

$uname = mysqli_real_escape_string($conn,$_POST['username']);
$password = mysqli_real_escape_string($conn,$_POST['password']);


if ($uname != "" && $password != ""){

    $sql_query = "SELECT count(*) as cntUser FROM User WHERE login='".$uname."' and password=CONCAT('{SHA}',to_base64(unhex(sha1('".$password."'))))";
    $result = mysqli_query($conn,$sql_query);
    $row = mysqli_fetch_array($result);

    $count = $row['cntUser'];

    if($count > 0){
        $_SESSION['uname'] = $uname;
        echo 1;
    }else{
        echo 0;
    }

}

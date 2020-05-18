<!doctype html>
<html>
    <head>
        <title>Login page</title>
        <link href="style.css" rel="stylesheet" type="text/css">

        <script src="jquery-3.5.1.js" type="text/javascript"></script>

        <script type="text/javascript">
            $(document).ready(function(){

                $("#but_submit").click(function (){
                    var username = $("#txt_uname").val().trim();
                    var password = $("#txt_pwd").val().trim();

                    if( username != "" && password != "" ){
                        // check if user login information is correct
                        $.ajax({
                            url:'checkUser',
                            type:'post',
                            data:{username:username,password:password},
                            success:function(result){
                                var msg = "";
                                var uinfo = JSON.parse(result);
                                if(uinfo['valid'] == true){
                                    // log in the now validated user (i.e. set session variables)
                                    $.ajax({
                                        url: "checkUser",
                                        type:'post',
                                        //async:false,
                                        //username:username,
                                        //password:password,
                                        //beforeSend: function (xhr) {
                                        //    // Authorization header 
                                        //    xhr.setRequestHeader("Authorization", "Basic " + btoa(username+":"+password));
                                        //    xhr.setRequestHeader("X-Mobile", "false");
                                        //},
                                        data:{username:username,password:password,login:true},
                                        success:function(result){
                                            // take us back now that we are logged in
                                            window.location.assign("https://" + username + ":" + password + "@" +
                                                        window.location.hostname + "/home" );
                                        }
                                    });
                                }else{
                                    msg = "Invalid username and/or password!";
                                    $.ajax({
                                        url:"fail",
                                        type:'get',
                                        //async:false,
                                        success:function(result){
                                            // take us back without logging in
                                            window.location = "/";
                                        }
                                    });
                                }
                                $("#message").html(msg);
                            }
                        });
                    }
                });
            });
        </script>
    </head>
    <body>
        <div class="bodyContainer">

            <div id="div_login">
                <h1>Login</h1>
                <div id="message"></div>
                <div>
                    <input type="text" class="textbox" id="txt_uname" name="txt_uname" placeholder="Username" />
                </div>
                <div>
                    <input type="password" class="textbox" id="txt_pwd" name="txt_pwd" placeholder="Password"/>
                </div>
                <div>
                    <input type="button" value="Submit" name="but_submit" id="but_submit" />
                </div>
            </div>

        </div>
    </body>
</html>


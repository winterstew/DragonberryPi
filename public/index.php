<!doctype html>
<html>
    <head>
        <title>Login page</title>
        <link href="loginstyle.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="container">

            <div id="div_login">
                <h1>Login</h1>
                <div id="message"></div>
                <form method="POST" action="/login" id="form_login">
                    <input type="text" class="textbox" id="txt_uname" name="httpd_username" placeholder="Username" />
                    <input type="password" class="textbox" id="txt_pwd" name="http_password" placeholder="Password"/>
                    <input type="submit" value="Login" name="login" id="but_submit" />
                    <!-- use this hidden form field to overide the apache login success location -->
                    <!-- <input type="hidden" name="http_location" value="/" /> -->
                </form>
            </div>

        </div>
    </body>
</html>


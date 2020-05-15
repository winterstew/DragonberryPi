<!doctype html>
<html>
    <head>
        <title>Home page</title>
        <link href="style.css" rel="stylesheet" type="text/css">

        <script src="jquery-3.5.1.js" type="text/javascript"></script>

        <script type="text/javascript">
            $(document).ready(function(){
                $("#but_about").click(function(){
                    window.location = "/about";
                });

                $("#but_logout").click(function(){
                    $(document).ajaxComplete(function(){
                        window.location = "/";
                    });
                    $.ajax({
                        url:"logout",
                        //async:false,
                        type:'post'
                    });
                });

                $("#options").append("<a href='/images/Monsters/goblin.png'>Goblin</a>");
            });
        </script>
    </head>
    <body>
        <div class="container">

            <div id="div_logout">
                <h1>Logout</h1>
                <div id="message"></div>
                <div id="options">
                </div>
                <div>
                    <input type="button" value="About" name="but_about" id="but_about" />
                </div>
                <div>
                    <input type="button" value="Logout" name="but_logout" id="but_logout" />
                </div>
            </div>

        </div>
    </body>
</html>

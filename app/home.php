<!doctype html>
<html>
    <head>
        <title>Adventure Home Page</title>
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
            });
        </script>
    </head>
    <body>
        <div class="bodyContainer">
				<div class="title">Welcome to <span class="database">DragonberryPi</span>, <span class="User.name">User</span>!</div>
				<div class="subtitle">What would you like to do?</div>
				<div class="adventureContainer"><div class="heading">Join an adventure</div>
					<p class="adventureList"></p>			
				</div>
				<div class="preferenceContainer"><div class="heading">Edit your preferences</div>
					<p class="preferenceList"></p>			
				</div>
				<div class="userContainer"><div class="heading">Update Users</div>
					<p class="userList"></p>			
				</div>
            <div class="logoutContainer"><div class="heading">Logout</div>
                <div id="message"></div>
                <div id="options"></div>
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

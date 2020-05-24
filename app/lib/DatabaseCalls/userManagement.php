<?php

namespace AppLib\DatabaseCalls;

class userManagement
{

    public function __construct($conn,$uname,$pass,$logger)
    {
        $this->conn = $conn;
        $this->uname = mysqli_real_escape_string($conn,$uname);
        $this->pass = mysqli_real_escape_string($conn,$pass);
        $this->logger = $logger;
        $this->uinfo = array();
    }

	// This function determines if a user is logged in based on the database and hence,
	// if used as part of AJAX updates provides a means for the administrator to force a logout
    public function isLoggedIn()
    {
        if ($this->uname != "") {
            $sql_query = "SELECT idUser FROM ValidUser WHERE user='" . $this->uname . "';";
            $result = $this->conn->query($sql_query);
            if ($result->num_rows == 1) {
                return true;
            }
        }
        return false;
    }

    public function isAdmin()
    {
        if ($this->uname != "") {
            $sql_query = "SELECT type FROM ValidUser WHERE user='" . $this->uname . "' AND type LIKE 'admin%';";
            $result = $this->conn->query($sql_query);
            if ($result->num_rows == 1) {
                return true;
            }
        }
        return false;
    }

    public function isValid()
    {
        if ($this->uname != "" && $this->pass != ""){
            $sql_query = "SELECT hash FROM ValidUser WHERE user='" . $this->uname . "';";
            $result = $this->conn->query($sql_query);
            if ($result->num_rows == 1) {
                $row = $result->fetch_assoc();
                if (password_verify($this->pass,$row['hash'])) {
                    $this->logger->info($this->uname . " is a valid user with correct password");
                    // set the user info, for the validated user
                    $this->uinfo = $this->conn->query("SELECT * FROM ValidUser WHERE user='" . $this->uname ."';")->fetch_assoc();
                    $this->uinfo['valid']=true;
                    return true;
                } else {
                    $this->logger->info($this->uname . " is a valid user with WRONG password");
                }
            } else {
                $this->logger->info($this->uname . " is not a valid user");
            }
        } else {
            $this->logger->info("username and/or password is missing");
        }
        $this->uinfo['valid']= false;
        return false;
    }

    public function login()
    {
        if ($this->uname != "" && $this->pass != ""){
            $result = false;
            $sql_select = "SELECT user FROM ValidUser WHERE login=True and user = '" . $this->uname . "'";
            if ($this->conn->query($sql_select)->num_rows == 1) {
                //user already logged in
                $this->logger->info($this->uname . " was already logged in");
                $result = true;
            } else {
                $sql_update = "UPDATE User SET login=True WHERE user = '" . $this->uname . "';";
                if ($this->conn->query($sql_update)){
                    //user changed from logged out to logged in
                    $this->logger->info($this->uname . " has now logged in");
                    $result = true;
                } else {
                    $this->logger->info($this->uname . " failed to log in");
                }
            }
            if ($result) {
                $_SESSION['uname'] = $this->uname;
                $_SESSION['pass'] = $this->pass;
                $_SESSION['idUser'] = $this->uinfo['idUser'];
                $_SESSION['userType'] = $this->uinfo['type'];
                $this->logger->info("session variables set for user and password");
                return true;
            }
        }
        return false;
    }

    public function logout()
    {
        if ($this->uname != "" && $this->pass != ""){
            $result = false;
            $sql_select = "SELECT user FROM ValidUser WHERE login=False and user = '" . $this->uname . "'";
            if ($this->conn->query($sql_select)->num_rows == 1) {
                //user already logged out
                $this->logger->info($this->uname . " was already logged out");
                $result = true;
            } else {
                $sql_update = "UPDATE User SET login=False WHERE user = '" . $this->uname . "';";
                if ($this->conn->query($sql_update)){
                    //user changed from logged in to logged out
                    $this->logger->info($this->uname . " has now logged out");
                    $result = true;
                } else {
                    $this->logger->info($this->uname . " failed to log out");
                }
            }
            if ($result) {
                session_unset();
                session_destory();
                $this->logger->info("session variables unset and session destroyed");
                return true;
            }
        }
        return false;
    }
}


<?php
	//get values passed from form in login.php file
	//to prevent mysql injection


echo"<body bgcolor='black'>";

	//connect to the server and select database
	extract($_POST);
$host="localhost"; // Host name 
$username = "niki";
$password = "Be62CvBUERPBxsEL";
$db = "pizzadb";
$con=mysqli_connect("$host", "$username", "$password","$db") or die ("cannot connect"); 
$tbl="customer";
	//Query the database for user
	//$user=mysqli_real_escape_string($con,$user);
	//$pass=mysqli_real_escape_string($con,$pass);
   
  /* $ee = "INSERT INTO $tbl (username, password)
VALUES ('$user', '$pass')";

if ($con->query($ee) === TRUE) {
    echo "YOUR VIEW HAS BEEN POSTED!";}*/
    echo "</body>";
    if($user=="" || $pass=="")
    { echo "<script type='text/javascript'>"; 
echo "alert('TRY AGAIN');"; 
echo "window.location.href = 'login.html';";
echo "</script>";

    }
	$result=mysqli_query($con,"SELECT * FROM $tbl  WHERE username ='$user' AND password='$pass'")
	or die("Failed to query database".mysqli_error($con));
     

	if (mysqli_num_rows($result) > 0) {
		echo "<script type='text/javascript'>"; 
echo "alert('LOGIN SUCCESSFUL!');"; 
echo "window.location.href = 'home2.html';";
echo "</script>";
	}
	else{
		echo "<script type='text/javascript'>"; 
echo "alert('TRY AGAIN');"; 
echo "window.location.href = 'login.html';";
echo "</script>";
	
	}

  

	mysqli_close($con);
?>


<!DOCTYPE html>
<html>
<head>
	<title>Logging in..</title>
</head>
<body bgcolor="black">

</body>
</html>
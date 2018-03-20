
<!DOCTYPE html>
<html>
<head>
	<title>Almost there..</title>

<?php
	//get values passed from form in login.php file
	//to prevent mysql injection
echo "<body bgcolor='black'>";


	//connect to the server and select database
	extract($_POST);
$host="localhost"; // Host name 
$username = "niki";
$password = "Be62CvBUERPBxsEL";
$db = "pizzadb";
$con=mysqli_connect("$host", "$username", "$password","$db")or die("cannot connect"); 
$tbl="customer";

 $ee = "INSERT INTO $tbl (username, password, email_id, phone_no, address, name,gender,date_of_birth)
VALUES ('$user', '$pass', '$email', '$number', '$addr', '$name', '$gender','$dob')";


//$tbl2="userinfo";
//$rr="INSERT INTO $tbl2 (username1, password1,email)
//VALUES ('$user', '$pass','$email')";
//mysqli_query($con,$rr);
$result=mysqli_query($con,"SELECT * FROM customer WHERE phone_no ='$number'")
	or die("Failed to query database".mysqli_error($con));
     

	if (mysqli_num_rows($result) ==1) {
		echo "<script type='text/javascript'>"; 
echo "alert('This phone number already exists, please login');"; 
echo "window.location.href = 'login.html';";
echo "</script>";
}
else { mysqli_query($con,$ee);
echo "<script type='text/javascript'>"; 
echo "alert('REGISTER SUCCESSFUL!');"; 
echo "window.location.href = 'login.html';";
echo "</script>";
}
echo "</body>";


	mysqli_close($con);
?>
</head>
</html>
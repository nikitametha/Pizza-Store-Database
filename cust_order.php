<?php

$host="localhost"; // Host name 
$username = "niki";
$password = "Be62CvBUERPBxsEL";
$db = "pizzadb";
$con=mysqli_connect("$host", "$username", "$password","$db")or die("cannot connect"); 
$tbl="customer";

echo " <html>
 <head>
 <title>CUSTOMER DETAILS </title>  
 <link rel=\"stylesheet\" type=\"text/css\" href=\"cust_order_css.css\">
  </head>
 <body>
    <center><h1 id=\"head\">YOUR DETAILS</h1></center>
<div class=\"outborder\">";
$ph="9916490504";
  $sql = "SELECT * FROM customer WHERE phone_no='$ph'";
$result = $con->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<div class='inner'> <b>NAME:</b>  ". $row["name"]. "<br> </div>";
        echo "<div class='inner'>  <b>USERNAME:</b>  ". $row["username"]. "<br></div>";
        echo " <div class='inner'> <b>PHONE NUMBER:</b>  ". $row["phone_no"]. "<br></div>";
        echo "<div class='inner'>  <b>EMAIL ID:</b>  ". $row["email_id"]. "<br></div>";
        echo "<div class='inner'>  <b>DOB:</b>  " . $row["date_of_birth"]. "<br></div>";
        echo " <div class='inner'> <b>ADDRESS:</b>  ".$row["address"]. "<br></div>";
    }
}
echo "
</div>
" ;

/*--------------------------------------------------------------------------*/
echo "<br><br> <p> YOUR PREVIOUS ORDERS </p>";
echo"<div class=\"outborder2\">";
//$ph="8679201113";

  $sql = "SELECT * FROM orders WHERE cust_ph_no='$ph'";
$result = $con->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
    	echo "<div class='outer'>";
    	$ord=$row["order_id"];
        echo "<div class='inner2'> <b>ORDER ID:</b>  ". $ord. "<br> </div>";
        echo "<div class='inner2'>  <b>IN TIME:</b>  ". $row["in_time"]. "<br></div>";
        echo "<div class='inner2'>  <b>OUT TIME:</b>  " . $row["out_time"]. "<br></div>";
        echo " <div class='inner2'> <b>TOTAL COST:</b>  ".$row["total_cost"]. "<br></div>";
        echo " <div class='inner2'> <b>PLACED AT BRANCH:</b>  ".$row["b_address"]. "<br></div>";

        $sql2= "SELECT * FROM pizza,pizza_placed_for WHERE o_id='$ord' AND p_id=pizza_id";
		$result2 = $con->query($sql2);

if ($result2->num_rows > 0) {
    while($row2 = $result2->fetch_assoc()) { 
    	echo "<div class=\"outer2\" id='outerr'>";
        echo "<div class='inner3'> <b>PIZZA NAME: </b>  ". $row2["pizza_name"]. "<br> </div>";
        echo "<div class='inner3'>". $row2["description"]. "<br></div>";
        echo " <div class='inner3'> <b>SIZE: </b>  ". $row2["sizes"]. "<br></div>";
        echo "<div class='inner3'>  <b>VEG/NONVEG: </b>  ". $row2["veg_non_veg"]. "<br></div>";
        echo "<div class='inner3'>  <b>TYPE: </b>  " . $row2["type"]. "<br></div>";
        echo " <div class='inner3'> <b>QUANTITY: </b>  ".$row2["quantity"]. "<br></div>";
        echo "</div>";
    }  
    
}	


$sql3= "SELECT * FROM sides_desserts_drinks s ,sides_placed_for sp WHERE sp.o_id='$ord' AND s.item_id=sp.item_id";
		$result3 = $con->query($sql3);

if ($result3->num_rows > 0) {
    while($row3 = $result3->fetch_assoc()) { echo "<div class=\"outer2\" id='outerr'>";
        echo "<div class='inner3'> <b>SIDE NAME: </b>  ". $row3["item_name"]. "<br> </div>";
        echo "<div class='inner3'>". $row3["description"]. "<br></div>";
        echo "<div class='inner3'>  <b>VEG/NONVEG: </b>  ". $row3["veg_non_veg"]. "<br></div>";
      echo "</div>";  
    } 
}
   echo"</div>";
   }
}
else echo "YOU HAVE NO PREVIOUS ORDERS! ORDER NOW";
echo "</div>" ;

mysqli_close($con);
?>
<?php
include "config.php";
$name=$_POST['name'];
$price=$_POST['price'];
$availability=$_POST['availability'];
$description=$_POST['description'];
if($name!="" && $price!=""){
$sql="INSERT INTO cat (name,price,availability,description) VALUES ('$name','$price','$availability','$description');";
if($con->query($sql)){
echo "true";
}else
{
echo "false";
}
}
?>

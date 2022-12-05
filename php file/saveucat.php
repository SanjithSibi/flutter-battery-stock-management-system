<?php
include "config.php";
$name=$_POST['name'];
$price=$_POST['price'];
$description=$_POST['description'];
if($name!="" && $price!=""){
$sql="INSERT INTO ucat (name,price,description) VALUES ('$name','$price','$description');";
if($con->query($sql)){
echo "true";
}else
{
echo "false";
}
}
?>
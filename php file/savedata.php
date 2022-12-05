<?php
include "config.php";
$name=$_POST['name'];
$email=$_POST['email'];
if($name!="" && $email!=""){
$sql="INSERT INTO users (name,email) VALUES ('$name','$email');";
if($con->query($sql)){
echo "true";
}else
{
echo "false";
}
}
?>

<?php
include "config.php";
$name=$_POST['name'];
$email=$_POST['email'];
$id=$_POST['id'];
if($name!="" && $email!=""){
$sql="UPDATE users SET name='$name',email='$email' WHERE id='$id';";
if($con->query($sql)){
echo "true";
}else
{
echo "false";
}
}
?>

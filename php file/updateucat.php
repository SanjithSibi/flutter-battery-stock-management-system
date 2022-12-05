<?php
include "config.php";
$name=$_POST['name'];
$price=$_POST['price'];
$description=$_POST['description'];
$id=$_POST['id'];
if($name!="" && $price!=""){
$sql="UPDATE ucat SET name='$name',price='$price',description='$description' WHERE id='$id';";
if($con->query($sql)){
echo "true";
}else
{
echo "false";
}
}
?>
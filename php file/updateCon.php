<?php
include "config.php";
$name=$_POST['name'];
$price=$_POST['price'];
$availability=$_POST['availability'];
$description=$_POST['description'];
$id=$_POST['id'];
if($name!="" && $price!=""){
$sql="UPDATE cat SET name='$name',price='$price',availability='$availability',description='$description' WHERE id='$id';";
if($con->query($sql)){
echo "true";
}else
{
echo "false";
}
}
?>

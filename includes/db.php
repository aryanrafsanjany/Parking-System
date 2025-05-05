<?php
$host = "localhost";
$user = "root";
$password = ""; // keep it blank for XAMPP
$dbname = "Project_2.0";

$conn = new mysqli($host, $user, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>

<?php
session_start();
include('../includes/db.php');

if (!isset($_SESSION['user_id']) || !isset($_GET['location_id'])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];
$location_id = $_GET['location_id'];

// Get user's booking count
$count_result = $conn->query("SELECT COUNT(*) AS count FROM BOOKING WHERE user_id = $user_id");
$count = $count_result->fetch_assoc()['count'];

// Determine free parking
$free_parking = ($count + 1) % 10 == 0 ? 1 : 0;

// Get location data
$loc = $conn->query("SELECT available_spot FROM PARKING_LOCATION WHERE location_id = $location_id")->fetch_assoc();
if ($loc['available_spot'] <= 0) {
    echo "No spots available. <a href='dashboard.php'>Go back</a>";
    exit();
}

// Insert booking
$stmt = $conn->prepare("INSERT INTO BOOKING (arrival_time, payment, free_parking, user_id, location_id) 
                        VALUES (NULL, ?, ?, ?, ?)");
$payment = $free_parking ? 0.00 : 50.00; // example price
$stmt->bind_param("diii", $payment, $free_parking, $user_id, $location_id);
$stmt->execute();

// Update available spot
$conn->query("UPDATE PARKING_LOCATION SET available_spot = available_spot - 1 WHERE location_id = $location_id");

header("Location: dashboard.php");
exit();
?>

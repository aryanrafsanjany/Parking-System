<?php
session_start();
include('../includes/db.php');

if (!isset($_SESSION['user_id']) || !isset($_GET['id'])) {
    header("Location: login.php");
    exit();
}

$booking_id = $_GET['id'];
$user_id = $_SESSION['user_id'];

$booking = $conn->query("SELECT * FROM BOOKING WHERE booking_id = $booking_id AND user_id = $user_id")->fetch_assoc();
if (!$booking || $booking['status'] !== 'active') {
    echo "Invalid booking or already cancelled. <a href='dashboard.php'>Back</a>";
    exit();
}

$conn->query("UPDATE BOOKING SET status = 'cancelled' WHERE booking_id = $booking_id");

$conn->query("UPDATE PARKING_LOCATION SET available_spot = available_spot + 1 WHERE location_id = " . $booking['location_id']);

header("Location: dashboard.php");
exit();
?>

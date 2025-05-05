<?php
session_start();
include('../includes/db.php');

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

if (!isset($_GET['area_id'])) {
    header("Location: dashboard.php");
    exit();
}

$area_id = $_GET['area_id'];

$area_stmt = $conn->prepare("SELECT area_name FROM AREA WHERE area_id = ?");
$area_stmt->bind_param("i", $area_id);
$area_stmt->execute();
$area_result = $area_stmt->get_result()->fetch_assoc();

$location_stmt = $conn->prepare("SELECT * FROM PARKING_LOCATION WHERE area_id = ?");
$location_stmt->bind_param("i", $area_id);
$location_stmt->execute();
$locations = $location_stmt->get_result();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Locations - <?= $area_result['area_name'] ?></title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h2><?= $area_result['area_name'] ?> - Available Parking Locations</h2>
        <?php while ($row = $locations->fetch_assoc()): ?>
            <div style="border:1px solid #ccc; padding:10px; margin-bottom:10px;">
                <h3><?= $row['mall_name'] ?></h3>
                <p><strong>Address:</strong> <?= $row['address'] ?></p>
                <p><strong>Available Spots:</strong> <?= $row['available_spot'] ?>/<?= $row['total_spot'] ?></p>
                <?php if ($row['available_spot'] > 0): ?>
                    <a href="book.php?location_id=<?= $row['location_id'] ?>">Book Now</a>
                <?php else: ?>
                    <p style="color:red;">No spots available</p>
                <?php endif; ?>
            </div>
        <?php endwhile; ?>
        <a href="dashboard.php">Back to Dashboard</a>
    </div>
</body>
</html>

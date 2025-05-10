<?php
session_start();
include('../includes/db.php');

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];

if (isset($_GET['complete_id'])) {
    $booking_id = intval($_GET['complete_id']);
    $conn->query("UPDATE BOOKING SET status = 'completed' WHERE booking_id = $booking_id AND user_id = $user_id");

    $conn->query("UPDATE USER SET points = points + 1 WHERE user_id = $user_id");
}

$user_result = $conn->query("SELECT * FROM USER WHERE user_id = $user_id");
$user = $user_result->fetch_assoc();

$area_result = $conn->query("SELECT * FROM AREA");

$booking_result = $conn->query("SELECT b.*, p.mall_name, p.address FROM BOOKING b 
    JOIN PARKING_LOCATION p ON b.location_id = p.location_id 
    WHERE b.user_id = $user_id ORDER BY booking_time DESC LIMIT 1");

$booking = $booking_result->fetch_assoc();

?>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Dhaka Mall Parking System</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h2>Welcome, <?= htmlspecialchars($user['Fname']) ?>!</h2>
        <p><strong>Your Points:</strong> <?= $user['points'] ?></p>

        <hr>
        <h3>Select Area to Book</h3>
        <form method="GET" action="area.php">
            <select name="area_id" required>
                <option value="">Choose Area</option>
                <?php while ($row = $area_result->fetch_assoc()) {
                    echo "<option value='{$row['area_id']}'>{$row['area_name']}</option>";
                } ?>
            </select>
            <br>
            <button type="submit">View Locations</button>
        </form>

        <hr>
        <h3>Your Latest Booking</h3>
        <?php if ($booking): ?>
            <p><strong>Mall:</strong> <?= $booking['mall_name'] ?></p>
            <p><strong>Status:</strong> <?= $booking['status'] ?></p>
            <p><strong>Booked At:</strong> <?= $booking['booking_time'] ?></p>
            <p><strong>Free Parking:</strong> <?= $booking['free_parking'] ? 'Yes' : 'No' ?></p>

            <?php
                $address = $booking['address'];
                $map_link = "https://www.google.com/maps/search/?api=1&query=" . urlencode($address);
            ?>
            <p>
                <a href="<?= $map_link ?>" target="_blank">🗺️ Show Location on Map</a>
            </p>

            <?php if ($booking['status'] === 'active'): ?>
                <p><strong>Cancel:</strong> 
                    <a href="cancel.php?id=<?= $booking['booking_id'] ?>">Manual Cancel</a>
                </p>
                <p><strong>Complete:</strong> 
                    <a href="dashboard.php?complete_id=<?= $booking['booking_id'] ?>">Mark as Completed</a>
                </p>
            <?php endif; ?>

        <?php else: ?>
            <p>No recent bookings found.</p>
        <?php endif; ?>


        <a href="../logout.php" style="float:right;">Logout</a>
    </div>
</body>
</html>


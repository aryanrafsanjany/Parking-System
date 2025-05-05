<?php
// Log cron run
file_put_contents(__DIR__ . "/cron_log.txt", "Cron ran at " . date("Y-m-d H:i:s") . "\n", FILE_APPEND);

// Include database connection
include __DIR__ . '/../includes/db.php';

// Run only if connection is successful
if (!$conn) {
    file_put_contents(__DIR__ . "/cron_log.txt", "DB connection failed\n", FILE_APPEND);
    exit;
}

// Get bookings older than 1 hour and still active
$result = $conn->query("
    SELECT booking_id, location_id 
    FROM BOOKING 
    WHERE status = 'active' 
    AND TIMESTAMPDIFF(MINUTE, booking_time, NOW()) > 60
");

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $booking_id = $row['booking_id'];
        $location_id = $row['location_id'];

        // Cancel booking
        $conn->query("UPDATE BOOKING SET status = 'expired' WHERE booking_id = $booking_id");

        // Free up the spot
        $conn->query("UPDATE PARKING_LOCATION SET available_spot = available_spot + 1 WHERE location_id = $location_id");
    }
} else {
    file_put_contents(__DIR__ . "/cron_log.txt", "Query failed: " . $conn->error . "\n", FILE_APPEND);
}
?>

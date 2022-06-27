<?php
// required headers
header('Content-Type: application/json');
// include database and object files
include_once 'connection.php';
$query = "Select * FROM t_user";
$result = mysqli_query($conn, $query);
$row = mysqli_fetch_all($result, MYSQLI_ASSOC);
http_response_code(200);
echo json_encode($row);
?>

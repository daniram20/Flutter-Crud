<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');
// include database and object files
include_once 'connection.php';
$data = json_decode(file_get_contents('php://input'), true);
if (!isset($data['password']) && !isset($data['email']) &&
!isset($data['name']))
 die(); // receiving the post params
else
{
 $email = $data['email'];
 $password = $data['password'];
 $name = $data['name'];

 $query = "Select email FROM t_user WHERE `email` = '$email' or `name` =
'$name'";
 $result = mysqli_query($conn, $query);

 $row = mysqli_fetch_assoc($result);
 if ($row != null){
 $response['status'] = 0;
 $response['message'] = "Email sudah terdaftar, silahkan login
menggunakan email " . $row["email"];
 http_response_code(201);
 echo json_encode($response);
 return;
 }
 else {
 $query = "INSERT INTO t_user(name, email, password) VALUES (
'$name', '$email', '$password')";
 if ($conn->query($query) === TRUE){
 $conn->close();
 $response['status'] = 0;
 $response['message'] = "Register User baru telah berhasil
didaftarkan";
 http_response_code(200);
 echo json_encode($response);
 }
 else {
 $conn->close();
 $response['status'] = 1;
 $response['message'] = "Register User baru gagal";
 http_response_code(404);
 echo json_encode($response);
 }
 }

}
?>

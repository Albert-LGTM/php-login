<?php
$server = getenv('DB_SERVER');
$username = getenv('DB_USER');
$password = getenv('DB_PASSWORD');
$database = getenv('DB_NAME');

try {
    $conn = new PDO("mysql:host=$server;dbname=$database;charset=utf8mb4", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e){
    header($_SERVER['SERVER_PROTOCOL'] . ' 500 Internal Server Error');
    echo "Database connection failed: " . $e->getMessage();
    die();
}

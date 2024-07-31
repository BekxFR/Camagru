<?php
session_start();
require_once __DIR__ . '/api/config/config.php';

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method Not Allowed']);
    exit;
}

if (isset($_FILES['photo'])) {
    $uploadDir = '../uploads/';
    $uploadFile = $uploadDir . basename($_FILES['photo']['name']);
    
    if (move_uploaded_file($_FILES['photo']['tmp_name'], $uploadFile)) {
        echo json_encode(['success' => true, 'message' => 'Photo uploaded successfully']);
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to upload file']);
    }
} else {
    http_response_code(400);
    echo json_encode(['error' => 'No file uploaded']);
}

?>
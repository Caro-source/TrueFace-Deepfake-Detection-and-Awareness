<?php
// Tell the browser we're sending JSON, not HTML
header('Content-Type: application/json');

// Build a small PHP array and turn it into JSON text
echo json_encode([
    'status' => 'ok',
    'php_version' => PHP_VERSION,
    'time' => date('Y-m-d H:i:s'),
]);
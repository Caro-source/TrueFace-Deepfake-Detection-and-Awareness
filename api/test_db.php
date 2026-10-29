<?php
require __DIR__ . '/db.php';

try {
    $count = get_db()->query('SELECT COUNT(*) FROM images')->fetchColumn();
    send_json(['status' => 'ok', 'images' => (int) $count]);
} catch (PDOException $e) {
    send_json(['status' => 'error', 'message' => $e->getMessage()], 500);
}
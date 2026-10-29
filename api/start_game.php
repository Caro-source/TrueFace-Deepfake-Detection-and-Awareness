<?php
require __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    send_json(['error' => 'Use POST'], 405);
}

// Read the JSON the browser sent, e.g. {"nickname":"Peter Parker"}
$body = json_decode(file_get_contents('php://input'), true) ?? [];
$nickname = trim($body['nickname'] ?? '');

if ($nickname === '' || mb_strlen($nickname) > 50) {
    send_json(['error' => 'Nickname must be 1 to 50 characters'], 400);
}

$db = get_db();
$stmt = $db->prepare('INSERT INTO players (nickname) VALUES (?)');
$stmt->execute([$nickname]);

send_json(['player_id' => (int) $db->lastInsertId()]);
<?php
require __DIR__ . '/db.php';

// 10 random images. This only has the id and filename, NOT whether it's fake,
// so players can't cheat by looking at the data.
$rows = get_db()
    ->query('SELECT id, filename FROM images ORDER BY RAND() LIMIT 10')
    ->fetchAll();

send_json($rows);
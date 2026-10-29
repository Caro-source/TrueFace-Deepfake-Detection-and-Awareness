<?php
require __DIR__ . '/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    send_json(['error' => 'Use POST'], 405);
}

$body = json_decode(file_get_contents('php://input'), true) ?? [];
$playerId    = (int) ($body['player_id'] ?? 0);
$imageId     = (int) ($body['image_id'] ?? 0);
$roundNumber = (int) ($body['round_number'] ?? 0);
$guessedFake = !empty($body['guessed_fake']) ? 1 : 0;

if ($playerId < 1 || $imageId < 1 || $roundNumber < 1) {
    send_json(['error' => 'Missing player_id, image_id or round_number'], 400);
}

$db = get_db();

// Look up the truth for this image
$stmt = $db->prepare('SELECT is_fake, model_guess_fake, model_confidence, tip FROM images WHERE id = ?');
$stmt->execute([$imageId]);
$image = $stmt->fetch();

if (!$image) {
    send_json(['error' => 'Image not found'], 404);
}

$isFake    = (int) $image['is_fake'];
$isCorrect = ($isFake === $guessedFake) ? 1 : 0;

// Save the guess
$stmt = $db->prepare(
    'INSERT INTO guesses (player_id, image_id, round_number, guessed_fake, is_correct)
     VALUES (?, ?, ?, ?, ?)'
);
$stmt->execute([$playerId, $imageId, $roundNumber, $guessedFake, $isCorrect]);

// The model columns stay empty (NULL) until Phase 6
$modelGuess = $image['model_guess_fake'] === null ? null : (int) $image['model_guess_fake'];

send_json([
    'is_fake'          => $isFake,
    'is_correct'       => $isCorrect,
    'model_guess_fake' => $modelGuess,
    'model_correct'    => $modelGuess === null ? null : (int) ($modelGuess === $isFake),
    'model_confidence' => $image['model_confidence'] === null ? null : (float) $image['model_confidence'],
    'tip'              => $image['tip'],
]);
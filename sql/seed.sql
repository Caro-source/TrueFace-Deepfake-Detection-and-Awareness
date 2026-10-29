USE trueface;

INSERT INTO images (filename, is_fake, tip, source) VALUES
  ('test_real_1.jpg', 0, 'Natural skin texture and matching earrings.', 'test'),
  ('test_fake_1.jpg', 1, 'Look at the left ear: the shape melts into the hair.', 'test'),
  ('test_fake_2.jpg', 1, 'The background lines bend around the head.', 'test');

INSERT INTO players (nickname) VALUES ('tester');

-- tester guessed image 1 was fake (wrong) and image 2 was fake (right)
INSERT INTO guesses (player_id, image_id, round_number, guessed_fake, is_correct) VALUES
  (1, 1, 1, 1, 0),
  (1, 2, 2, 1, 1);
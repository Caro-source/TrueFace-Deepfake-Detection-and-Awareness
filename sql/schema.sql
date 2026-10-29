CREATE DATABASE IF NOT EXISTS trueface
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE trueface;

-- Faces shown in the game
CREATE TABLE images (
  id INT AUTO_INCREMENT PRIMARY KEY,
  filename VARCHAR(255) NOT NULL,
  is_fake TINYINT(1) NOT NULL,              -- 1 = AI-generated, 0 = real photo
  model_guess_fake TINYINT(1) NULL,         -- filled in Phase 6
  model_confidence DECIMAL(5,2) NULL,       -- e.g. 87.50 (percent)
  tip TEXT NOT NULL,                        -- the giveaway shown after the round
  source VARCHAR(255) NOT NULL,             -- where the image came from
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- One row per person playing
CREATE TABLE players (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nickname VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Every guess a player makes
CREATE TABLE guesses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  player_id INT NOT NULL,
  image_id INT NOT NULL,
  round_number INT NOT NULL,                -- 1 for the first image, 2 for the next...
  guessed_fake TINYINT(1) NOT NULL,
  is_correct TINYINT(1) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE,
  FOREIGN KEY (image_id) REFERENCES images(id) ON DELETE CASCADE
);

-- Every image checked on the Detector page
CREATE TABLE detections (
  id INT AUTO_INCREMENT PRIMARY KEY,
  score DECIMAL(5,2) NOT NULL,              -- percent likely AI-generated
  label VARCHAR(30) NOT NULL,               -- 'likely real' or 'likely AI-generated'
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
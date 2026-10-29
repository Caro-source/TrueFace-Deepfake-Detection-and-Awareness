USE trueface;

-- Remove the test rows from Phase 2 (guesses first, because they point at players and images)
DELETE FROM guesses;
DELETE FROM players;
DELETE FROM images;

-- Start the id numbers from 1 again
ALTER TABLE guesses AUTO_INCREMENT = 1;
ALTER TABLE players AUTO_INCREMENT = 1;
ALTER TABLE images AUTO_INCREMENT = 1;

INSERT INTO images (filename, is_fake, tip, source) VALUES
  ('real_01.jpg', 0, 'The skin has natural pores and small imperfections.', 'Kaggle 140k Real and Fake Faces (FFHQ)'),
  ('real_02.jpg', 0, 'Both eyes reflect the same light source.', 'Kaggle 140k Real and Fake Faces (FFHQ)'),
  ('real_03.jpg', 0, 'Individual hair strands separate cleanly from the background.', 'Kaggle 140k Real and Fake Faces (FFHQ)'),
  ('real_04.jpg', 0, 'Clothes are consistent and well-fitted.Hair strands are separated.', 'Kaggle 140k Real and Fake Faces (FFHQ)'),
  ('real_05.jpg', 0, 'The teeth are separate and evenly shaped.', 'Kaggle 140k Real and Fake Faces (FFHQ)'),
  ('real_06.jpg', 0, 'Both eyes reflect the same light source and hand is properly positioned.', 'Kaggle 140k Real and Fake Faces (FFHQ)'),
  ('real_07.jpg', 0, 'The shadows on the face match the light in the scene.', 'Kaggle 140k Real and Fake Faces (FFHQ)'),
  ('real_08.jpg', 0, 'Background elements are consistent and ears are symmetrical.', 'Kaggle 140k Real and Fake Faces (FFHQ)'),
  ('real_09.jpg', 0, 'Teeth are separate and evenly shaped, and light reflecting match eye positions.', 'Kaggle 140k Real and Fake Faces (FFHQ)'),
  ('real_10.jpg', 0, 'The edge of the face is sharp against the background.', 'Kaggle 140k Real and Fake Faces (FFHQ)'),
  ('fake_01.jpg', 1, 'The background melts into blurry, warped shapes.', 'Kaggle 140k Real and Fake Faces (StyleGAN)'),
  ('fake_02.jpg', 1, 'The teeth are overly white or have an unnatural shine. Hair strands are not separated.', 'Kaggle 140k Real and Fake Faces (StyleGAN)'),
  ('fake_03.jpg', 1, 'The background is overly smooth; has an unnatural look and ears are asymmetrical.', 'Kaggle 140k Real and Fake Faces (StyleGAN)'),
  ('fake_04.jpg', 1, 'The earrings do not match; one is just a blob. One eye has eyeliner, and background is inconsistent.', 'Kaggle 140k Real and Fake Faces (StyleGAN)'),
  ('fake_05.jpg', 1, 'The reflections in the two eyes are different shapes.Ears are asymmetrical and only one earring is visible.', 'Kaggle 140k Real and Fake Faces (StyleGAN)'),
  ('fake_06.jpg', 1, 'The skin is too smooth, almost like plastic. Eyebrows are asymmetrical, teeth are inconsistent. Bottom lip is unnatural.', 'Kaggle 140k Real and Fake Faces (StyleGAN)'),
  ('fake_07.jpg', 1, 'The eyes dont reflect the same light source and bangs are warped.', 'Kaggle 140k Real and Fake Faces (StyleGAN)'),
  ('fake_08.jpg', 1, 'Hair has an unnatural look or is poorly rendered. Background is inconsistent.', 'Kaggle 140k Real and Fake Faces (StyleGAN)'),
  ('fake_09.jpg', 1, 'Hair is poorly rendered. One hoop is on one asymmetrical ear.', 'Kaggle 140k Real and Fake Faces (StyleGAN)'),
  ('fake_10.jpg', 1, 'Eyebrows are asymmetrical, hair is poorly rendered. Teeth are inconsistent. Earrings are different.', 'Kaggle 140k Real and Fake Faces (StyleGAN)');
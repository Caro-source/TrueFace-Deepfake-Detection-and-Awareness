// ---------- Settings ----------
const IMAGE_FOLDER = 'assets/images/game/';

// ---------- Game state (changes while you play) ----------
let playerId = null;   // the id start_game.php gives us
let images = [];       // the 10 images from get_images.php
let round = 0;         // which image we're on: 0 is the first
let humanScore = 0;
let aiScore = 0;

// ---------- Elements on the page ----------
const startScreen = document.getElementById('startScreen');
const gameScreen = document.getElementById('gameScreen');
const endScreen = document.getElementById('endScreen');
const nicknameInput = document.getElementById('nickname');
const startBtn = document.getElementById('startBtn');
const roundNum = document.getElementById('roundNum');
const humanScoreEl = document.getElementById('humanScore');
const aiScoreEl = document.getElementById('aiScore');
const gameImage = document.getElementById('gameImage');
const guessButtons = document.getElementById('guessButtons');
const guessRealBtn = document.getElementById('guessReal');
const guessFakeBtn = document.getElementById('guessFake');
const reveal = document.getElementById('reveal');
const revealText = document.getElementById('revealText');
const tipText = document.getElementById('tipText');
const nextBtn = document.getElementById('nextBtn');
const finalHuman = document.getElementById('finalHuman');
const finalAi = document.getElementById('finalAi');
const playAgainBtn = document.getElementById('playAgainBtn');

// ---------- Helpers ----------

// Sends data to a PHP file as JSON and returns its JSON reply
async function postJson(url, data) {
  const response = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data),
  });
  return response.json();
}

// Hides all three screens, then shows the one we want
function showScreen(screen) {
  startScreen.classList.add('hidden');
  gameScreen.classList.add('hidden');
  endScreen.classList.add('hidden');
  screen.classList.remove('hidden');
}

function updateScoreboard() {
  roundNum.textContent = round + 1;
  humanScoreEl.textContent = humanScore;
  aiScoreEl.textContent = aiScore;
}

// ---------- 1. Start the game ----------
startBtn.addEventListener('click', async () => {
  const nickname = nicknameInput.value.trim();
  if (nickname === '') {
    alert('Please type a nickname first.');
    return;
  }

  startBtn.disabled = true;
  try {
    const player = await postJson('api/start_game.php', { nickname: nickname });
    playerId = player.player_id;

    const response = await fetch('api/get_images.php');
    images = await response.json();

    round = 0;
    humanScore = 0;
    aiScore = 0;
    showScreen(gameScreen);
    showRound();
  } catch (error) {
    console.error(error);
    alert('Could not start the game. Is XAMPP running?');
  } finally {
    startBtn.disabled = false;
  }
});

// ---------- 2. Show the current image ----------
function showRound() {
  const image = images[round];
  gameImage.src = IMAGE_FOLDER + image.filename;
  updateScoreboard();
  guessButtons.classList.remove('hidden');
  reveal.classList.add('hidden');
}

// ---------- 3. The player guesses ----------
async function makeGuess(guessedFake) {
  guessRealBtn.disabled = true;
  guessFakeBtn.disabled = true;
  const image = images[round];

  try {
    const result = await postJson('api/submit_guess.php', {
      player_id: playerId,
      image_id: image.id,
      round_number: round + 1,
      guessed_fake: guessedFake,
    });

    if (result.is_correct === 1) humanScore++;
    if (result.model_correct === 1) aiScore++;

    const truth = result.is_fake === 1 ? 'AI-generated' : 'a real photo';
    const yourResult = result.is_correct === 1 ? 'You got it right!' : 'You were fooled.';

    let aiResult;
    if (result.model_guess_fake === null) {
      aiResult = "The AI hasn't guessed this one yet.";
    } else {
      const aiSaid = result.model_guess_fake === 1 ? 'AI-generated' : 'real';
      const aiRight = result.model_correct === 1 ? 'right' : 'wrong';
      aiResult = `The AI said ${aiSaid} (${result.model_confidence}% sure) and was ${aiRight}.`;
    }

    revealText.textContent = `This face is ${truth}. ${yourResult} ${aiResult}`;
    tipText.textContent = 'Tip: ' + result.tip;
    updateScoreboard();

    guessButtons.classList.add('hidden');
    reveal.classList.remove('hidden');
    nextBtn.textContent = (round + 1 === images.length) ? 'See final score' : 'Next round';
  } catch (error) {
    console.error(error);
    alert('Could not save your guess. Is XAMPP running?');
  } finally {
    guessRealBtn.disabled = false;
    guessFakeBtn.disabled = false;
  }
}

guessRealBtn.addEventListener('click', () => makeGuess(false));
guessFakeBtn.addEventListener('click', () => makeGuess(true));

// ---------- 4. Next round, or the end ----------
nextBtn.addEventListener('click', () => {
  round++;
  if (round < images.length) {
    showRound();
  } else {
    finalHuman.textContent = humanScore;
    finalAi.textContent = aiScore;
    showScreen(endScreen);
  }
});

playAgainBtn.addEventListener('click', () => {
  showScreen(startScreen);
});
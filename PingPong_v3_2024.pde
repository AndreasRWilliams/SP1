ArrayList<Ball> balls;  
float paddleWidth = 15;  // Paddle bredde
float paddleHeight = 100; // Paddle højde
float paddle1Y, paddle2Y; 
float paddleSpeed = 6;  

int scorePlayer1 = 0;  // Spiller 1's score
int scorePlayer2 = 0;  // Spiller 2's score
int maxScore = 3;  // Score for at vinde
boolean gameOver = false;  

void setup() {
  size(800, 600);  
  balls = new ArrayList<Ball>();  // Opretter bold-listen
  balls.add(new Ball(width / 2, height / 2, 3, 3, 40));  
  paddle1Y = height / 2 - paddleHeight / 2;  // Starter paddle 1 midt på skærmen
  paddle2Y = height / 2 - paddleHeight / 2;  // Starter paddle 2 midt på skærmen
}

void draw() {
  background(0);  // Sort baggrund
  
  if (gameOver) {  
    fill(255);  // Hvid tekst
    textSize(50);  
    textAlign(CENTER, CENTER);  
    if (scorePlayer1 >= maxScore) {
      text("Player 1 Wins!", width / 2, height / 2);  
    } else if (scorePlayer2 >= maxScore) {
      text("Player 2 Wins!", width / 2, height / 2);  
    }
    return;  // Spillet er slut
  }
  
  for (Ball b : balls) {  
    b.move();  
    b.display();  
    
    // Kollision med paddle 1
    if (checkPaddleCollision(b.x - b.diameter / 2, b.y, 30, paddle1Y)) {
      b.speedX *= -1;  // Ændrer retning på bolden
    }
    
    // Kollision med paddle 2
    if (checkPaddleCollision(b.x + b.diameter / 2, b.y, width - 30 - paddleWidth, paddle2Y)) {
      b.speedX *= -1; 
    }
    
    // Bolden går ud til venstre
    if (b.x < 0) {
      scorePlayer2++;  
      checkGameOver();  
      b.reset();  // Nulstil bolden
    }
    
    // Bolden går ud til højre
    else if (b.x > width) {
      scorePlayer1++;  
      checkGameOver();  
      b.reset();  // Nulstil bolden
    }
  }
  
  // Tegner paddles
  rect(30, paddle1Y, paddleWidth, paddleHeight);  
  rect(width - 30 - paddleWidth, paddle2Y, paddleWidth, paddleHeight);  
  
  // Paddle bevægelse
  if (keyPressed) { 
    if (key == 'w' || key == 'W') {  
      paddle1Y -= paddleSpeed;
    } else if (key == 's' || key == 'S') { 
      paddle1Y += paddleSpeed;
    }
    
    if (keyCode == UP) {  
      paddle2Y -= paddleSpeed;
    } else if (keyCode == DOWN) {  
      paddle2Y += paddleSpeed;
    }
  }
  
  // Forhindrer paddles i at gå ud af skærmen
  paddle1Y = constrain(paddle1Y, 0, height - paddleHeight);  
  paddle2Y = constrain(paddle2Y, 0, height - paddleHeight);  
  
  // Viser score
  fill(255);  
  textSize(32);  
  textAlign(CENTER, CENTER);  
  text(scorePlayer1, width / 4, 50);  
  text(scorePlayer2, width * 3 / 4, 50);  
}

// Tjekker kollision mellem bold og paddle
boolean checkPaddleCollision(float ballX, float ballY, float paddleX, float paddleY) {
  return (ballX > paddleX && ballX < paddleX + paddleWidth && ballY > paddleY && ballY < paddleY + paddleHeight);
}

// Tjekker om en spiller har vundet
void checkGameOver() {
  if (scorePlayer1 >= maxScore || scorePlayer2 >= maxScore) {  
    gameOver = true;  
  }
}

// Boldklasse
class Ball {
  float x, y;  // Boldens position
  float speedX, speedY;  // Boldens hastighed
  float diameter;  // Boldens størrelse
  
  // Boldkonstruktør
  Ball(float startX, float startY, float startSpeedX, float startSpeedY, float dia) {
    x = startX;  
    y = startY;  
    speedX = startSpeedX;  
    speedY = startSpeedY;  
    diameter = dia;  
  }
  
  // Flytter bolden
  void move() {
    x += speedX;  
    y += speedY;  
    if (y < 0 || y > height) {  
      speedY *= -1;  // Skifter retning
    }
  }
  
  // Tegner bolden
  void display() {
    ellipse(x, y, diameter, diameter);  
  }
  
  // Nulstiller boldens position
  void reset() {
    x = width / 2;  
    y = height / 2;  
    speedX *= -1;  // Skifter retning
  }
}

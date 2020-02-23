// MINIM LIBRARY FOR MUSIC

//imports files needed for sound
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//variables to declare soundFiles
AudioPlayer titleSound;
AudioPlayer gameSound;

// a parameter or argument needed in order to play the file
Minim title;
Minim game;

float speedX = 3;    //speed to move James right and left
float speedY = 3;   //speed to move James up and down

float walkSpeedX = 0.75; // x speed for the security officers in the 2nd stage
float YwarshipSpeed = 2; // y speed for the alien warships in the final stage

int stage = 0;    //variable to change levels and backgrounds

boolean gameOver = false; //starts the boolean gameOver to be false
int lives = 3; //3 lives in the game
int score = 0; //score is set to zero to start off

//images to load for animations
PImage mazaedes; //hero spaceship
PImage back; //background for title screen
PImage ship; //James's spaceship
PImage recipe; // Tim Hortons Coffee image

Hero James = new Hero(100, 300);    //creates a new Object named James
Security1[] Officers = new Security1[13];      //Creates an array of 13 objects for the 1st level
Securitywalk[] Officerswalk = new Securitywalk[8];    //creates an array of 8 objects for the 2nd level
SecurityUltra[] OfficersUltra = new SecurityUltra[6]; //creates an array of 6 objects for 3rd level
FinalSecurity[] Warships = new FinalSecurity[3];  //creates an array of 3 objects for the final level

//x and y position of the asteroid
float x;
float y;

// diameter of the asteroid
float diam;
PImage asteroid;

//string variables to define the text file for instructions
String[] mission;
String[] instructions;
//variable to store speed values for asteroid
float speed;

// judges weather the parameters are true or not
boolean valid; 
// minimum and maximum x axis range the asteroid 
//can appear within
final int MIN_X = 125, MAX_X = 750; 
// minimum and maximum y axis range the asteroid 
//can appear within
final int MIN_Y = -700, MAX_Y = -100;
// minimum and maximum distance of the diameter
final int MIN_DIAM = 40, MAX_DIAM = 80;

// Creates an array of asteroids that has an index of 10
Sphere [] spheres = new Sphere [10];

void setup ()
{
  //loads the text file for instructions
  mission = loadStrings("Instructions.txt");

  //splits the lines in the instructions by a '/' in the text file
  for (int a = 0; a<mission.length; a++)
  {
    instructions = split(mission[a], '/');
  }

  //initialize the position of each security officer for the first level
  Officers[0] = new Security1(width-300, 250);
  Officers[1] = new Security1(width-700, 350);
  Officers[2] = new Security1(width-600, 125);
  Officers[3] = new Security1(width-400, 425);
  Officers[4] = new Security1(225, 100);
  Officers[5] = new Security1(225, 425);
  Officers[6] = new Security1(350, 250);
  Officers[7] = new Security1(width-200, 20);
  Officers[8] = new Security1(width-235, 440);
  Officers[9] = new Security1(width-100, 300);
  Officers[10] = new Security1(width-400, 20);
  Officers[11] = new Security1(width-50, 125);
  Officers[12] = new Security1(width-600, 450);

  //initialize the position of each security officer for the second level
  Officerswalk[0] = new Securitywalk(width-275, 250);
  Officerswalk[1] = new Securitywalk(width-500, 400);
  Officerswalk[2] = new Securitywalk(width-130, height-152);
  Officerswalk[3] = new Securitywalk(width-700, 449);
  Officerswalk[4] = new Securitywalk(width-70, 30);
  Officerswalk[5] = new Securitywalk(475, 20);
  Officerswalk[6] = new Securitywalk(width-500, 150);
  Officerswalk[7] = new Securitywalk(width-775, height/2-50);

  //initialize the position of each security officer for the third level
  OfficersUltra[0] = new SecurityUltra(width-275, 130);
  OfficersUltra[1] = new SecurityUltra(width-600, 400);
  OfficersUltra[2] = new SecurityUltra(width-500, 100);
  OfficersUltra[3] = new SecurityUltra(width-390, 410);
  OfficersUltra[4] = new SecurityUltra(width-850, 450);
  OfficersUltra[5] = new SecurityUltra(400, 130);

  //initialize the position of each security officer for the final level
  Warships[0] = new FinalSecurity(width-150, 230);
  Warships[1] = new FinalSecurity(width-400, 330);
  Warships[2] = new FinalSecurity(width-620, 150);

  for (int i = 0; i < spheres.length; i++) //initializes all the elements in the array for the asteroids
  {
    spheres[i] = new Sphere();
  }

  //loads all the images needed for the game
  asteroid = loadImage("Asteroid.png");
  mazaedes = loadImage("JamesShipPic.png");
  back = loadImage("Start.png");
  ship = loadImage("Alien_Warship.png");
  recipe = loadImage("Rec.png");

  size(1200, 600);    //declares the screen resolution

  //defining each sound file in order to play music
  title = new Minim(this);
  titleSound = title.loadFile("musicback.mp3");
  titleSound.play();
  game = new Minim(this);
  gameSound = game.loadFile("COD.mp3");
}
void draw ()
{
  stroke(0);    //black stroke

  //for easy debugging purposes, I can switch the levels without having to clear them by simply pressing one of the buttons

  if (keyPressed && key == '2')
  {
    stage = 2;
    James.x = 100;
    James.y = 300;
  }

  if (keyPressed && key == '3')
  {
    stage = 3;
    James.x = 100;
    James.y = 300;
  }
  if (keyPressed && key == '4')
  {
    stage = 4;
    James.x = 100;
    James.y = 300;
  }
  if (keyPressed && key == '5')
  {
    stage = 5;
    James.x = 100;
    James.y = 300;
  }
  if (keyPressed && key == '6')
  {
    stage = 6;
    James.x = 100;
    James.y = 300;
  }

  if (stage == 0) //title screen
  {
    //plays the title screen music and pauses the game screen music
    gameSound.pause();
    titleSound.play();

    lives = 3; //the user has 3 lives when the game starts

    image(back, 0, 0, width, height); //uses the background image
    fill(255, 255, 0); //blue text
    textSize(50); //size 50
    textAlign(CENTER); //centers the title
    text("The Secret Coffee Recipe", width/2, height/2); //the name of the game

    textSize(15); // textsize of 15
    fill(0, 255, 0); // green fill colour
    text("Press Shift to continue", 125, 30); //tells the user to press Shift in order to continue to the game

    rectMode(CENTER); //centers the rectangles formed
    fill(0); //back fill colour
    rect(150, height-100, 150, 50); //creates a little rectangle for instructions
    fill(255); // white fill colour
    textSize(25); //text size of 25
    text("Instructions", 150, height-100); //gives a title of instructions

    //specifies where the mouse must be clicked in order to open the instructions
    if (mousePressed && mouseX>75 && mouseX<225 && mouseY>height-125 && mouseY<height-75)
    {
      stage = 1;
    }

    //allows the user to continue to the first level directly
    if (key == CODED)
    {
      if (keyPressed && keyCode == SHIFT)
      {
        stage = 2;
        titleSound.pause();
        gameSound.play();
      }
    }
  }

  if (stage == 1) //instructions
  {
    //continues to play the title screen music
    gameSound.pause();
    titleSound.play();

    textSize(15);
    background(0, 0, 255); //blue background
    fill(255, 0, 0); //red fill colour
    textAlign(CENTER);

    textSize(15);
    fill(0, 255, 0); //green fill colour
    text("Press Shift to continue", 125, 30);

    //allows the user to continue to the first level from the instructions menu
    if (keyPressed == true)
    {
      stage = 2;
      titleSound.pause();
      gameSound.play();
    }

    //displays the text from the text file that provides instructions to the player
    for (int b = 0; b<instructions.length; b++)
    {
      text(instructions[b], width/2, height/12+b*60);
    }
  }

  if (stage == 2) //first level of the game
  {
    //starts the game music and pauses the title screen music
    titleSound.pause();
    gameSound.play();

    background(100, 0, 220); //creates a cyan type background

    James.display(); //displays James
    James.move(); //allows James to move

    //displays the security officers for each element of the array in the first level
    for (int i = 0; i<Officers.length; i++)
    {
      stroke(0);    //black stroke
      Officers[i].show(); //uses the show function for each element of the array
    }

    if (James.x>width) //allows the user to continue to the next level
    {
      stage = 3;
      James.x = 100; //resets James's x position before moving to the next level
      James.y = 300; //resets James's y position before moving to the next level
    }
  }

  if (stage == 3) //the second level
  {
    //plays the game music and pauses the title screen music
    titleSound.pause();
    gameSound.play();

    //light blue background
    background(0, 0, 255);

    James.display(); //displays James
    James.move(); //allows James to move

    //displays the security officers for each element of the array in the second level
    for (int i = 0; i<Officerswalk.length; i++)
    {
      Officerswalk[i].show();
    }

    if (James.x>width) //allows the user to continue to the next level
    {
      stage = 4;
      James.x = 100; //resets James's x position before moving to the next level
      James.y = 300; //resets James's y position before moving to the next level
    }
  }

  if (stage == 4) //the third level
  {
    //starts the game music and pauses the title screen music
    titleSound.pause();
    gameSound.play();

    //a bluish background
    background(0, 100, 200);

    James.display(); //displays James
    James.move(); //allows James to move

    //displays the security officers for each element of the array in the second level
    for (int i = 0; i<OfficersUltra.length; i++)
    {
      OfficersUltra[i].show();
    }

    if (James.x>width) //allows the user to continue to the next level
    {
      stage = 5;
      James.x = 100; //resets James's x position before moving to the next level
      James.y = 300; //resets James's y position before moving to the next level
    }
  }

  if (stage == 5) //the final level in outer space
  {
    //starts the game music and pauses the title screen music
    titleSound.pause();
    gameSound.play();

    background(100, 25, 170); //a purple background colour

    James.displayShip(James.x+125, James.y+75/2, James.x+525, James.y+75/2); //displays the Mazaedes spaceship    
    James.move(); //allows Mazaedes spaceship to move

    //i will run through the loop as long the length of the sphere is greater than i, i increases by 1
    for (int i = 0; i < spheres.length; i++) 
    { 
      spheres[i].update();
    }
    //need to set framerate to create a smoother movement
    surface.setTitle(nf(frameRate, 3, 2));

    //displays the aliens for each element of the array in the final level
    for (int i = 0; i<Warships.length; i++)
    {
      Warships[i].display();
      Warships[i].move();
    }

    if (score >=1000) //the user wins the game if a score of a 1000 is reached
    {
      stage = 6;
    }

    if (James.x>width-100) //allows the user to continue to the next level
    {
      James.x = 100; //resets James's x position before moving to the next level
      James.y = 300; //resets James's y position before moving to the next level
    }
  }

  textSize(15);
  fill(0, 255, 0);
  textAlign(CENTER);
  text("You have " + lives + " lives remaining", width-125, 30); //displays the number of lives remaining
  text("Your score is " + score, width-125, 50); //displays the score

  int m = millis();  //keeps track of time
  int s = m/1000; //converts the time into seconds
  fill(0, 255, 0);
  text("time is " + s + " seconds", width/2, 30); //displays the time at the top of the screen

  if (James.x<5 || James.y<5 || James.y>height-5) //prevents the user from going out of the boundary
  {
    James.x = 100; //resets the user's x position
    James.y = 300; //resets the user's y position
  }

  if (stage == 6) //A screen to show the user won
  {
    //random generator
    float r = random(255);
    float g = random(255);
    float b = random(255);
    float a = random(255);

    //pauses the game music and starts the title screen music 
    gameSound.pause();
    titleSound.play();

    background(0);
    image(recipe, 0, 0, width, height); //uses the coffee image as a background for the screen

    fill(r, g, b, a); //uses random colours to fill a text
    textAlign(CENTER);
    textSize(25);

    //text to say the user won the game
    text("Congratulations James!", width-320, 30);
    text("You have Obtained the Secret Coffee Recipe!", width-320, 60);
    text("Enjoy your Coffee!", width-320, 90);

    //allows the user to play again if clicked on the button
    rectMode(CENTER);
    fill(255, 255, 0);
    rect(width-150, height-100, 150, 50);
    fill(255);
    textSize(25);
    text("Play Again", width-150, height-100);

    //takes the user to the title screen if "play again" is clicked on
    if (mousePressed && mouseX>width-225 && mouseX<width-75 && mouseY>height-125 && mouseY<height-75)
    {
      stage = 0;
      score = 0;
      lives = 3;
      James.x = 100;
      James.y = 300;
    }
  }

  strokeWeight(1); //keeps the line thickness to 1

  if (gameOver)  //consequence of losing in the game
  {
    lives --;    //you lose a life
    James.x = 21; //sets James back to the original x position
    James.y = 250; //sets James back to the original y position
    gameOver = false; //turns off the consequence

    if (lives == 0)  //if the number of lives reach zero
    {
      //restarts the game by resetting all the variables
      lives = 0;
      fill(0);
      fill(255);
      textSize(50);
      textAlign(CENTER);
      text("Game Over", width/2, height/2);  //game over text
      stage = 0;
      lives = 3;
      score = 0; 
      gameOver= false; //turns off the consequence
    }
  }
}

class Hero //class for James
{
  float x; //James's x position
  float y; //James's y position

  Hero(float xPos, float yPos) //constructor for the class
  {
    x = xPos;
    y = yPos;
  }
  void display() //simply displays James
  {
    fill(0);
    ellipse(x, y, 20, 20);
  }

  void move()
  {
    if (key == CODED)
    {
      if (keyPressed && keyCode == UP)
      {
        //moves up
        y = y - speedY;
      }

      if (keyPressed && keyCode == DOWN)
      {
        //moves down
        y = y + speedY;
      }

      if (keyPressed && keyCode == RIGHT)
      {
        //moves right
        x = x + speedX;
      }

      if (keyPressed && keyCode == LEFT)
      {
        //moves left
        x = x - speedX;
      }
    }
  }

  void displayShip(float xShoot, float yShoot, float xShootlong, float yShoot2) //function to display the Mazaedes spaceship
  {
    //loads the image for the spaceship
    image(mazaedes, x, y, 125, 75);

    if (keyPressed && key == ' ') //the user must hit the space bar to shoot the laser
    {  
      //creates the laser by a line
      stroke(0, 255, 0);   
      strokeWeight(4);
      line(xShoot, yShoot, xShootlong, yShoot2);

      //creates a dotted line over the laser to use collision detection
      for (int i = 0; i <= 10; i++)
      {
        float xHit = lerp(xShoot, xShootlong, i/10.0); //x position for the points on the line
        float yHit = lerp(yShoot, yShoot2, i/10.0); //y position for the points on the line
        stroke(0, 255, 0); //green colour
        point(xHit, yHit); //creates all the points

        //collision detection between the laser and the alien warships
        for (int x = 0; x<Warships.length; x++)
        {
          if (dist(Warships[x].Xwar+50, Warships[x].Ywar+50, xHit, yHit)<50)
          {
            stroke(0, 255, 0);
            score++; //increases the score
          }
        }
        stroke(0); //black stroke
      }
    }
  }
}

class Security1 //class for the officers in the first level
{
  float SX; //x position 
  float SY; //y position

  //variables for the flashlights
  float x2 = -120;
  float y2 = 120;
  float x3 = -30;
  float y3 = 120;

  //speed for the flashlights
  float Xsp = 3;
  float Ysp = 1;

  Security1(float secX, float secY) //constructor for the class
  {
    SX = secX;
    SY = secY;
  }

  void show() //function to display the officers
  {
    fill(0);
    rectMode(CENTER);
    rect(SX, SY, 30, 30); //creates the officer

    //moves the flashlights
    x3 = x3 + Xsp;
    y3 = y3 + Ysp;
    x2 = x2 + Xsp;
    y2 = y2 + Ysp;

    //makes the flashlights reverse its direction
    if (x3>=91)
    {
      Xsp = Xsp*-1;
      Ysp = Ysp*-1;
    } 

    //makes the flashlights reverse its direction
    if (x3<-150)
    {
      Xsp = Xsp*-1;
      Ysp = Ysp*-1;
    }

    //creates variables to access the new location of the flashlight
    float hix2 = SX + x2;
    float hix3 = SX + x3;
    float hiy2 = SY + y2;
    float hiy3 = SY + y3;

    fill(255, 0, 0);
    triangle(SX, SY, hix2, hiy2, hix3, hiy3); //draws the flashlight

    // BOTTOM SIDE OF TRIANGLES
    for (float xLasb = hix2; xLasb<=hix3; xLasb++) //dotted line for the bottom part of the triangle
    {

      float yLasb = hiy2;
      stroke(255, 0, 0);
      point(xLasb, yLasb);

      //collision for the bottom of the triangle
      if (dist(James.x, James.y, xLasb, yLasb)<5)
      {
        gameOver = true;
      }
    }

    // LEFT SIDE OF TRIANGLES

    //variables to create a dotted line
    float linex1L = hix2;
    float liney1L = hiy2;
    float linex2L = SX-5;
    float liney2L = SY;

    //creates the dotted line for the left side of the triangle
    for (int i = 0; i <= 10; i++)
    {
      float xLeft = lerp(linex1L, linex2L, i/10.0) + 10; //x position of the dotted line
      float yLeft = lerp(liney1L, liney2L, i/10.0); //y position for the dotted line
      stroke(255, 0, 0);
      point(xLeft, yLeft); //creates the dotted line

      //collision for the dotted line and James
      if (dist(James.x, James.y, xLeft, yLeft)<10)
      {
        gameOver = true;
      }
    }
    //RIGHT SIDE OF TRIANGLES

    //variables to create a dotted line
    float linex1R = hix3-10;
    float liney1R = hiy3;
    float linex2R = SX-15;
    float liney2R = SY;

    for (int i = 0; i <= 10; i++)
    {
      float xRight = lerp(linex1R, linex2R, i/10.0) + 10; //x position of the dotted line
      float yRight = lerp(liney1R, liney2R, i/10.0); //y position of the dotted line
      stroke(255, 0, 0);
      point(xRight, yRight); //creates the dotted line

      //collision for the dotted line and James
      if (dist(James.x, James.y, xRight, yRight)<10)
      {
        gameOver = true;
      }
    }
  }
}

class Securitywalk //class for the Security Officers in the 2nd level
{
  float xWalk; //x position of the officer
  float yWalk; //y position of the officer

  //variables for the flashlights
  float x2 = -120;
  float y2 = 120;
  float x3 = -30;
  float y3 = 120;
  float Xsp = 6;
  float Ysp = 2;


  Securitywalk(float secXwalk, float secYwalk) //a constructor for the class
  {
    xWalk = secXwalk;
    yWalk = secYwalk;
  }

  void show()
  {
    fill(0);
    rectMode(CENTER);
    rect(xWalk, yWalk, 30, 30); //creates the officers at its given x and y position

    xWalk = xWalk + walkSpeedX; //adds an x speed to the x values of the officers

    if (xWalk==300.5) //reverses the speed if too far left
    {
      walkSpeedX = walkSpeedX*-1;
    }

    if (xWalk==width-40) //reverses the speed if too far right
    {
      walkSpeedX = walkSpeedX*-1;
    }

    //moves the flashlights
    x3 = x3 + Xsp;
    y3 = y3 + Ysp;
    x2 = x2 + Xsp;
    y2 = y2 + Ysp;

    //reverses the direction of the flashlight
    if (x3>=91)
    {
      Xsp = Xsp*-1;
      Ysp = Ysp*-1;
    }    
    //reverses the direction of the flashlight
    if (x3<-150)
    {
      Xsp = Xsp*-1;
      Ysp = Ysp*-1;
    }

    //variables for updated flashlight positions
    float hix2 = xWalk + x2;
    float hix3 = xWalk + x3;
    float hiy2 = yWalk + y2;
    float hiy3 = yWalk + y3;

    fill(255, 0, 0);
    triangle(xWalk, yWalk, hix2, hiy2, hix3, hiy3); //creates the flashlights

    // BOTTOM SIDE OF TRIANGLES
    for (float xLasb = hix2; xLasb<=hix3; xLasb++) //bottom line
    {

      float yLasb = hiy2;
      stroke(255, 0, 0);
      point(xLasb, yLasb); //creates the dotted line

      if (dist(James.x, James.y, xLasb, yLasb)<5) //collision for the dotted line and James
      {
        gameOver = true;
      }
    }

    // LEFT SIDE OF TRIANGLES

    //variables to create the dotted line
    float linex1L = hix2;
    float liney1L = hiy2;
    float linex2L = xWalk-5;
    float liney2L = yWalk;

    //creates a dotted line
    for (int i = 0; i <= 10; i++)
    {
      float xLeft = lerp(linex1L, linex2L, i/10.0) + 10; //x position of the dotted line
      float yLeft = lerp(liney1L, liney2L, i/10.0); //y position of the dotted line
      stroke(255, 0, 0);
      point(xLeft, yLeft); //creates the points for the dotted line

      if (dist(James.x, James.y, xLeft, yLeft)<10) //collision between the dotted line and James
      {
        gameOver = true;
      }
    }
    //RIGHT SIDE OF TRIANGLES

    //variables for the dotted line
    float linex1R = hix3-10;
    float liney1R = hiy3;
    float linex2R = xWalk-15;
    float liney2R = yWalk;

    for (int i = 0; i <= 10; i++) //creates the points for the dotted line
    {
      float xRight = lerp(linex1R, linex2R, i/10.0) + 10; //x position of the dotted line
      float yRight = lerp(liney1R, liney2R, i/10.0); //y position of the dotted line
      stroke(255, 0, 0);
      point(xRight, yRight); //makes the points

      if (dist(James.x, James.y, xRight, yRight)<10) //collision between the line and James
      {
        gameOver = true;
      }
    }
  }
}

class SecurityUltra //class for security officers in the third level
{
  float xWalk; //x position
  float yWalk; //y position

  //variables to make the flashlight
  float x2 = -120;
  float y2 = 120;
  float x3 = -30;
  float y3 = 120;
  float Xsp = 6;
  float Ysp = 2;

  SecurityUltra(float secXwalk, float secYwalk) //a constructor for the class
  {
    xWalk = secXwalk;
    yWalk = secYwalk;
  }

  void show()
  {
    //Creates the  vertical lasers to stick out of the security officers
    if (dist(James.x, James.y, xWalk, yWalk)<=300)
    {
      //variables for the laser
      float Vlaserx1 = xWalk;
      float Vlaserx2 = xWalk;
      float Vlasery1 = yWalk-130;
      float Vlasery2 = yWalk+100;

      strokeWeight(3);
      stroke(0, 255, 0);
      line(Vlaserx1, Vlasery1, Vlaserx2, Vlasery2); //makes the laser
      strokeWeight(1);

      for (int i = 0; i <= 20; i++) //creates a dotted line
      {
        float VxLaser = lerp(Vlaserx1, Vlaserx2, i/20.0); //x position of the dotted line
        float VyLaser = lerp(Vlasery1, Vlasery2, i/20.0); //y position of the dotted line
        stroke(255, 0, 0);
        point(VxLaser, VyLaser); //creates the points for the line

        if (dist(James.x, James.y, VxLaser, VyLaser)<=7) //collision for the laser lines
        {
          gameOver = true;
        }
      }

      //Creates the horizontal lasers to stick out of the security officers
      //variables for the line
      float Hlaserx1 = xWalk-125;
      float Hlaserx2 = xWalk+125;
      float Hlasery1 = yWalk;
      float Hlasery2 = yWalk;

      strokeWeight(3);
      stroke(0, 255, 0);
      line(Hlaserx1, Hlasery1, Hlaserx2, Hlasery2); //creates the line
      strokeWeight(1);

      for (int i = 0; i <= 20; i++) //creates a dotted line
      {
        float HxLaser = lerp(Hlaserx1, Hlaserx2, i/20.0); // x position of the dotted line
        float HyLaser = lerp(Hlasery1, Hlasery2, i/20.0); //y position of the dotted line
        stroke(255, 0, 0);
        point(HxLaser, HyLaser); //makes the points along the line

        if (dist(James.x, James.y, HxLaser, HyLaser)<=7) //collision between the dotted line and James
        {
          gameOver = true;
        }
      }
    }

    fill(0);
    rectMode(CENTER);
    rect(xWalk, yWalk, 30, 30); //creates the Security officers

    xWalk = xWalk+walkSpeedX; //moves the security officers by their speed

    if (xWalk>width-100) //if the officers are too far right, then go left
    {
      walkSpeedX = walkSpeedX*-1;
    }

    if (xWalk<100) //if the officers are too far left, then go right
    {
      walkSpeedX = walkSpeedX*-1;
    }

    //moves the flashlight
    x3 = x3 + Xsp;
    y3 = y3 + Ysp;
    x2 = x2 + Xsp;
    y2 = y2 + Ysp;

    if (x3>=91) //reverses the direction of the flashlight
    {
      Xsp = Xsp*-1;
      Ysp = Ysp*-1;
    }    

    if (x3<-150) //reverses the direction of the flashlight
    {
      Xsp = Xsp*-1;
      Ysp = Ysp*-1;
    }
    //variables for updated coordinates of the flashlights
    float hix2 = xWalk + x2;
    float hix3 = xWalk + x3;
    float hiy2 = yWalk + y2;
    float hiy3 = yWalk + y3;

    fill(255, 0, 0);
    triangle(xWalk, yWalk, hix2, hiy2, hix3, hiy3); //creates the flashlights

    // BOTTOM SIDE OF TRIANGLEs
    for (float xLasb = hix2; xLasb<=hix3; xLasb++) //bottom line
    {

      float yLasb = hiy2;
      stroke(255, 0, 0);
      point(xLasb, yLasb); //creates the dotted line

      if (dist(James.x, James.y, xLasb, yLasb)<5) //collision between the dotted line and James
      {
        gameOver = true;
      }
    }

    // LEFT SIDE OF TRIANGLES

    //variables to make the dotted line
    float linex1L = hix2;
    float liney1L = hiy2;
    float linex2L = xWalk-5;
    float liney2L = yWalk;

    for (int i = 0; i <= 10; i++)
    {
      float xLeft = lerp(linex1L, linex2L, i/10.0) + 10; //x position of the dotted line
      float yLeft = lerp(liney1L, liney2L, i/10.0); //y position of the dotted line
      stroke(255, 0, 0);
      point(xLeft, yLeft); //makes the points for the dotted line

      if (dist(James.x, James.y, xLeft, yLeft)<10) //collision between the dotted line and James
      {
        gameOver = true;
      }
    }
    //RIGHT SIDE OF TRIANGLES
    //variables for the dotted line
    float linex1R = hix3-10;
    float liney1R = hiy3;
    float linex2R = xWalk-15;
    float liney2R = yWalk;

    for (int i = 0; i <= 10; i++) //creates a dotted line
    {
      float xRight = lerp(linex1R, linex2R, i/10.0) + 10; //x position of the dotted line
      float yRight = lerp(liney1R, liney2R, i/10.0); // y position of the dotted line
      stroke(255, 0, 0);
      point(xRight, yRight); //makes the points for the dotted line

      if (dist(James.x, James.y, xRight, yRight)<10) //collision between the line and James
      {
        gameOver = true;
      }
    }
  }
}


// a class is used to store data as a function which can be initialized as an object... in this case it is a sphere
class Sphere
{  
  Sphere()
  {
    initAll();
  }

  void initAll() 
  {
    //defines what a true and appropriate parameters of a function can be 
    //in order to generate random sizes and speeds of the asteroids, one variable must be used describing the range from the minimum to maximum values
    //this part of the code puts the minimum and maximum values in one variable
    valid = true;
    x = random(MIN_X, MAX_X);
    y = random(MIN_Y, MAX_Y);
    speed = 1.3;
    diam  = random(MIN_DIAM, MAX_DIAM);
  }

  // void update runs a loop to draw random asteroid within the stated arguments
  void update() 
  {
    //boolean command which tells it to draw an ellipse using random generated numbers
    if (!valid) 
    {
      initAll();
      //it tells it to real void intALL and generates random parameters
      return;
    }
    move();
    draw_ellipse();// command to draw asteroid
  }
  void draw_ellipse()
  {
    //draw function using numbers initited by void intAll
    // ellipse was drawn over by an image 
    image(asteroid, x, y, diam, diam);

    if (dist(x, y+15, James.x+(125/2), James.y+(75/2))<=60)
    {
      gameOver = true;
    }
  }

  void move()
  {
    //moves the y value of the asteroid down at a constant speed
    if (y-diam <= height)
    {
      y += speed;
    } else if (y-diam > height) //if asteroid goes past the screen this means that user has dodged the asteroid
    {
      valid = false;
    }
  }

  //the following command below tells it to reset the position of the asteroid once it has gone down the screen
  boolean isOver(int mx, int my) {
    float disX = x - mx;
    float disY = y - my;
    if (sqrt(sq(disX) + sq(disY)) < diam/2) {
      return true;
    } else {
      return false;
    }
  }
}

class FinalSecurity
{
  float Xwar; //variable to store x position of alien warships
  float Ywar; //variable to store y position of alien warships

  FinalSecurity(float xWar, float yWar)  //constructors to assign values to the class
  {
    Xwar = xWar;
    Ywar = yWar;
  }

  void display()
  {
    image(ship, Xwar, Ywar, 100, 100); //simply displays the alien warships at their given locations
  }

  void move()
  {
    //moves the alien warships along the y axis
    Ywar = Ywar + YwarshipSpeed;
    if (Ywar<20) //if the alien warships go too high, then they go down
    {
      YwarshipSpeed = YwarshipSpeed*-1;  // reverses the direction
    }

    if (Ywar>=height-100) //if the alien warships go too down, then they go up
    {
      YwarshipSpeed = YwarshipSpeed*-1;  // reverses direction
    }
  }
}
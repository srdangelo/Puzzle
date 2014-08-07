part of PuzzleAttempt;


class Distractor {
  
  /* random number generator */
  Random random = new Random();
  num x = 0.0, y = 0.0;
  
  /* heading in radians */
  num heading = 0.0;
  num speed;
  num playSpeed = 1;
  
  num newX;
  num newY;
  
  var type;
  
  
  void animate(){ 
    goto();
   }
  
  
  //Simple Turn and goto function used in animate()
   void goto(){
    //newX = random.nextInt(game.width);
    //newY = random.nextInt(game.height);
    var item;
    num i = 0;
    for (item in game.distractors){
      i += 150;
      newX = 400 + i;
      newY = 400 + i;
      if (newX >= game.width || newY >= game.height){
        newX = 400;
        newY = 400;
      }
    }
    var dist = sqrt(pow((newX - this.x), 2) + pow((newY - this.y), 2));
    heading = atan2((newY - this.y), (newX - this.x));
    if(dist > speed * playSpeed){
      forward(speed * playSpeed);
    }
    else{
      forward(dist);
      newX = random.nextInt(game.width);
      newY = random.nextInt(game.height);
    }
  }
  
  void forward(num distance) {
      this.x += sin(heading) * distance;
      this.y -= cos(heading) * distance;
    }
  
  Distractor(color, this.x, this.y){
      type = color;
      speed = 1.00000;
    }
  
  void changeColor(){
    num z = random.nextInt(25);
    if (z == 5) {
    for (Distractor distractor in game.distractors){
        num i;
        i = random.nextInt(7);
        type = game.others[i];
    }
    }
  }
  
    void draw(CanvasRenderingContext2D ctx){
        ctx.fillStyle = type;
        ctx.fillRect(x, y, 50, 49);
        
      }
    
    
}
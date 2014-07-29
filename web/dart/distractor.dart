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
      i += 70;
      newX = 20 + i;
      newY = 100 + i;
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
      speed = 3.00000;
    }
  
    void draw(CanvasRenderingContext2D ctx){
        ctx.fillStyle = type;
        ctx.fillRect(x, y, 50, 49);
      }
    
    
}
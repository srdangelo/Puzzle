part of PuzzleAttempt;


class Distractor {
  
  /* random number generator */
  Random random = new Random();
  num x = 0.0, y = 0.0;
  
  var type;
  
  void animate(){ 
    moveAround();
   }
  
  void moveAround() {
      this.x = random.nextInt(game.width);
      this.y = random.nextInt(game.height);
  }
  
  Distractor(color, this.x, this.y){
      type = color;
    }
  
    void draw(CanvasRenderingContext2D ctx){
        ctx.fillStyle = type;
        ctx.fillRect(x, y, 50, 49);
      }
    
    
}
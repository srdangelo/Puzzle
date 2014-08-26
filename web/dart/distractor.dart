part of PuzzleAttempt;


class Distractor implements Touchable{
  
  /* width and height of the bitmap */
  num _width = 0.0, _height = 0.0;

  /* used for mouse / touch interaction */  
  double _targetX, _targetY;
  
  double _compareX, _compareY;
  
  /* is this piece being touched now? */
  bool _dragging = false;
  
  /* random number generator */
  Random random = new Random();
  num x = 0.0, y = 0.0;
  
  /* heading in radians */
  num heading = 0.0;
  num speed;
  num playSpeed = 1;
  
  num newX;
  num newY;
  
  var dragLocation;
  var location;
  
  var type;
  

  
  
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
  

  
  Distractor(color, this.x, this.y){
      type = color;
      speed = 1.00000;
    }
  
  
  void animate(){ 
    //goto();
   }
  
  void forward(num distance) {
      this.x += sin(heading) * distance;
      this.y -= cos(heading) * distance;
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
        //ctx.fillStyle = type;
        //ctx.fillRect(x, y, 50, 49);
        
        ctx.save();
        {
          ctx.fillStyle = type;
          ctx.fillRect(x, y, 50, 49);
        }    
        ctx.restore();
        
      }
    
    void move(num dx, num dy) {
      x += dx;
      y += dy;
    }
    
    void backward(num distance) {
      forward(-distance);
    }
    
    
    void left(num degrees) {
      heading -= (degrees / 180.0) * PI;   
    }
    
    
    void right(num degrees) {
      left(-degrees);
    }
    
    //num get width => this.width;
    //num get height => this.height;
    
    num width = 50;
    num height = 50;
    
    bool containsTouch(Contact c) {
      num tx = c.touchX;
      num ty = c.touchY;
      num bx = x - width/2;
      num by = y - height/2;
      return (tx >= bx && ty >= by && tx <= bx + width && ty <= by + height);
    }
    
    
    
    bool touchDown(Contact c) {
      _targetX = c.touchX;
      _targetY = c.touchY;
      _compareX = c.touchX;
      _compareY = c.touchY;
      location = _targetX;
      return true;
      
    }  
  
    void touchUp(Contact c) {
      _dragging = false;
      if (c.touchX == _compareX && c.touchY == _compareY) {
        game.score -= 10;
      }
      
      
    }
    
    
    
    void touchDrag(Contact c) {
      move(c.touchX - _targetX, c.touchY - _targetY);
      _targetX = c.touchX;
      _targetY = c.touchY;
      dragLocation = c.touchX;

   
      repaint();
    }
    
      
    void touchSlide(Contact c) { }    
    
}
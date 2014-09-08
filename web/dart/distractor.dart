part of PuzzleAttempt;


class Distractor implements Touchable{
  
  /* width and height of the bitmap */
  num _width = 0.0, _height = 0.0;

  /* used for mouse / touch interaction */  
  double _targetX, _targetY;
  
  double _compareX, _compareY;
  
  /* is this piece being touched now? */
  bool _dragging = false;
  
  /* bitmap image */
  ImageElement img = new ImageElement();
  
  /* random number generator */
  Random random = new Random();
  num x = 0.0, y = 0.0;
  
  /* heading in radians */
  num heading = 0.0;
  num disSpeed;
  
  bool moving = false;
  
  var dragLocation;
  var location;
  
  var type;

  
  num newX;
  num newY;

  
  Distractor(this.type, this.x, this.y){       
      img.src = "images/${type}.png";
      disSpeed = 1;
      newX = random.nextInt(500);
      newY = random.nextInt(500);
    }
  
  
  void animate(){ 
    if (moving == false){
    moveAround();
    }
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
  
  void moveAround(){
    disSpeed = 1;
          var dist = sqrt(pow((newX - this.x), 2) + pow((newY - this.y), 2)); 
          num head = atan2((newY - this.y), (newX - this.x));

          if(dist >= disSpeed){
            num targetX = cos(head) * disSpeed;
            num targetY = sin(head) * disSpeed; 
            move(targetX, targetY);
            
            }
          else{
            num targetX = cos(head) * dist;
            num targetY = sin(head) * dist; 
            move(targetX, targetY);
                      
            newX = random.nextInt(game.width);
            newY = random.nextInt(game.height);
          }
    }
  
    void draw(CanvasRenderingContext2D ctx){
        
        ctx.save();
        {
          ctx.translate(x, y);
          ctx.drawImage(img, -width/2, -height/2);
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
    
    num get width => img.width;
    num get height => img.height;
    
    //num width = 50;
    //num height = 50;
    
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
        moving = false;
      }
      
      
    }
    
    
    
    void touchDrag(Contact c) {
      move(c.touchX - _targetX, c.touchY - _targetY);
      _targetX = c.touchX;
      _targetY = c.touchY;
      dragLocation = c.touchX;
      
      moving = true;
   
      repaint();
    }
    
      
    void touchSlide(Contact c) { }    
    
}
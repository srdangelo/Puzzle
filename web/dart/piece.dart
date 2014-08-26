/*
 * Dart Sample Game
 */

part of PuzzleAttempt;


class Piece implements Touchable {

  /* coordinates in world space */
  num x = 0.0, y = 0.0;
  
  /* heading in radians */
  num heading = 0.0;

  Random random = new Random();
  
  /* bitmap image */
  ImageElement img = new ImageElement();
  
  num clickcount = 0; 
  var pieceType;
  var dragLocation;
  var location;
  var square;
  num score = 100;
  
  
  
  /* random number generator */
  static Random rand = new Random();
  
  /* width and height of the bitmap */
  num _width = 0.0, _height = 0.0;

  /* used for mouse / touch interaction */  
  double _targetX, _targetY;
  
  double _compareX, _compareY;
  
  /* is this piece being touched now? */
  bool _dragging = false;
  
  Piece leftNeighbor = null;
  Piece rightNeighbor = null;
  
  Piece leftBuddy = null;
  Piece rightBuddy = null;

  

/**
 * Default constructor
 */
  Piece(this.x, this.y, this.pieceType){
      img.src = "images/${pieceType}.png";
      //print(pieceType);

  }
  
  
  void move(num dx, num dy) {
    x += dx;
    y += dy;
    if (leftNeighbor != null){
      leftNeighbor.leftMove(dx, dy);
    }
    if (rightNeighbor != null){
      rightNeighbor.rightMove(dx, dy);
    }

  }
  
  void rightMove (num dx, num dy) {
    x += dx;
    y += dy;
    if (rightNeighbor != null){
      rightNeighbor.rightMove(dx, dy);
    }
  }
  
  void leftMove (num dx, num dy) {
      x += dx;
      y += dy;
      if (leftNeighbor != null){
        leftNeighbor.leftMove(dx, dy);
      }
    }
  
  void snap (){
    num leftX = x - width;
    num rightX = x + width;
    
    if (leftNeighbor != null){
      leftNeighbor.x = leftX;
      leftNeighbor.y = y;
      leftNeighbor.snapLeft();
    }
    if (rightNeighbor != null){
      rightNeighbor.x = rightX;
      rightNeighbor.y = y;
      rightNeighbor.snapRight();
    }
  }
  
  void snapLeft(){
    num leftX = rightBuddy.leftBuddy.x - width;
    if (leftNeighbor != null){
          leftNeighbor.x = leftX;
          leftNeighbor.y = y; 
        }
  }
  
  void snapRight(){
    num rightX = leftBuddy.rightBuddy.x + width;
    if (rightNeighbor != null){
          rightNeighbor.x = rightX;
          rightNeighbor.y = y;
        }
  }
  

  
  void forward(num distance) {
    x += sin(heading) * distance;
    y -= cos(heading) * distance;
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
  
  
  void animate() {
    //stayIn();
    ///moveAround();
  }

  
  num get width => img.width;
  
  num get height => img.height;
  
    
  void draw(CanvasRenderingContext2D ctx) {
    ctx.save();
    {
      ctx.translate(x, y);
      //ctx.rotate(heading);
      ctx.drawImage(img, -width/2, -height/2);
    }    
    ctx.restore();
  }
  
  
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
  
  void stayIn (dist, head){
    if (this.x >= game.width - 10){
      x += sin(head) * dist;
      y -= cos(head) * dist;
    }
    if (this.x <= 0){
      x += sin(head) * dist;
      y -= cos(head) * dist;
    }
    if (this.y >= game.height - 10){
      x += sin(head) * dist;
      y -= cos(head) * dist;
    }
    if (this.y <= 0){
      x += sin(head) * dist;
      y -= cos(head) * dist;
    }
    else{

    }
  }
  
  void moveAround(){
    num speed = 2;
    num newX = 500;
    num newY = 500;
    //num newX = random.nextInt(game.width);
    //num newY = random.nextInt(game.height);
        var dist = sqrt(pow((newX - this.x), 2) + pow((newY - this.y), 2)); 
        num head = atan2((newY - this.y), (newX - this.x)) / atan2((newY - this.y), (newX - this.x));
        //stayIn(dist);
        stayIn(-1, -head);
        if(dist >= speed){
          x += sin(head) * speed;
          y -= cos(head) * speed;
          
          }
        else{
          forward(dist);
        }
  }
  
  
  
  void touchUp(Contact c) {
    _dragging = false;
    if (c.touchX == _compareX && c.touchY == _compareY) {
      //clickcount ++;
      pieceLocation();
    }
    
    
  }
  
  
  void touchDrag(Contact c) {
    move(c.touchX - _targetX, c.touchY - _targetY);
    _targetX = c.touchX;
    _targetY = c.touchY;
    dragLocation = c.touchX;
    //pieceLocation();
    //print(dragLocation);
    //print (pieceType);
 
    repaint();
  }
  
    
  void touchSlide(Contact c) { }  

  void pieceLocation (){
    
    if (rightBuddy != null && leftBuddy != null){
            if (rightBuddy.x + 10 >= this.x && rightBuddy.y + 10 >= this.y && rightBuddy.x + 10 <= this.x + width && rightBuddy.y + 10 <= this.y + height){
                  //leftBuddy.rightNeighbor = this;
                  rightBuddy.leftNeighbor = this;
                  this.rightNeighbor = rightBuddy;
                  this.snap();
                  game.score += 10;
               }
            if (leftBuddy.x + 10 >= this.x && leftBuddy.y + 10 >= this.y && leftBuddy.x + 10 <= this.x + width && leftBuddy.y + 10 <= this.y + height){
                  //rightBuddy.leftNeighbor = this;
                  leftBuddy.rightNeighbor = this;
                  this.leftNeighbor = leftBuddy;
                  this.snap();
                  game.score += 10;
               }
        }
    if (rightBuddy != null && leftBuddy == null){
        if (rightBuddy.x + 10 >= this.x && rightBuddy.y + 10 >= this.y && rightBuddy.x + 10 <= this.x + width && rightBuddy.y + 10 <= this.y + height){
              this.rightNeighbor = rightBuddy;
              rightBuddy.leftNeighbor = this;
              this.snap();
              game.score += 10;
              //print('right buddy only');
           }
        }
    if (leftBuddy != null && rightBuddy == null){
            if (leftBuddy.x + 10 >= this.x && leftBuddy.y + 10 >= this.y && leftBuddy.x + 10 <= this.x + width && leftBuddy.y + 10 <= this.y + height){
                  this.leftNeighbor = leftBuddy;
                  leftBuddy.rightNeighbor = this;
                  this.snap();
                  game.score += 10;
                  //print('left buddy only');
               }
            }
    //print(game.score);
    }
       
  
  
}


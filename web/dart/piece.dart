/*
 * Dart Sample Game
 */

part of PuzzleAttempt;


class Piece implements Touchable {

  /* coordinates in world space */
  num x = 0.0, y = 0.0;
  
  /* heading in radians */
  num heading = 0.0;
  
  /* bitmap image */
  ImageElement img = new ImageElement();
  
  num clickcount = 0; 
  var pieceType;
  var dragLocation;
  var location;
  var square;
  
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
      print(pieceType);

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
  }

  
  num get width => img.width;
  
  num get height => img.height;
  
  var click;
  
    
  void draw(CanvasRenderingContext2D ctx) {
    ctx.save();
    {
      ctx.translate(x, y);
      ctx.rotate(heading);
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
  
  
  void touchUp(Contact c) {
    _dragging = false;
    if (c.touchX == _compareX && c.touchY == _compareY) {
      click = 1;
      clickcount ++;
      pieceLocation();
      //print(pieceType);
      //print(clickcount);
    }
    
    
  }
  
  
  void touchDrag(Contact c) {
    move(c.touchX - _targetX, c.touchY - _targetY);
    _targetX = c.touchX;
    _targetY = c.touchY;
    click = 0;
    dragLocation = c.touchX;
    //pieceLocation();
    //print(dragLocation);
    //print (pieceType);
 
    repaint();
  }
  
    
  void touchSlide(Contact c) { }  

  void pieceLocation (){
    if (rightBuddy != null && leftBuddy != null){
            if (rightBuddy.x >= this.x && rightBuddy.y >= this.y && rightBuddy.x <= this.x + width && rightBuddy.y <= this.y + height){
                  leftBuddy.leftNeighbor = this;
                  this.rightNeighbor = rightBuddy;
                  print('yes');
               }
            if (leftBuddy.x >= this.x && leftBuddy.y >= this.y && leftBuddy.x <= this.x + width && leftBuddy.y <= this.y + height){
                  rightBuddy.rightNeighbor = this;
                  this.leftNeighbor = leftBuddy;
                  print('yes');
               }
        }
    if (rightBuddy != null && leftBuddy == null){
        if (rightBuddy.x >= this.x && rightBuddy.y >= this.y && rightBuddy.x <= this.x + width && rightBuddy.y <= this.y + height){
              //leftBuddy.leftNeighbor = this;
              this.rightNeighbor = rightBuddy;
              rightBuddy.rightNeighbor = this;
              print('yes');
           }
        }
    if (leftBuddy != null && rightBuddy == null){
            if (leftBuddy.x >= this.x && leftBuddy.y >= this.y && leftBuddy.x <= this.x + width && leftBuddy.y <= this.y + height){
                  //rightBuddy.rightNeighbor = this;
                  this.leftNeighbor = leftBuddy;
                  leftBuddy.leftNeighbor = this;
                  print('yes');
               }
            }
    else{
      print('something');
        }
    }
       
  
  
}


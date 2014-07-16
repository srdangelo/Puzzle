/*
 * Dart Game Sample Code
 */
part of PuzzleAttempt;


class Game extends TouchLayer {
  
  // this is the HTML canvas element
  CanvasElement canvas;
  
  // this object is what you use to draw on the canvas
  CanvasRenderingContext2D ctx;

  // this is for multi-touch or mouse event handling  
  TouchManager tmanager = new TouchManager();

  // width and height of the canvas
  int width, height;
  static Random rand = new Random();
  
  
  // list of the boats that people can touch
  List<Piece> pieces = new List<Piece>();
  
  Piece piece; 
  
  List<String> order = ['red', 'blue', 'green', 'purple'];
  
  //AgentManager ecosystem;
  
  //Trial trial;
      
   
  Game() {
    canvas = document.query("#game");
    ctx = canvas.getContext('2d');
    width = canvas.width;
    height = canvas.height;
    
    tmanager.registerEvents(document.documentElement);
    tmanager.addTouchLayer(this);
    
    //trial = new Trial(ecosystem);  
    
 
    // create pieces in list
    var item;
    for (item in order){
      addPiece(new Piece(500, 500, item));
    }
    // assign each piece and left and right buddy depending on order in list 
    var square;
    for (square in pieces){
      int x;
      x = pieces.indexOf(square);
      print(pieces.length);
      print(x);
      if (x == 0){
        //square.leftBuddy = null;
        square.rightBuddy = pieces[x + 1];
      }
      if (x == pieces.length - 1){
        square.leftBuddy = pieces[x - 1];
        //square.rightBuddy = null;
      }
      if (x != 0 && x != pieces.length - 1) {
        square.leftBuddy = pieces[x - 1];
        square.rightBuddy = pieces[x + 1];
      }
      
    }
    


    // redraw the canvas every 40 milliseconds
    new Timer.periodic(const Duration(milliseconds : 40), (timer) => animate());
  }
  
  
  void addPiece(Piece piece) {
    pieces.add(piece);
    touchables.add(piece);
  }
  

/**
 * Animate all of the game objects 
 */
  void animate() {
    
    for (Piece piece in pieces) {
      piece.animate();
      
    }
    
    
    draw();
  }
  

  void draw() {
    
    // erase the screen
    ctx.clearRect(0, 0, width, height);
    
    // draw some text
    ctx.fillStyle = 'White';
    ctx.font = '30px sans-serif';
    ctx.textAlign = 'left';
    ctx.textBaseline = 'center';
    ctx.fillText("Puzzle Attempt: ", 100, 50);
 
    
    // draw the pieces
    for (Piece piece in pieces) {
      piece.draw(ctx);
    }
    
    //trial.draw(ctx, width, height);
    //trial.animate();
  }

  
}

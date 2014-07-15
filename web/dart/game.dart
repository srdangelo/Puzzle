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
  
  
  // list of the boats that people can touch
  List<Piece> pieces = new List<Piece>();
  
  Piece piece; 
  var blue;
  var red;
  
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
    
 
    // create a few boats
    blue = new Piece(900, 400, 'blue');
    addPiece(blue);
    addPiece(new Piece(900, 500, 'green'));
    red = new Piece(100, 400, 'red');
    addPiece(red);
    addPiece(new Piece(100, 500, 'purple'));


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

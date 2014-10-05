/*
 * Dart Game Sample Code
 */
part of PuzzleAttempt;


class Trial extends TouchLayer {
  
  Random random = new Random();
  
  // this object is what you use to draw on the canvas
  //CanvasRenderingContext2D ctx;

  // this is for multi-touch or mouse event handling  
  TouchManager tmanager = new TouchManager();

  // width and height of the canvas
  //int width, height;
  static Random rand = new Random();
  
  
  // list of the boats that people can touch
  List<Piece> pieces = new List<Piece>();
  List<Distractor> distractors = new List<Distractor>();
  
  Piece piece;
  Distractor distractor;

  
  //List<String> order = ['red', 'blue', 'green'];
  //List<String> others = ['circleRed', 'circleBlue', 'circleGreen'];
  
  //num score = 100;
  //num complete = 0;
   
  Trial(order, others) { 
    
    tmanager.registerEvents(html.document.documentElement);
    tmanager.addTouchLayer(this);
    
    var other;
    num z = 0;
    for (other in others){
          z += 100;
          num otherX = random.nextInt(100) + z;
          num otherY = random.nextInt(300);
          addDistractor(new Distractor(other, otherX, otherY));
        }
    

    // create pieces in list
    var item;
    num x = 300;
    num y = 300;
    for (item in order){
      x = random.nextInt(500) + 50;
      y = random.nextInt(500) + 50;
      addPiece(new Piece(x, y, item));
    }
    // assign each piece and left and right buddy depending on order in list 
    var square;
    for (square in pieces){
      int x;
      x = pieces.indexOf(square);

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
    //new Timer.periodic(const Duration(milliseconds : 40), (timer) => animate());
  }
  
  
  void addPiece(Piece piece) {
    pieces.add(piece);
    touchables.add(piece);
  }
  
  void addDistractor(Distractor distractor){
    distractors.add(distractor);
    touchables.add(distractor);
  }

/**
 * Animate all of the game objects 
 */
  void animate() {
    
    for (Piece piece in pieces) {
      piece.animate();
    }
      
    for (Distractor distractor in distractors) {
       distractor.animate();
    }
    
    
    //draw();
  }
  

  void draw(html.CanvasRenderingContext2D ctx, num width, num height) {
    
    // erase the screen
    ctx.clearRect(0, 0, width, height);
    
    // draw some text
    ctx.fillStyle = 'white';
    ctx.font = '30px sans-serif';
    ctx.textAlign = 'left';
    ctx.textBaseline = 'center';
    ctx.fillText("Puzzle Attempt: ", 100, 50);
    ctx.fillText("Score: ${game.score}", 100, 100);
    if (game.complete == pieces.length - 1){
      ctx.fillText("Complete!!", 100, 150);
      game.complete = 0;
      game.transition();
    }
    
    // draw the pieces
    for (Piece piece in pieces) {
      piece.draw(ctx);
    }
    
    for (Distractor distractor in distractors){
    distractor.draw(ctx);
    }
    

  }

  
}

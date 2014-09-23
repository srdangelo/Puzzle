/*
 * Dart Game Sample Code
 */
part of PuzzleAttempt;


class Game extends TouchLayer {
  
  // this is the HTML canvas element
  html.CanvasElement canvas;
  
  Random random = new Random();
  
  // this object is what you use to draw on the canvas
  html.CanvasRenderingContext2D ctx;

  // this is for multi-touch or mouse event handling  
  //TouchManager tmanager = new TouchManager();

  // width and height of the canvas
  int width, height;
  static Random rand = new Random();
  
  DataLogger datalogger;
  
  // list of the boats that people can touch
  List<Piece> pieces = new List<Piece>();
  List<Distractor> distractors = new List<Distractor>();
  
  Piece piece;
  Distractor distractor;
  
  Trial trial1;
  Trial trial2;
  Trial trial3;
  Title title;

  var phase;
  num id = 0;
  num totalTimeCounter = 0;
  
  List<String> touched = new List<String>();
  
  List<String> order = ['red', 'blue', 'green'];
  List<String> others = ['circleRed', 'circleBlue', 'circleGreen'];
  
  List<String> order2 = ['red', 'blue', 'green', 'purple'];
  List<String> others2 = ['circleRed', 'circleBlue', 'circleGreen', 'circlePurple'];
  
  List<String> order3 = ['blue', 'green', 'purple'];
  List<String> others3 = ['circleBlue', 'circleGreen', 'circlePurple'];
  
  num score = 100;
  num complete = 0;
   
  Game() {
    canvas = html.document.query("#game");
    ctx = canvas.getContext('2d');
    width = canvas.width;
    height = canvas.height;
    
    phase = 'TRIAL ONE';
    
    
    trial1 = new Trial(order, others);
    trial2 = new Trial(order2, others2);
    trial3 = new Trial(order3, others3);
    title = new Title();
    
    datalogger = new DataLogger();
    //tmanager.registerEvents(document.documentElement);
    //tmanager.addTouchLayer(this);
    
//    var other;
//    num z = 0;
//    for (other in others){
//          z += 100;
//          num otherX = random.nextInt(100) + z;
//          num otherY = random.nextInt(300);
//          addDistractor(new Distractor(other, otherX, otherY));
//        }
//    
//
//    // create pieces in list
//    var item;
//    num x = 300;
//    num y = 300;
//    for (item in order){
//      x = random.nextInt(500) + 50;
//      y = random.nextInt(500) + 50;
//      addPiece(new Piece(x, y, item));
//    }
//    // assign each piece and left and right buddy depending on order in list 
//    var square;
//    for (square in pieces){
//      int x;
//      x = pieces.indexOf(square);
//
//      if (x == 0){
//        //square.leftBuddy = null;
//        square.rightBuddy = pieces[x + 1];
//      }
//      if (x == pieces.length - 1){
//        square.leftBuddy = pieces[x - 1];
//        //square.rightBuddy = null;
//      }
//      if (x != 0 && x != pieces.length - 1) {
//        square.leftBuddy = pieces[x - 1];
//        square.rightBuddy = pieces[x + 1];
//      }
//      
//    }
//    


    // redraw the canvas every 40 milliseconds
    new Timer.periodic(const Duration(milliseconds : 40), (timer) => animate());
  }
  void draw() {
      
      switch(phase){
        case 'TITLE':
          title.draw(ctx, width, height);
          break;
        case 'TRIAL ONE':
          trial1.draw(ctx, width, height);
          break;
        case 'TRIAL TWO':
          trial2.draw(ctx, width, height);
          break;
        case 'TRIAL THREE':
          trial3.draw(ctx, width, height);
          break;
  }
  }
  
  void animate() {
      switch(phase){
        case 'TITLE':
          draw();
          break;
        case 'TRIAL ONE':
          trial1.animate();
          draw();
          break;
        case 'TRIAL TWO':
            trial2.animate();
            draw();
            break;
        case 'TRIAL THREE':
            trial3.animate();
            draw();
            break;
      }
  }
      

     
     void transition() {
         switch(phase){
         case 'TITLE':
           phase = 'TRIAL ONE'; 
           new Timer.periodic(new Duration(seconds:1), (var e) => totalTimeCounter++);
           touched.clear;
           repaint();
           break;
         case 'TRIAL ONE':
            phase = 'TRIAL TWO';
            new Timer.periodic(new Duration(seconds:1), (var e) => totalTimeCounter++);
            id += 1;
            datalog();
            ws.send('newtrial');
            score = 100;
            touched.clear;
            repaint();
            break;
         case 'TRIAL TWO':
            phase = 'TRIAL THREE'; 
            id += 1;
            datalog();
            ws.send('newtrial');
            score = 100;
            touched.clear;
            repaint();
            break;
         }
     }
    
     void datalog(){
       datalogger.id = id;
       datalogger.score = score;
       datalogger.time = totalTimeCounter;
       datalogger.touched = touched;
       datalogger.send();
     }
         
    
  
//  void addPiece(Piece piece) {
//    pieces.add(piece);
//    touchables.add(piece);
//  }
//  
//  void addDistractor(Distractor distractor){
//    distractors.add(distractor);
//    touchables.add(distractor);
//  }

/**
 * Animate all of the game objects 
 */
//  void animate() {
//    
//    for (Piece piece in pieces) {
//      piece.animate();
//    }
//      
//    for (Distractor distractor in distractors) {
//       distractor.animate();
//    }
//    
//    
//    
//    draw();
//  }
//  
//
//  void draw() {
//    
//    // erase the screen
//    ctx.clearRect(0, 0, width, height);
//    
//    // draw some text
//    ctx.fillStyle = 'White';
//    ctx.font = '30px sans-serif';
//    ctx.textAlign = 'left';
//    ctx.textBaseline = 'center';
//    ctx.fillText("Puzzle Attempt: ", 100, 50);
//    ctx.fillText("Score: ${score}", 100, 100);
//    if (complete == pieces.length - 1){
//      ctx.fillText("Complete!!", 100, 150);
//    }
//    
//    // draw the pieces
//    for (Piece piece in pieces) {
//      piece.draw(ctx);
//    }
//    
//    for (Distractor distractor in distractors){
//    distractor.draw(ctx);
//    }
//    
//
//  }

  
}

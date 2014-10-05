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
  Trial trial4;
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
    trial4 = new Trial(order3, others3);
    title = new Title();
    
    datalogger = new DataLogger();  


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
        case 'TRIAL FOUR':
          trial4.draw(ctx, width, height);
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
        case 'TRIAL FOUR':
            trial4.animate();
            draw();
            break;
      }
  }
      

     
     void transition() {
         switch(phase){
         case 'TITLE':
           phase = 'TRIAL ONE'; 
           new Timer.periodic(new Duration(seconds:1), (var e) => totalTimeCounter++);
           touched.clear();
           repaint();
           break;
         case 'TRIAL ONE':
            phase = 'TRIAL TWO';
            new Timer.periodic(new Duration(seconds:1), (var e) => totalTimeCounter++);
            id += 1;
            datalog();
            ws.send('newtrial');
            score = 100;
            touched.clear();
            repaint();
            break;
         case 'TRIAL TWO':
            phase = 'TRIAL THREE'; 
            id += 1;
            datalog();
            ws.send('newtrial');
            score = 100;
            touched.clear();
            repaint();
            break;
         case 'TRIAL THREE':
            phase = 'TRIAL FOUR'; 
            id += 1;
            datalog();
            ws.send('newtrial');
            score = 100;
            touched.clear();
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
         

  
}

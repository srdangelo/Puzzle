part of PuzzleAttempt;

class Trial extends TouchLayer{
  
    Random random = new Random();
    
    // this object is what you use to draw on the canvas
    CanvasRenderingContext2D ctx;

    // this is for multi-touch or mouse event handling  
    TouchManager tmanager = new TouchManager();

    // width and height of the canvas
    int width, height;
    static Random rand = new Random();
    
    
    // list of the boats that people can touch
    List<Piece> pieces = new List<Piece>();
    List<Distractor> distractors = new List<Distractor>();
    
    Piece piece;
    Distractor distractor;
    
    List<String> order = ['red', 'blue', 'green', 'circleRed', 'purple', 'circleBlue'];
    List<String> others = ['red', 'white', 'yellow', 'blue', 'green', 'orange', 'purple', 'black'];
    
        
     Trial(){
       
       new Timer(const Duration(seconds : 3), () {
                        for (Distractor distractor in distractors){
                          num i;
                          i = random.nextInt(7);
                          distractor.type = others[i];
                        }
                               });
       
     }
     void draw(CanvasRenderingContext2D ctx, num width, num height){
         ctx.clearRect(0, 0, width, height);
         ctx.fillStyle = 'white';
         ctx.font = '30px sans-serif';
         ctx.textAlign = 'left';
         ctx.textBaseline = 'center';
         ctx.fillText("change", 100, 100);
         
         for (Distractor distractor in distractors){
             distractor.draw(ctx);
             }
         
         new Timer(const Duration(seconds : 3), () {
               for (Distractor distractor in distractors){
                    num i;
                    i = random.nextInt(7);
                    distractor.type = others[i];
              }
          });
     }

  
  
  
}
part of PuzzleAttempt;

abstract class Distractors{
  
  //Position in space
  Point position ;
  
  //Current heading and max speed for animation
  num heading;
  num speed;
  
  var type;
  
  AgentManager manager;
  
  
}

class distractorOne extends Distractors{
  
  distractorOne(AgentManager newManager, num newX, num newY){
    position = new Point(newX, newY);
    speed = 0;
    type = 'white';
    manager = newManager;
  }
  
  void draw(CanvasRenderingContext2D ctx){
    ctx.fillStyle = 'white';
    ctx.fillRect(position.x, position.y, 50, 49);
  }
  
}

class AgentManager{
  //Lists of each agent types
  List<distractorOne> distractorOnes = new List<distractorOne>();
  
  Random random = new Random();
    
  //width and height of canvas
  num width, height;
  
  //Constructor, setting initial number of each agent type
  AgentManager(num startOneCount, num newWidth, num newHeight){
    width = newWidth;
    height = newHeight;
    
    seedAgents(10, 'distractorOne');
    
  }
  
  void seedAgents(num Count, var type){
      for(int i = 0; i < Count; i++){
        num x = random.nextInt(width);
        num y = random.nextInt(height);
            if(type == 'distractorOne'){
              distractorOne temp = new distractorOne(this, x, y);
              distractorOnes.add(temp);
            }
        }
  }
  void draw(CanvasRenderingContext2D ctx){
     for(distractorOne DistractorOne in distractorOnes){
       DistractorOne.draw(ctx);
     }
  }
     
  void animate(){
  }
  
}
part of PuzzleAttempt;

class Trial extends TouchLayer{
  AgentManager ecosystem;
    
  TouchManager tmanager = new TouchManager();
    
  Trial(AgentManager newEcosystem){
     
      ecosystem = newEcosystem;
      
      tmanager.registerEvents(document.documentElement);
      tmanager.addTouchLayer(this);
      
    }
    
    
    void draw(CanvasRenderingContext2D ctx, width, height){
      ecosystem.draw(ctx);
      
    }
    
    void animate(){
        ecosystem.animate();
      }
    
  
}
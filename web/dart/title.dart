part of PuzzleAttempt;


class Title extends TouchLayer{
  
  TouchManager tmanager = new TouchManager();
  IntroTouch myIntro = new IntroTouch();
  
  Title(){
   
    
    tmanager.registerEvents(document.documentElement);
    tmanager.addTouchLayer(this);
    
    touchables.add(myIntro);
  }
  
  
  void draw(CanvasRenderingContext2D ctx,num width,num height){
    myIntro.draw(ctx, width, height);
  }
  void animate(){
    
  }
  
  
}

class IntroTouch implements Touchable{
  ImageElement img = new ImageElement();
  
  IntroTouch(){
    img.src = "images/title.png";
  }
  
  void draw(CanvasRenderingContext2D ctx,num width,num height){
    ctx.clearRect(0, 0, width, height);
    ctx.fillStyle = 'black';
    ctx.drawImage(img, 200, 200);
  }
  
  bool containsTouch(Contact c) {
    num tx = c.touchX;
    num ty = c.touchY;
    num bx = img.width;
    num by = img.height;
    return (tx >= 0 && ty >= 0 && tx <= bx && ty <= by);
  }
  
  
  bool touchDown(Contact c) {

    return true;
  }
  void touchUp(Contact c) {
        //game.transition();
  }
  
  void touchDrag(Contact c) {  }
  void touchSlide(Contact c) { }  
}
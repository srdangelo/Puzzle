part of PuzzleAttempt;

class DataLogger{
 int id;
 int score;
 
 DataLogger(){
   id = -1; 
   score = -1;
 }
 
 void send(){
     var data = "$id, $score";
     
     ws.send(data);
   }
}
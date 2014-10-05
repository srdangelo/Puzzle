part of PuzzleAttempt;

class DataLogger{
 int id;
 int score;
 int time;
 List<String> touched;
 
 DataLogger(){
   id = -1; 
   score = -1;
   time = -1;
 }
 
 void send(){
     var data = "$id, $score, $time, $touched";
     
     ws.send(data);
   }
}
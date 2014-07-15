/*
 * Dart Game Sample Code
 */
library PuzzleAttempt;  

import 'dart:html';
import 'dart:math';
import 'dart:async';


part 'piece.dart';
part 'game.dart';
part 'touch.dart';
part 'distractors.dart';
part 'trialOne.dart';


// global game object
Game game;

void main() {
  
  // create game object
  game = new Game();
}


void repaint() {
  game.draw();
}
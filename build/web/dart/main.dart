/*
 * Dart Game Sample Code
 */
library PuzzleAttempt;  

import 'dart:math';
import 'dart:async';
import 'dart:html' as html;


part 'piece.dart';
part 'game.dart';
part 'touch.dart';
part 'distractor.dart';
part 'trial.dart';
part 'title.dart';
part 'datalogger.dart';

html.WebSocket ws;

outputMsg(String msg) {
  
  print(msg);

}


void initWebSocket([int retrySeconds = 2]) {
  var reconnectScheduled = false;

  outputMsg("Connecting to websocket");
  ws = new html.WebSocket('ws://127.0.0.1:4040/ws');

  void scheduleReconnect() {
    if (!reconnectScheduled) {
      new Timer(new Duration(milliseconds: 1000 * retrySeconds), () => initWebSocket(retrySeconds * 2));
    }
    reconnectScheduled = true;
  }

  ws.onOpen.listen((e) {
    outputMsg('Connected');
    ws.send('connected');
  });

  ws.onClose.listen((e) {
    outputMsg('Websocket closed, retrying in $retrySeconds seconds');
    scheduleReconnect();
  });

  ws.onError.listen((e) {
    outputMsg("Error connecting to ws");
    scheduleReconnect();
  });

  ws.onMessage.listen((html.MessageEvent e) {
    outputMsg('Received message: ${e.data}');
  });
}

// global game object
Game game;

void main() {
  
  // create game object
  game = new Game();
  
  initWebSocket();
}


void repaint() {
  game.draw();
}
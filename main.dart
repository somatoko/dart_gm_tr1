import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'example02-squares/square_game.dart';
import 'example1/sample_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Flame.device.fullScreen();

  var game = SquareGame();
  runApp(GameWidget(game: game));
}

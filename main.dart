import 'package:flutter/material.dart';
import 'package:flame/game.dart';

// import 'example02-squares/square_game.dart';
import 'ex2/joystick_example.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Flame.device.fullScreen();

  // var game = SquareGame();
  var game = JoystickExample();
  runApp(GameWidget(game: game));
}

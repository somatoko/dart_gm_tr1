import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_hello/ex2/joystick_player.dart';
import 'package:flutter/cupertino.dart';

class JoystickExample extends FlameGame {
  late final JoystickPlayer player;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final knobPaint = BasicPalette.green.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.green.withAlpha(100).paint();

    joystick = JoystickComponent(
      knob: CircleComponent(radius: 15, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 20, bottom: 20),
    );

    player = JoystickPlayer(joystick);

    add(player);
    add(joystick);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}

import 'dart:async';
import 'dart:math';
import 'package:flame_hello/example02-squares/life_bar.dart';
import 'package:flame_hello/example02-squares/square_game.dart';
import 'package:flame_hello/example02-squares/utils.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class Square extends PositionComponent with HasGameReference<SquareGame> {
  var velocity = Vector2(0, 0).normalized() * 25;
  var rotationSpeed = 0.3;
  var squareSize = 128.0;
  var color =
      BasicPalette.white.paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

  late LifeBar _lifeBar;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
    _createLifeBar();
  }

  void _createLifeBar() {
    _lifeBar = LifeBar.initData(
      size,
      size: Vector2(size.x - 10, 5),
      placement: LifeBarPlacement.center,
    );

    add(_lifeBar);
  }

  void processHit() {
    _lifeBar.decrementCurrentLifeBy(10);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    var angleDelta = dt * rotationSpeed;
    angle = (angle + angleDelta) % (2 * pi);

    if (Utils.isPositionsOutOfBounds(game.size, position)) {
      game.remove(this);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), color);
  }
}

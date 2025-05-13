import 'dart:async';
import 'dart:math';
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

  List<RectangleComponent> lifeBarElements = List<RectangleComponent>.filled(
    3,
    RectangleComponent(size: Vector2(1, 1)),
    growable: false,
  );

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
    createLifeBar();
  }

  createLifeBar() {
    final lifeBarSize = Vector2(40, 10);
    final backgroundFillColor =
        Paint()
          ..color = Colors.grey.withAlpha(80)
          ..style = PaintingStyle.fill;
    final outlineColor =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke;
    final lifeDangerColor =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill;
    lifeBarElements = [
      // Fill
      RectangleComponent(
        position: Vector2(size.x - lifeBarSize.x, -lifeBarSize.y - 2),
        size: lifeBarSize,
        angle: 0,
        paint: backgroundFillColor,
      ),
      // Life left
      RectangleComponent(
        position: Vector2(size.x - lifeBarSize.x, -lifeBarSize.y - 2),
        size: Vector2(10, lifeBarSize.y),
        angle: 0,
        paint: lifeDangerColor,
      ),
      // Outline
      RectangleComponent(
        position: Vector2(size.x - lifeBarSize.x, -lifeBarSize.y - 2),
        size: lifeBarSize,
        angle: 0,
        paint: outlineColor,
      ),
    ];

    addAll(lifeBarElements);
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

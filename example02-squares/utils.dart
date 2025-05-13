import 'dart:math';
import 'package:flame/components.dart';

class Utils {
  static Vector2 generateRandomPosition(Vector2 screenSize, Vector2 margins) {
    var rng = Random();
    var result = Vector2.zero();

    result = Vector2(
      rng.nextInt(screenSize.x.toInt() - 2 * margins.x.toInt()).toDouble() +
          margins.x,
      rng.nextInt(screenSize.y.toInt() - 2 * margins.y.toInt()).toDouble() +
          margins.y,
    );
    return result;
  }

  static Vector2 generateRandomVelocity(Vector2 screenSize, int min, int max) {
    var rng = Random();
    var result = Vector2.zero();
    double velocity;

    while (result == Vector2.zero()) {
      result = Vector2(
        (rng.nextInt(3) - 1) * rng.nextDouble(),
        (rng.nextInt(3) - 1) * rng.nextDouble(),
      );
    }
    result.normalize();
    velocity = (rng.nextInt(max - min) + min).toDouble();
    return result * velocity;
  }

  static bool isPositionsOutOfBounds(Vector2 screenSize, Vector2 position) {
    return position.x >= screenSize.x ||
        position.x <= 0 ||
        position.y <= 0 ||
        position.y >= screenSize.y;
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:intl/intl.dart';

class BackgroundComponent extends Component with HasGameReference<FlameGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad(); // Always call super
    print("BackgroundComponent loaded!"); // Verify it runs
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPaint(Paint()..color = Colors.red);
    // canvas.drawRect(
    //   Rect.fromLTWH(0, 0, game.size.x, game.size.y),
    //   Paint()..color = Colors.red,
    // );
  }
}

class SampleGame1 extends FlameGame with SingleGameInstance, TapDetector {
  late final FpsComponent fpsComponent; // Reference to FPS counter
  // static final fpsTextPaint = TextPaint(
  //   config: const TextPaintConfig(color: Colors.black, fontSize: 12)
  // );
  static final fpsTextPaint = TextPaint(
    style: TextStyle(color: Colors.black, fontSize: 12),
  );

  @override
  bool debugMode = true;

  @override
  FutureOr<void> onLoad() async {
    fpsComponent = FpsComponent();
    add(fpsComponent);

    add(BackgroundComponent());
    add(FpsTextComponent(position: Vector2(10, 10)));
    // return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // print('<game loop> update() called  at delta time $dt');
    // print('- ${fpsComponent.fps}');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // print('<game loop> update() render called');
    // canvas.drawPaint(Paint()..color = Colors.red);

    var stringFormatterFPS = NumberFormat('##', "en_US");
    String fps = "fps: ${stringFormatterFPS.format(fpsComponent.fps)}";
    fpsTextPaint.render(canvas, fps, Vector2(10, 100));
  }

  @override
  void onTap() {
    super.onTap();
    print('tap!');
  }

  @override
  void onTapUp(TapUpInfo info) {
    print(
      '<--> onTap location: (${info.eventPosition.global.x}, ${info.eventPosition.global.y})',
    );
  }
}

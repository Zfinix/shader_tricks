import 'dart:ui' as ui hide Color;

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

import 'package:shader_tricks/game/shader_tricks_game.dart';

class StarComponent extends PositionComponent
    with HasGameRef<ShaderTricksGame> {
  double time = 0;

  StarComponent(this.image) : super(position: Vector2.zero());
  final ui.Image image;

  static Color starColor = const Color.fromRGBO(204, 166, 77, 1);
  static Color starGlowColor = const Color.fromRGBO(204, 90, 26, 1);

  @override
  void update(double dt) {
    time += dt;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    final shader = game.star.shader(
      resolution: Size(game.size.x, gameRef.size.y),
      iTime: time,
      iChannel0: image,
      starColor: starColor.toVec3(),
      starGlowColor: starGlowColor.toVec3(),
    );

    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        gameRef.size.x,
        gameRef.size.y,
      ),
      paint,
    );
  }
}

extension ColorToVector3 on Color {
  Vector3 toVec3() => Vector3(
        _floatValue(red),
        _floatValue(green),
        _floatValue(blue),
      );

  double _floatValue(int i) => double.parse((i / 255).toStringAsPrecision(2));
}

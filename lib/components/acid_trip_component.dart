import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shader_tricks/game/shader_tricks_game.dart';

class AcidTripComponent extends PositionComponent
    with HasGameRef<ShaderTricksGame> {
  double time = 0;

  AcidTripComponent() : super(position: Vector2.zero());

  @override
  void update(double dt) {
    time += dt;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    final resolution = gameRef.size * 0.6;
    final shader = gameRef.acidTrip.shader(
      resolution: Size(resolution.x, resolution.y),
      iTime: time,
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

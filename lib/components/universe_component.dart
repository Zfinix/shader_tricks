import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shader_tricks/game/shader_tricks_game.dart';

class UniverseComponent extends PositionComponent
    with HasGameRef<ShaderTricksGame> {
      
  double time = 0;

  UniverseComponent() : super(position: Vector2.zero());

  @override
  void update(double dt) {
    time += dt;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    final shader = gameRef.universe.shader(
      resolution: Size(gameRef.size.x, gameRef.size.y),
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

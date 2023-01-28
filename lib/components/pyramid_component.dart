import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shader_tricks/game/shader_tricks_game.dart';

class PyramidComponent extends PositionComponent
    with HasGameRef<ShaderTricksGame> {
  double time = 0;

  PyramidComponent() : super(position: Vector2.zero());

  @override
  void update(double dt) {
    time += dt;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    final resolution = gameRef.size;
    final shader = gameRef.pyramid.shader(
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

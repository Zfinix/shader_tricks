import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:shader_tricks/components/acid_trip_component.dart';
import 'package:shader_tricks/components/pyramid_component.dart';
import 'package:shader_tricks/components/star_component.dart';
import 'package:shader_tricks/components/universe_component.dart';
import 'package:shader_tricks/shaders/acid_trip.dart';
import 'package:shader_tricks/shaders/pyramid.dart';
import 'package:shader_tricks/shaders/star.dart';
import 'package:shader_tricks/shaders/universe.dart';
import 'package:shader_tricks/utils.dart';

class ShaderTricksGame extends FlameGame with PanDetector {
  final Universe universe;
  final AcidTrip acidTrip;
  final Pyramid pyramid;
  final Star star;

  Vector2 lastTapPoint = Vector2.zero();

  ShaderTricksGame({
    required this.universe,
    required this.acidTrip,
    required this.pyramid,
    required this.star,
  });

  @override
  Future<void>? onLoad() async {
    final image = await loadUiImage('assets/image/download.jpeg');
    await add(StarComponent(image));
    overlays.add('star_menu');

    // await add(PyramidComponent());

    /// await add(UniverseComponent());
    // await add(AcidTripComponent());
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    lastTapPoint = info.eventPosition.viewport;
  }
}

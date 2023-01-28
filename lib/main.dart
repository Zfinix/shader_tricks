import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shader_tricks/game/shader_tricks_game.dart';
import 'package:shader_tricks/shaders/acid_trip.dart';
import 'package:shader_tricks/shaders/pyramid.dart';
import 'package:shader_tricks/shaders/star.dart';
import 'package:shader_tricks/shaders/universe.dart';
import 'package:shader_tricks/utils.dart';

import 'components/star_component.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final universe = await Universe.compile();
  final acidTrip = await AcidTrip.compile();
  final pyramid = await Pyramid.compile();
  final star = await Star.compile();

  await Flame.device.fullScreen();

  final game = ShaderTricksGame(
    universe: universe,
    acidTrip: acidTrip,
    pyramid: pyramid,
    star: star,
  );

  runApp(
    MaterialApp(
      home: GameWrapper(game: game),
    ),
  );
}

class GameWrapper extends StatefulWidget {
  const GameWrapper({
    super.key,
    required this.game,
  });

  final ShaderTricksGame game;

  @override
  State<GameWrapper> createState() => _GameWrapperState();
}

class _GameWrapperState extends State<GameWrapper> {
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: widget.game,
      mouseCursor: SystemMouseCursors.move,
      loadingBuilder: (context) => const Material(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      overlayBuilderMap: {
        'star_menu': (ctx, game) {
          return Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      StarComponent.starColor,
                    ),
                  ),
                  child: const Text('Select star color'),
                  onPressed: () async {
                    final color = await pickColor(
                      context: context,
                      pickerColor: StarComponent.starColor,
                    );
                    if (color != null) {
                      StarComponent.starColor = color;
                    }
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      StarComponent.starGlowColor,
                    ),
                  ),
                  child: const Text('Select star glow color'),
                  onPressed: () async {
                    final color = await pickColor(
                      context: context,
                      pickerColor: StarComponent.starGlowColor,
                    );
                    if (color != null) {
                      StarComponent.starGlowColor = color;
                    }
                  },
                ),
              ],
            ),
          );
        },
      },
      errorBuilder: (context, ex) {
        return const Material(
          child: Center(
            child: Text('Sorry, something went wrong'),
          ),
        );
      },
    );
  }
}

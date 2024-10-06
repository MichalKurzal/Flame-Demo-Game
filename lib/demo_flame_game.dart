import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class DemoFlameGame extends FlameGame {
  DemoFlameGame()
      : super(
            camera:
                CameraComponent.withFixedResolution(width: 1920, height: 1024));

  late TiledComponent level;

  @override
  Color backgroundColor() => const Color.fromARGB(0, 33, 65, 76);

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;

    level = await TiledComponent.load('map01.tmx', Vector2.all(16));

    world.add(level);

    return super.onLoad();
  }
}

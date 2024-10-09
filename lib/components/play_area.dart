import 'dart:async';

import 'package:demo_flame_game/components/player.dart';
import 'package:demo_flame_game/demo_flame_game.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class PlayArea extends RectangleComponent with HasGameReference<DemoFlameGame> {
  late TiledComponent level;

  @override
  Future<void> onLoad() async {
    level = await TiledComponent.load('map01.tmx', Vector2.all(16));
    add(level);

    ObjectGroup? spawnPoints =
        level.tileMap.getLayer<ObjectGroup>('SpawnPoints');

    if (spawnPoints != null) {
      for (TiledObject spawnPoint in spawnPoints.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            final player =
                Player(position: Vector2(spawnPoint.x, spawnPoint.y));
            add(player);
            break;
        }
      }
    }

    return super.onLoad();
  }
}

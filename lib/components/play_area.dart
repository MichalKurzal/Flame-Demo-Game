import 'dart:async';

import 'package:demo_flame_game/components/collision_block.dart';
import 'package:demo_flame_game/components/player.dart';
import 'package:demo_flame_game/demo_flame_game.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class PlayArea extends RectangleComponent with HasGameReference<DemoFlameGame> {
  final Player player;
  late TiledComponent level;
  List<CollisionBlock> collisionBlocks = [];

  PlayArea({required this.player});

  @override
  Future<void> onLoad() async {
    level = await TiledComponent.load('map01.tmx', Vector2.all(16));
    add(level);

    ObjectGroup? spawnPoints =
        level.tileMap.getLayer<ObjectGroup>('SpawnPoints');

    ObjectGroup? collisions = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (spawnPoints != null) {
      for (TiledObject spawnPoint in spawnPoints.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
        }
      }
    }

    if (collisions != null) {
      for (TiledObject collision in collisions.objects) {
        final collisionBlock = CollisionBlock(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height));
        collisionBlocks.add(collisionBlock);
        add(collisionBlock);
      }
    }

    return super.onLoad();
  }
}

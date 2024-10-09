import 'dart:async';

import 'package:demo_flame_game/demo_flame_game.dart';
import 'package:flame/components.dart';

enum PlayerState { down, up, left, right }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<DemoFlameGame> {
  Player({super.position});

  late SpriteAnimation downAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;

  @override
  Future<void> onLoad() async {
    _loadAnimations();

    return super.onLoad();
  }

  void _loadAnimations() {
    downAnimation = _defineAnimation(Vector2.all(0));

    upAnimation = _defineAnimation(Vector2(32, 0));

    leftAnimation = _defineAnimation(Vector2(64, 0));

    rightAnimation = _defineAnimation(Vector2(64, 0));

    animations = {
      PlayerState.down: downAnimation,
      PlayerState.up: upAnimation,
      PlayerState.left: leftAnimation,
      PlayerState.right: rightAnimation
    };

    current = PlayerState.down;
  }

  SpriteAnimation _defineAnimation(Vector2 v2) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('TX Player.png'),
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 0.01,
            textureSize: Vector2(32, 64),
            texturePosition: v2));
  }
}

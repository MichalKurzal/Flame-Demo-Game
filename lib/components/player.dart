import 'dart:async';

import 'package:demo_flame_game/demo_flame_game.dart';
import 'package:flame/components.dart';

enum PlayerState { down, up, left, right }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<DemoFlameGame> {
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
    downAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache('TX Player.png'),
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: 0.01, textureSize: Vector2(32, 64)));

    upAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache('TX Player.png'),
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 0.01,
            textureSize: Vector2(32, 64),
            texturePosition: Vector2(32, 0)));

    leftAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache('TX Player.png'),
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 0.01,
            textureSize: Vector2(32, 64),
            texturePosition: Vector2(64, 0)));

    rightAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache('TX Player.png'),
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 0.01,
            textureSize: Vector2(32, 64),
            texturePosition: Vector2(64, 0)));

    animations = {
      PlayerState.down: downAnimation,
      PlayerState.up: upAnimation,
      PlayerState.left: leftAnimation,
      PlayerState.right: rightAnimation
    };

    current = PlayerState.left;
  }
}

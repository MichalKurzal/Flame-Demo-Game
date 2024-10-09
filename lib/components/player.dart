import 'dart:async';

import 'package:demo_flame_game/demo_flame_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';

enum PlayerState { down, up, left, right }

enum PlayerDirection { down, up, left, right, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<DemoFlameGame>, KeyboardHandler {
  Player({super.position});

  late SpriteAnimation downAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;

  PlayerDirection playerDirection = PlayerDirection.left;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingLeft = true;

  @override
  Future<void> onLoad() async {
    _loadAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent
    return super.onKeyEvent(event, keysPressed);
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

  void _updatePlayerMovement(double dt) {
    double directionX = 0.0;
    double directionY = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if (!isFacingLeft) {
          flipHorizontallyAroundCenter();
          isFacingLeft = true;
        }
        current = PlayerState.left;
        directionX -= moveSpeed;
        break;
      case PlayerDirection.right:
        if (isFacingLeft) {
          flipHorizontallyAroundCenter();
          isFacingLeft = false;
        }
        current = PlayerState.right;
        directionX += moveSpeed;
        break;
      case PlayerDirection.down:
        current = PlayerState.down;
        directionY += moveSpeed;
        break;
      case PlayerDirection.up:
        current = PlayerState.up;
        directionY -= moveSpeed;
        break;

      case PlayerDirection.none:
        current = PlayerState.down;
        break;
    }
    velocity = Vector2(directionX, directionY);
    position += velocity * dt;
  }
}

import 'dart:async';
import 'dart:io';

import 'package:demo_flame_game/demo_flame_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

enum PlayerState { down, up, left, right }

enum PlayerDirection { down, up, left, right, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<DemoFlameGame>, KeyboardHandler {
  Player({super.position, required this.joystick});

  late SpriteAnimation downAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;

  PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingLeft = true;

  final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    _loadAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    if (Platform.isAndroid || Platform.isIOS) {
      _updateJoystick(dt);
    }

    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);
    final isDownKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown);

    List<bool> gameKeys = [
      isLeftKeyPressed,
      isRightKeyPressed,
      isDownKeyPressed,
      isUpKeyPressed
    ];

    int howManyPressed = gameKeys.where((element) => element).length;

    if (howManyPressed > 1) {
      playerDirection = PlayerDirection.none;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else if (isUpKeyPressed) {
      playerDirection = PlayerDirection.up;
    } else if (isDownKeyPressed) {
      playerDirection = PlayerDirection.down;
    } else {
      playerDirection = PlayerDirection.none;
    }

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

  void _updateJoystick(double dt) {
    switch (joystick.direction) {
      case JoystickDirection.left:
        playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
        playerDirection = PlayerDirection.right;
        break;
      case JoystickDirection.up:
        playerDirection = PlayerDirection.up;
        break;
      case JoystickDirection.down:
        playerDirection = PlayerDirection.down;
        break;
      default:
        playerDirection = PlayerDirection.none;
    }
  }
}

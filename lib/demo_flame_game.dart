import 'dart:async';

import 'package:demo_flame_game/components/play_area.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DemoFlameGame extends FlameGame with KeyboardEvents {
  DemoFlameGame()
      : super(
            camera:
                CameraComponent.withFixedResolution(width: 1920, height: 1024));

  static const double _minZoom = 1.0;
  static const double _maxZoom = 2.0;
  final double _startZoom = _minZoom;

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final qKey = keysPressed.contains(LogicalKeyboardKey.keyQ);
    final eKey = keysPressed.contains(LogicalKeyboardKey.keyE);

    if (qKey) {
      _processScalePLUS();
    } else if (eKey) {
      _processScaleMINUS();
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewfinder.zoom = _startZoom;

    world.add(PlayArea());

    return super.onLoad();
  }

  void _processScalePLUS() {
    final newZoom = camera.viewfinder.zoom + 0.1;
    camera.viewfinder.zoom = newZoom.clamp(_minZoom, _maxZoom);
  }

  void _processScaleMINUS() {
    final newZoom = camera.viewfinder.zoom - 0.1;
    camera.viewfinder.zoom = newZoom.clamp(_minZoom, _maxZoom);
  }
}

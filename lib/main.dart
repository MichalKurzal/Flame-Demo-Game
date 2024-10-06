import 'package:demo_flame_game/demo_flame_game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  DemoFlameGame demoGame = DemoFlameGame();

  runApp(GameWidget(game: demoGame));
}

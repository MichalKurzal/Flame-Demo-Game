import 'dart:io';

import 'package:demo_flame_game/demo_flame_game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    await Flame.device.setLandscape();
  }
  await Flame.device.fullScreen();
  DemoFlameGame demoGame = DemoFlameGame();

  runApp(GameWidget(game: demoGame));
}

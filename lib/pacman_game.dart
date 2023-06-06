import 'package:flame_testing/character/blinky.dart';
import 'package:flame_testing/character/cylde.dart';
import 'package:flame_testing/character/pacman.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_testing/object/power_pellet.dart';
import 'package:flutter/material.dart';
import 'package:flame/events.dart';
import 'object/dot.dart';
import 'object/wall.dart';
import 'segment/segment_manager.dart';

class PacmanGame extends FlameGame
    with
        HasCollisionDetection,
        HasKeyboardHandlerComponents,
        HasGameRef<PacmanGame> {
  double xOffset = 70;
  final world = World();
  late final CameraComponent cameraComponent;
  Pacman pacman = Pacman(gridPosition: Vector2(10, 6), xOffset: 70);
  Clyde clyde = Clyde(gridPosition: Vector2(10, 11), xOffset: 70);
  Blinky blinky = Blinky(gridPosition: Vector2(9, 11), xOffset: 70);
  // PacmanGame();

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'wall.png',
      'dot.png',
      'pacman.png',
      'power_pellet.png',
      'clyde.png',
      'blinky.png',
      'pinky.png',
      'frightened_clyde.png',
      'frightened_ghost.png',
    ]);
    initializeGame();
    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.center;
    addAll([cameraComponent, world]);
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 0, 0, 0);
  }

  void drawPacman() {
    add(pacman);
  }

  void drawGhost() {
    add(clyde);
    add(blinky);
  }

  void drawMap(List map, double xOffset) {
    //畫出地圖
    int gridX = 0;
    int gridY = 0;
    int mapIndex = 0;
    for (int i = 0; i < 400; i++) {
      gridX = i ~/ 20; //設定xy
      gridY = i % 20;
      mapIndex = gridY * 20 + gridX;

      if (((map[mapIndex]) as int) == 0) {
        add(Wall(
            gridPosition: Vector2(gridX as double, gridY as double),
            xOffset: xOffset));
      }
      if ((((map[mapIndex]) as int) & 16) != 0) {
        //初始設定有白點
        add(Dot(
            gridPosition: Vector2(gridX as double, gridY as double),
            xOffset: xOffset));
      } else if ((((map[mapIndex]) as int) & 32) != 0) {
        //初始設定有大力丸
        add(PowerPellet(
            gridPosition: Vector2(gridX as double, gridY as double),
            xOffset: xOffset));
      }
    }
  }

  void initializeGame() {
    drawMap(map, xOffset);
    drawPacman();
    drawGhost();
  }
}
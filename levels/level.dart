import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:final_barnyard_defenders/actors/defender.dart';
import 'package:final_barnyard_defenders/actors/enemy.dart';
import 'package:flame/game.dart';

// Olly Implemented
// game loads in level

class Level extends World{
  List<Defender>? defenders;
  Level({this.defenders});

  late TiledComponent level;

  Enemy enemy1 = Enemy(
    runGameImage: 'DefenderAnimations/enemy_run_(32x32).png',
    health: 30,
    animationFrames: 12,
    idleTextureSizeWidth: 32,
    idleTextureSizeHeight: 32,
  );

  @override
  FutureOr<void> onLoad() async {
    // Load level with 16 by 16 texture size, add to game component
    // this level file done with tiled program - see tiles in assets
    level = await TiledComponent.load('Level.tmx', Vector2.all(16));
    add(level);

    // Loading in barn
    final barnImage = await Flame.images.load("barn.png");
    final barn = SpriteComponent.fromImage(barnImage);

    // Part of giving player a location on the map
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    // Give each defender a spawnpoint lining up with point
    // from tiled file
    // Also put in enemy with movement and the barn
    for (final spawnPoint in spawnPointsLayer!.objects){
      switch (spawnPoint.class_){
        case 'Defender0':
          defenders![0].position = Vector2(spawnPoint.x, spawnPoint.y);
          add(defenders![0]);
          break;
        case 'Defender1':
          defenders![1].position = Vector2(spawnPoint.x, spawnPoint.y);
          add(defenders![1]);
          break;
        case 'Defender2':
          defenders![2].position = Vector2(spawnPoint.x, spawnPoint.y);
          add(defenders![2]);
          break;
        case 'Barn':
          barn.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(barn);
        case 'Enemy1':
          double offDown1 = spawnPoint.properties.getValue('offDown1');
          double offDown2 = spawnPoint.properties.getValue('offDown2');
          double offRight1 = spawnPoint.properties.getValue('offRight1');
          double offRight2 = spawnPoint.properties.getValue('offRight2');
          enemy1.position = Vector2(spawnPoint.x, spawnPoint.y);
          enemy1.offDown1 = offDown1;
          enemy1.offDown2 = offDown2;
          enemy1.offRight1 = offRight1;
          enemy1.offRight2 = offRight2;
          add(enemy1);
      }
    }
    return super.onLoad();
  }
}


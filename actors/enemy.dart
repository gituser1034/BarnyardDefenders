import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:final_barnyard_defenders/model/barnyard_defenders_game.dart';
import 'package:final_barnyard_defenders/model/attack.dart';

// Olly implemented this, enemy in the game that should
// hit the barn, if it hits the barn game over
// but defenders can attack it to win

enum EnemyState{ run }

class Enemy extends SpriteAnimationGroupComponent
    with HasGameRef<BarnyardDefendersGame>{

  // For movement
  double offDown1;
  double offDown2;
  double offRight1;
  double offRight2;
  String runGameImage;
  int health;
  int animationFrames;
  double idleTextureSizeWidth;
  double idleTextureSizeHeight;

  Enemy({position, this.offDown1 = 0, this.offDown2 = 0, this.offRight1 = 0, this.offRight2 = 0,
    required this.runGameImage, required this.health, required this.animationFrames,
    required this.idleTextureSizeWidth, required this.idleTextureSizeHeight}) : super(position: position);

  // Animation just to see character on the screen
  late final SpriteAnimation runAnimation;
  // Fps of animations stated in package
  final double stepTime = 0.05;
  // Set these for movement
  double rangeOffDown1 = 0;
  double rangeOffDown2 = 0;
  double rangeOffRight1 = 0;
  double rangeOffRight2 = 0;
  static const tileSize = 16;
  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    _calculateRange();
    return super.onLoad();
  }

  @override
  void updateTree(double dt) {
    // TODO: implement updateTree
    _movement(dt);
    super.updateTree(dt);
  }

  void _loadAllAnimations() {
    runAnimation = _spriteAnimation(runGameImage, animationFrames);

    // List of all animations
    animations = {
      EnemyState.run: runAnimation,
    };

    // Set current animation
    current = EnemyState.run;
  }

  SpriteAnimation _spriteAnimation(String gameImage, int amount){
    print("Attempting load: $gameImage");
    return SpriteAnimation.fromFrameData(
        game.images.fromCache(gameImage),
        SpriteAnimationData.sequenced(
          // Amount of images in animation
          amount: amount,
          // Same as 20 fps - stuff downloaded will say what this should be
          stepTime: stepTime,
          textureSize: Vector2(idleTextureSizeWidth, idleTextureSizeHeight),
        )
    );
  }

  // Calculating movement of enemy
  void _calculateRange() {
    rangeOffDown1 = position.y - offDown1 * tileSize;
    rangeOffDown2 = position.y - offDown2 * tileSize;
    rangeOffRight1 = position.x - offRight1 * tileSize;
    rangeOffRight2 = position.x - offRight2 * tileSize;
  }

  void _movement(double dt) {
    velocity.x = 50;
    velocity.y = 40;

    position.x += velocity.x * dt;
    position.y += velocity.y * dt;
  }
}
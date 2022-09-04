import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:viking_bird/game_state.dart';

import 'player.dart';

class Obstacle extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final double scaleFactor;
  final double boost;
  final Function getGameState;
  final Function setGameState;
  late final FlameGame game;

  Obstacle({
    required this.scaleFactor,
    required this.boost,
    required this.getGameState,
    required this.setGameState,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await Sprite.load('tree.png');
    double height = scaleFactor;
    double width = (scaleFactor/3)*2;
    position = Vector2(gameRef.size.x, gameRef.size.y - height);
    size = Vector2(width, height);
    add(CircleHitbox(position: Vector2(0, 0), radius: width / 2));
    game = gameRef;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (getGameState() == GameState.active) {
      final acc = dt * 50 * boost;
      if (acc > 20){
        position.x -= 20;
      } else {
        position.x -= dt * 50 * boost;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is Player) {
      removeFromParent();
      setGameState(GameState.lose);
      game.overlays.add("PauseMenu");

      Random rnd = Random();
      Vector2 randomVector2() =>
          (Vector2.random(rnd) - Vector2.random(rnd)) * 200;
      gameRef.add(
        ParticleSystemComponent(
          position: position,
          particle: Particle.generate(
            count: 10,
            generator: (i) => AcceleratedParticle(
              acceleration: randomVector2(),
              child: CircleParticle(
                radius: 5,
                paint: Paint()..color = Colors.white,
              ),
            ),
          ),
        ),
      );
    }
  }
}

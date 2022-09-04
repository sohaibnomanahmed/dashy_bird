import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:viking_bird/components/player.dart';
import 'package:viking_bird/game_state.dart';

class Candy extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final Function updateScore;
  final Function getGameState;

  Candy(this.updateScore, this.getGameState);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    var y = Random().nextDouble() * gameRef.size.y;
    position = Vector2(gameRef.size.x, y);

    sprite = await Sprite.load('candy.png');
    size = Vector2(34, 23);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (getGameState() == GameState.active){
      position.x -= dt * 50;
    }  
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is Player) {
      updateScore();
      removeFromParent();
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
                paint: Paint()..color = Colors.amber,
              ),
            ),
          ),
        ),
      );
    }
  }
}

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:viking_bird/game_state.dart';

class Player extends SpriteAnimationComponent with HasGameRef {
  static var gravity = Vector2(0, 9.8);
  final Function getGameState;

  Player(this.getGameState);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = gameRef.size / 2;
    position.x = position.x - 30;

    final sprites = [1, 2, 3].map((i) => Sprite.load('dash_$i.png'));
    animation = SpriteAnimation.spriteList(
      await Future.wait(sprites),
      stepTime: 0.1,
    );
    //sprite = await Sprite.load('dash.png');
    size = Vector2(80, 70);
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (getGameState() == GameState.active) {
      position += gravity * 5 * dt;
    }
  }

  void jump() {
    // negative is up
    position.y += -30;
  }
}

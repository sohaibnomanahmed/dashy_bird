import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class Background extends ParallaxComponent{
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('bg.png'),
      ],
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
    //size = gameRef.size;
  }
}

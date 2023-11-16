import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:viking_bird/components/background.dart';
import 'package:viking_bird/components/candy.dart';
import 'package:viking_bird/components/obstacle.dart';
import 'package:viking_bird/components/score_text_box.dart';

import 'components/player.dart';
import 'game_state.dart';

class DashyBirdGame extends FlameGame
    with
        SingleGameInstance,
        TapDetector,
        HasCollisionDetection,
        KeyboardHandler {
          
  Player? player;
  var scoreText = ScoreTextBox('Score: 0');
  double boost = 1;
  Candy? candy;
  Obstacle? obstacle;
  GameState state = GameState.paused;

  var score = 0;

  GameState getGameState() => state;

  void setGameState(GameState gameState) {
    state = gameState;
  }

  void increaseScore() {
    score += 1;
    scoreText.text = "Score $score";
    if (score > 19) {
      setGameState(GameState.win);
      overlays.add("PauseMenu");
      //FlameAudio.bgm.pause();
    }
    candy = Candy(increaseScore,
        getGameState); // Its already in the component tree just reset i think, therefore no need to re add it, that will create two candies
  }

  @override
  Future<void> onLoad() async {
    scoreText.position = Vector2(30, 50);
    candy = Candy(increaseScore, getGameState);
    obstacle = Obstacle(
      scaleFactor: size.y / 2,
      boost: boost,
      getGameState: getGameState,
      setGameState: setGameState,
    );
    player = Player(getGameState);
    //debugMode = true;
    addAll([
      Background(),
      player!,
      obstacle!,
      candy!,
    ]);

    add(scoreText);
    FlameAudio.bgm.play('yurek.mp3');
  }

  void reset() {
    removeAll([player!, candy!, scoreText]);
    score = 0;
    boost = 1;

    scoreText = ScoreTextBox('Score: 0');
    scoreText.position = Vector2(30, 50);
    candy = Candy(increaseScore, getGameState);
    obstacle = Obstacle(
      scaleFactor: size.y / 2,
      boost: boost,
      getGameState: getGameState,
      setGameState: setGameState,
    );
    player = Player(getGameState);

    addAll([
      Background(),
      player!,
      obstacle!,
      candy!,
    ]);

    add(scoreText);
    FlameAudio.bgm.play('yurek.mp3');
  }

  @override
  void update(double dt) {
    // add more candy
    super.update(dt);
    if (candy != null && candy!.position.x < size.x / 2) {
      candy = Candy(increaseScore, getGameState);
      add(candy!);
    }

    // add more obstacles
    if (obstacle != null && obstacle!.position.x < size.x / 100) {
      double scale = ((Random().nextInt((size.y - 300).toInt()) + 100))
        ..toDouble();
      obstacle = Obstacle(
          scaleFactor: scale,
          boost: boost,
          getGameState: getGameState,
          setGameState: setGameState);
      add(obstacle!);
      boost += 0.4;
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    player?.jump();
  }
}

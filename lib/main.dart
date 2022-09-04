import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:viking_bird/game_state.dart';

import 'dashy_bird_game.dart';

void main() async {
  final myGame = DashyBirdGame(
      //children: [MyCrate] // NOT WORKING??
      );
  runApp(GameWidget(
    game: myGame,
    initialActiveOverlays: const ['PauseMenu'],
    overlayBuilderMap: <String, Widget Function(BuildContext, DashyBirdGame)>{
      'PauseMenu': (ctx, game) => PauseMenuOverlay(game: game),
    },
  ));
}

class PauseMenuOverlay extends StatelessWidget {
  const PauseMenuOverlay({Key? key, required this.game}) : super(key: key);

  final DashyBirdGame game;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 350,
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.shade900),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: game.getGameState() == GameState.paused
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/dash_front.png', width: 180),
                    Text("Dashy Bird",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                    Text("Collect 20 Candies",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white)),
                    ElevatedButton(
                        onPressed: () {
                          game.overlays.remove("PauseMenu");
                          game.state = GameState.active;
                        },
                        child: const Text("Start Game"))
                  ],
                )
              : game.getGameState() == GameState.lose
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("You Lose",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                        Text("Score: ${game.score}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.white)),
                        ElevatedButton(
                            onPressed: () {
                              game.reset();
                              game.overlays.remove("PauseMenu");
                              game.state = GameState.active;
                            },
                            child: const Text("Restart Game"))
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("You Win! WOHOOO",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                        Text("Score: ${game.score}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.white)),
                        ElevatedButton(
                            onPressed: () {
                              game.reset();
                              game.overlays.remove("PauseMenu");
                              game.state = GameState.active;
                            },
                            child: const Text("Restart Game"))
                      ],
                    ),
        ),
      ),
    );
  }
}

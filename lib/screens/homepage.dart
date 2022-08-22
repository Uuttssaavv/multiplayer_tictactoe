import 'package:flutter/material.dart';
import 'package:flutter_project/models/enums/game_states.dart';
import 'package:flutter_project/models/player_model.dart';
import 'package:flutter_project/screens/option_screen.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_project/widgets/tictac_board.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../providers/states/game_state.dart';

class Homepage extends ConsumerStatefulWidget {
  static const String routeName = '/home-page';

  const Homepage({Key? key}) : super(key: key);

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = ref.read(dataProvider.notifier);
      provider.listenToTap();
      provider.onroundComplete();
      provider.onEndGame();
      provider.gameProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    GameState state = ref.watch(dataProvider);
    final Player? currentPlayer =
        state.isCreator ? state.player1 : state.player2;
    listenToGameState(state);
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: pointsTable(state, Player.fromMap(state.roomData['turn'])),
          ),
        ],
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       ref.read(dataProvider.notifier).updatePlayersListener(
        //             state.roomData['_id'] ?? '',
        //           );
        //     },
        //     child: const text(
        //       'Sync',
        //       color: Colors.white,
        //     ),
        //   ),
        // ],
      ),
      body: state.isLoading
          ? const CircularProgressIndicator()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text(
                    'Round ${(state.player1!.points + state.player2!.points).toInt() + 1}',
                  ),
                  TicTacToeBoard(
                    canTap: state.roomData['turn']['nickname'] ==
                        currentPlayer?.nickname,
                  ),
                  text((state.roomData['turn']['nickname'] ==
                              currentPlayer?.nickname
                          ? 'Your turn '
                          : 'Opponent\'s turn ') +
                      ('(${state.roomData['turn']['playerType']})')),
                  // text(
                  //   state.roomData,
                  //   isLongText: true,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 24.0,
                  //     vertical: 16.0,
                  //   ),
                  //   child: CustomButton(
                  //     onTap: () {
                  //       ref.watch(dataProvider.notifier).clearBoard();
                  //     },
                  //     text: 'Restart game',
                  //   ),
                  // )
                ],
              ),
            ),
    );
  }

  void listenToGameState(GameState state) {
    ref.listen(dataProvider.select((value) => value.gameState),
        (Game? loading, Game data) {
      switch (data) {
        case Game.idle:
        case Game.createSuccess:
        case Game.joinSuccess:
        case Game.joinError:
        case Game.loading:
          break;
        case Game.gameCompleted:
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const text('Game completed'),
              content: text(
                '${state.winner?.nickname} won the game',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      OptionScreen.routeName,
                      (route) => false,
                    );
                  },
                  child: text('Okay'.toUpperCase()),
                )
              ],
            ),
          );
          break;
        case Game.roundCompleted:
          //
          break;
      }
    });
  }

  Row pointsTable(GameState state, Player turnPlayer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        playerDisplay(
          state.player1!,
          state.player1?.nickname == turnPlayer.nickname,
        ),
        const text('vs'),
        playerDisplay(
          state.player2!,
          state.player2?.nickname == turnPlayer.nickname,
        ),
      ],
    );
  }

  Container playerDisplay(Player player, bool showBorder) {
    return Container(
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: Colors.white) : null,
      ),
      padding: const EdgeInsets.all(12.0),
      child: text(
        "${player.nickname} (${player.points.toInt()})",
      ),
    );
  }
}

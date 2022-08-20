import 'package:flutter/material.dart';
import 'package:flutter_project/data/socket_methods.dart';
import 'package:flutter_project/models/player_model.dart';
import 'package:flutter_project/widgets/button.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_project/widgets/tictac_board.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class Homepage extends ConsumerStatefulWidget {
  static const String routeName = '/home-page';

  const Homepage({Key? key}) : super(key: key);

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends ConsumerState {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        Duration.zero,
        () {
          final SocketServices services = ref.watch(socketProvider);
          services.tappedListener();
          services.pointIncreaseListener(ref.watch(dataProvider));
          services.endGameListener();
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GameState state = ref.watch(dataProvider);
    final Player? currentPlayer =
        state.isCreator ? state.player1 : state.player2;
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: pointsTable(state, Player.fromMap(state.roomData['turn'])),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TicTacToeBoard(
              canTap:
                  state.roomData['turn']['nickname'] == currentPlayer?.nickname,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: CustomButton(
                onTap: () {
                  ref.watch(dataProvider.notifier).clearBoard();
                },
                text: 'Restart game',
              ),
            )
          ],
        ),
      ),
    );
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
        "${player.nickname} (${player.playerType})",
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_project/providers/providers.dart';
import 'package:flutter_project/screens/homepage.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_project/widgets/text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums/game_states.dart';
import '../providers/states/game_state.dart';

class WaitingLobby extends StatefulWidget {
  static const routeName = '/waiting-lobby';
  const WaitingLobby({Key? key}) : super(key: key);

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  TextEditingController roomIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(
      text: '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        GameState state = ref.watch(dataProvider);
        roomIdController.text =
            state.roomData['_id'] ?? state.errorMessage ?? '';
        final errorMessage = state.errorMessage ?? '';

        ref.listen(dataProvider.select((value) => value.gameState),
            (Game? loading, Game data) {
          switch (data) {
            case Game.gameCompleted:
              break;
            case Game.joinError:
              if (errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    errorMessage.toString(),
                  ),
                ));
              }
              break;
            case Game.joinSuccess:
              Navigator.pushNamedAndRemoveUntil(
                context,
                Homepage.routeName,
                (_) => false,
              );
              break;
            case Game.idle:
            case Game.createSuccess:
              break;
            case Game.loading:
              break;
            case Game.roundCompleted:
              break;
          }
        });

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                ref.invalidate(dataProvider);
                Navigator.pop(context);
              },
            ),
            title: const text('Waiting Lobby'),
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Waiting for a player to join...'),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: CustomTextField(
                        controller: roomIdController,
                        hintText: '',
                        isReadOnly: true,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

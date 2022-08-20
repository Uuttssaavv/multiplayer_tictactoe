import 'package:flutter/material.dart';
import 'package:flutter_project/providers/providers.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_project/widgets/text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'homepage.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const text('Waiting Lobby'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          GameState state = ref.watch(dataProvider);
          roomIdController.text =
              state.roomData['_id'] ?? state.errorMessage ?? '';
          ref.listen(dataProvider, (GameState? loading, GameState data) {
            if (data.roomData['isJoin'] == false) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Homepage.routeName,
                (_) => false,
              );
            }
          });

          return state.isLoading
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
                );
        },
      ),
    );
  }
}

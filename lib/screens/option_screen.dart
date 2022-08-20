import 'package:flutter/material.dart';
import 'package:flutter_project/screens/game_data_form_Screen.dart';

import '../widgets/button.dart';

class OptionScreen extends StatelessWidget {
  static const String routeName = '/optionScreen';
  const OptionScreen({Key? key}) : super(key: key);
  void createRoom(BuildContext context, {bool isJoin = false}) {
    Navigator.pushNamed(
      context,
      CreateRoom.routeName,
      arguments: isJoin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => createRoom(context),
              text: 'Create Room',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => createRoom(context, isJoin: true),
              text: 'Join Room',
            ),
          ],
        ),
      ),
    );
  }
}

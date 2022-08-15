import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_project/utils/extension.dart';

import 'create_room_screen.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push(const RoomScreen(
                isJoin: true,
              )),
              child: const text('Join Room'),
            ),
            ElevatedButton(
              onPressed: () => context.push(const RoomScreen()),
              child: const text('Create Room'),
            ),
          ],
        ),
      ),
    );
  }
}

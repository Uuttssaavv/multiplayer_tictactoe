import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/providers/providers.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateRoom extends ConsumerStatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);

  @override
  CreateRoomState createState() => CreateRoomState();
}

class CreateRoomState extends ConsumerState {
  late DataProvider provider;
  late GameState state;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    provider = ref.watch(dataProvider.notifier);
    state = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              // if (kIsWeb) {
              provider.createRoom(_controller.text);
              // } else {
              //   provider.joinRoom(_controller.text);
              // }
              if ((state.roomData['players']?.length ?? 0) >= 2) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: text('players are'),
                  ),
                );
              }
            },
            child: const text(
              kIsWeb ? 'Cr' : 'rr',
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          Center(
            child: text(
              '${state.roomData}',
              isLongText: true,
            ),
          ),
          Center(
            child: text(
              '${provider.state.displayElements}',
              isLongText: true,
            ),
          ),
          Center(
            child: text(
              '${state.roomData['players']?.length}',
              isLongText: true,
            ),
          ),
          Center(child: text(state.errorMessage ?? 'No msg'))
        ],
      ),
    );
  }
}

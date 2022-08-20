import 'package:flutter/material.dart';
import 'package:flutter_project/providers/providers.dart';
import 'package:flutter_project/screens/waiting_lobby.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/text_field.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({
    Key? key,
    required this.isJoin,
  }) : super(key: key);

  static const String routeName = '/create-room';
  final bool isJoin;

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        DataProvider provider = ref.watch(dataProvider.notifier);
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  if (widget.isJoin == false) {
                    ref.watch(dataProvider.notifier).isCreator = true;
                  }
                  if (widget.isJoin) {
                    provider.joinRoom(
                      _nameController.text,
                      _codeController.text,
                    );
                  } else {
                    provider.createRoom(_nameController.text);
                  }
                  Navigator.pushNamed(context, WaitingLobby.routeName);
                },
                child: text(
                  widget.isJoin ? 'Join' : 'Create',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text(
                '${widget.isJoin ? 'Join' : 'Create'}\nRoom',
                color: Colors.black,
                fontweight: FontWeight.w600,
                size: 36.0,
              ),
              const SizedBox(height: 36.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: CustomTextField(
                  controller: _nameController,
                  hintText: 'Enter name',
                ),
              ),
              if (widget.isJoin)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: CustomTextField(
                    controller: _codeController,
                    hintText: 'Enter room code',
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

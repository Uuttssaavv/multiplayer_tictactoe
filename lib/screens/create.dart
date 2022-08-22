import 'package:flutter/material.dart';
import 'package:flutter_project/providers/providers.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_project/widgets/text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key, this.isJoin = false}) : super(key: key);
  final bool isJoin;
  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _roomController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        DataProvider provider = ref.watch(dataProvider.notifier);
        // state = ref.watch(dataProvider);
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  if (widget.isJoin) {
                    provider.createRoom(_nameController.text);
                  } else {
                    provider.joinRoom(
                        _nameController.text, _roomController.text);
                  }
                  // Navigator.pushNamed(context, WaitingLobby.routeName);
                },
                child: text(
                  widget.isJoin ? 'Join' : 'Create',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              CustomTextField(
                hintText: 'Name',
                controller: _nameController,
              ),
              if (widget.isJoin)
                CustomTextField(
                  hintText: 'Name',
                  controller: _roomController,
                ),
            ],
          ),
        );
      },
    );
  }
}

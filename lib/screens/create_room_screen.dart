import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_project/utils/extension.dart';

class RoomScreen extends StatelessWidget {
  final bool isJoin;
  const RoomScreen({Key? key, this.isJoin = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('${isJoin ? 'Join' : 'Create'} Room'),
        actions: [
          TextButton(
            onPressed: () {
              print(isJoin);
            },
            child: text(
              isJoin ? 'Join' : 'Create',
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(
              '${isJoin ? 'Join' : 'Create'} \nRoom',
              isCentered: true,
              fontweight: FontWeight.w700,
              color: Colors.blue,
              size: 28.0,
            ),
            28.verticalSpacer,
            textField('Enter your name'),
            20.verticalSpacer,
            if (isJoin) textField('Room code'),
          ],
        ),
      )),
    );
  }

  Padding textField(String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          border: outlineBorder,
          focusedBorder: outlineBorder,
        ),
      ),
    );
  }

  final InputBorder outlineBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.5),
  );
}

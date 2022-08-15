// import 'package:flutter/material.dart';
// import 'package:flutter_project/resources/game_methods.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// void showSnackBar(BuildContext context, String content) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(content),
//     ),
//   );
// }

// void showGameDialog(BuildContext context, ProviderRef ref, String text) {
//   showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(text),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 GameMethods().clearBoard(ref);
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 'Play Again',
//               ),
//             ),
//           ],
//         );
//       });
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_project/providers/providers.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Scoreboard extends ConsumerWidget {
//   const Scoreboard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ref) {
//     var roomDataProvider = ref.watch(dataProvider);

//     return roomDataProvider.isLoading
//         ? const CircularProgressIndicator()
//         : Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(30),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       roomDataProvider.player1!.nickname,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       roomDataProvider.player1!.points.toInt().toString(),
//                       style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(30),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       roomDataProvider.player2!.nickname,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       roomDataProvider.player2!.points.toInt().toString(),
//                       style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//   }
// }

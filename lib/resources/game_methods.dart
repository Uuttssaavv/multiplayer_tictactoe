// import 'package:flutter/material.dart';
// import 'package:flutter_project/providers/providers.dart';
// import 'package:flutter_project/widgets/snackbar.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:socket_io_client/socket_io_client.dart';

// class GameMethods {
//   void checkWinner(BuildContext context, ProviderRef ref, Socket socketClent) {
//     GameState roomDataProvider = ref.watch(dataProvider);
//     String winner = '';

//     // Checking rows
//     if (roomDataProvider.displayElements[0] ==
//             roomDataProvider.displayElements[1] &&
//         roomDataProvider.displayElements[0] ==
//             roomDataProvider.displayElements[2] &&
//         roomDataProvider.displayElements[0] != '') {
//       winner = roomDataProvider.displayElements[0];
//     }
//     if (roomDataProvider.displayElements[3] ==
//             roomDataProvider.displayElements[4] &&
//         roomDataProvider.displayElements[3] ==
//             roomDataProvider.displayElements[5] &&
//         roomDataProvider.displayElements[3] != '') {
//       winner = roomDataProvider.displayElements[3];
//     }
//     if (roomDataProvider.displayElements[6] ==
//             roomDataProvider.displayElements[7] &&
//         roomDataProvider.displayElements[6] ==
//             roomDataProvider.displayElements[8] &&
//         roomDataProvider.displayElements[6] != '') {
//       winner = roomDataProvider.displayElements[6];
//     }

//     // Checking Column
//     if (roomDataProvider.displayElements[0] ==
//             roomDataProvider.displayElements[3] &&
//         roomDataProvider.displayElements[0] ==
//             roomDataProvider.displayElements[6] &&
//         roomDataProvider.displayElements[0] != '') {
//       winner = roomDataProvider.displayElements[0];
//     }
//     if (roomDataProvider.displayElements[1] ==
//             roomDataProvider.displayElements[4] &&
//         roomDataProvider.displayElements[1] ==
//             roomDataProvider.displayElements[7] &&
//         roomDataProvider.displayElements[1] != '') {
//       winner = roomDataProvider.displayElements[1];
//     }
//     if (roomDataProvider.displayElements[2] ==
//             roomDataProvider.displayElements[5] &&
//         roomDataProvider.displayElements[2] ==
//             roomDataProvider.displayElements[8] &&
//         roomDataProvider.displayElements[2] != '') {
//       winner = roomDataProvider.displayElements[2];
//     }

//     // Checking Diagonal
//     if (roomDataProvider.displayElements[0] ==
//             roomDataProvider.displayElements[4] &&
//         roomDataProvider.displayElements[0] ==
//             roomDataProvider.displayElements[8] &&
//         roomDataProvider.displayElements[0] != '') {
//       winner = roomDataProvider.displayElements[0];
//     }
//     if (roomDataProvider.displayElements[2] ==
//             roomDataProvider.displayElements[4] &&
//         roomDataProvider.displayElements[2] ==
//             roomDataProvider.displayElements[6] &&
//         roomDataProvider.displayElements[2] != '') {
//       winner = roomDataProvider.displayElements[2];
//     } else if (roomDataProvider.filledBoxes == 9) {
//       winner = '';
//       showGameDialog(context, ref, 'Draw');
//     }

//     if (winner != '') {
//       if (roomDataProvider.player1?.playerType == winner) {
//         showGameDialog(
//             context, ref, '${roomDataProvider.player1?.nickname} won!');
//         socketClent.emit('winner', {
//           'winnerSocketId': roomDataProvider.player1?.socketID,
//           'roomId': roomDataProvider.roomData['_id'],
//         });
//       } else {
//         showGameDialog(
//             context, ref, '${roomDataProvider.player2?.nickname} won!');
//         socketClent.emit('winner', {
//           'winnerSocketId': roomDataProvider.player2?.socketID,
//           'roomId': roomDataProvider.roomData['_id'],
//         });
//       }
//     }
//   }

//   void clearBoard(ProviderRef ref) {
//     var roomDataProvider = ref.watch(dataProvider.notifier);
//     var state = roomDataProvider.state;
//     for (int i = 0; i < state.displayElements.length; i++) {
//       roomDataProvider.updateDisplayElements(i, '');
//     }
//     roomDataProvider.setFilledBoxesTo0();
//     state = state.copyWith(filledBoxes: 0);
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_project/data/socket_methods.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../providers/providers.dart';

// class TicTacToeBoard extends ConsumerStatefulWidget {
//   const TicTacToeBoard({Key? key}) : super(key: key);

//   @override
//   _TicTacToeBoardState createState() => _TicTacToeBoardState();
// }

// class _TicTacToeBoardState extends ConsumerState<TicTacToeBoard> {
//   late GameState state;
//   late SocketServices roomDataProvider;
//   @override
//   void initState() {
//     super.initState();
//     state = ref.read(dataProvider);
//     state = state.copyWith(isLoading: false);
//     roomDataProvider = ref.read(socketServices);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return ConstrainedBox(
//       constraints: BoxConstraints(
//         maxHeight: size.height * 0.7,
//         maxWidth: 500,
//       ),
//       child: state.isLoading
//           ? const CircularProgressIndicator()
//           : GridView.builder(
//               itemCount: 9,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//               ),
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                   onTap: () {
//                     print(state.roomData);
//                     roomDataProvider.tapGrid(
//                         index, state.roomData['_id'], state.displayElements);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.green,
//                       ),
//                     ),
//                     child: Center(
//                       child: AnimatedSize(
//                         duration: const Duration(milliseconds: 200),
//                         child: Text(
//                           state.displayElements[index],
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 100,
//                               shadows: [
//                                 Shadow(
//                                   blurRadius: 40,
//                                   color: state.displayElements[index] == 'O'
//                                       ? Colors.red
//                                       : Colors.blue,
//                                 ),
//                               ]),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

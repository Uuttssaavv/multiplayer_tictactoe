import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class TicTacToeBoard extends ConsumerStatefulWidget {
  const TicTacToeBoard({
    Key? key,
    required this.canTap,
  }) : super(key: key);
  final bool canTap;
  @override
  _TicTacToeBoardState createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends ConsumerState<TicTacToeBoard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = ref.watch(dataProvider);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: state.isLoading
          ? const CircularProgressIndicator()
          : GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (widget.canTap) {
                      ref.watch(dataProvider.notifier).tapGrid(
                            index,
                            state.roomData['_id'],
                            state.displayElements,
                          );
                    } else {
                      print('opponents turn');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                      ),
                    ),
                    child: Center(
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          state.displayElements[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 100,
                              shadows: [
                                Shadow(
                                  blurRadius: 40,
                                  color: state.displayElements[index] == 'O'
                                      ? Colors.red
                                      : Colors.blue,
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

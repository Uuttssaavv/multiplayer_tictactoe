import 'package:flutter_project/data/socket_methods.dart';
import 'package:flutter_project/models/player_model.dart';
import 'package:flutter_project/resources/game_methods.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataProvider =
    StateNotifierProvider<DataProvider, GameState>(DataProvider.new);

final socketService = StreamProvider((ref) {
  final ss = ref.read(socketProvider);

  return ss.socketResponse.stream;
});

class GameState {
  GameState({
    this.roomData = const {},
    this.displayElements = const ['', '', '', '', '', '', '', '', ''],
    this.filledBoxes = 0,
    this.player1,
    this.player2,
    this.isLoading = false,
    this.errorMessage,
    this.hasError = false,
    this.isTapped = false,
    this.isCreator = false,
    this.isRoundCompleted = false,
  });
  final Map<String, dynamic> roomData;
  final List<String> displayElements;
  final int filledBoxes;
  final Player? player1;
  final Player? player2;
  final bool isLoading;
  final String? errorMessage;
  final bool hasError;
  final bool isTapped;
  final bool isCreator;
  final bool isRoundCompleted;
//getters

  GameState copyWith({
    Map<String, dynamic>? roomData,
    List<String>? displayElements,
    int? filledBoxes,
    Player? player1,
    bool? isLoading,
    Player? player2,
    String? errorMessage,
    bool? hasError,
    bool? isTapped,
    bool? isCreator,
    bool? isRoundCompleted,
  }) {
    return GameState(
      roomData: roomData?['_id'] != null ? roomData! : this.roomData,
      displayElements: displayElements ?? this.displayElements,
      filledBoxes: filledBoxes ?? this.filledBoxes,
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
      isTapped: isTapped ?? this.isTapped,
      isCreator: isCreator ?? this.isCreator,
      isRoundCompleted: isRoundCompleted ?? this.isRoundCompleted,
    );
  }
}

class DataProvider extends StateNotifier<GameState> {
  final StateNotifierProviderRef ref;
  bool isCreator = false;
  DataProvider(this.ref) : super(GameState());
  GameState? get asyncState => ref
      .listen(socketService,
          (AsyncValue<GameState>? _, AsyncValue<GameState> data) {
        var value = data.value;
        if (value?.isTapped == true) {
          final takenElement = value?.displayElements ?? [];
          int valueIndex = takenElement.indexWhere((element) => element != '');
          updateDisplayElements(valueIndex, takenElement[valueIndex]);
        }
        state = state.copyWith(
          isLoading: value?.isLoading,
          roomData: value?.roomData,
          errorMessage: value?.errorMessage,
          player1: value?.player1,
          player2: value?.player2,
          hasError: value?.hasError,
          isCreator: isCreator,
        );
      })
      .read()
      .value;
  SocketServices get _socketServices => ref.read(socketProvider);
  void createRoom(String name) async {
    state = state.copyWith(
      isLoading: true,
    );
    _socketServices.createRoom(name);
    _socketServices.createRoomSuccessListener();
    _socketServices.updatePlayersStateListener();
    _socketServices.updateRoomListener();
    state = state.copyWith(
      roomData: asyncState?.roomData,
      isLoading: false,
    );
  }

  void joinRoom(String name, String roomId) {
    state = state.copyWith(
      isLoading: true,
    );
    _socketServices.joinRoom(name, roomId);
    _socketServices.joinRoomSuccessListener();
    _socketServices.updatePlayersStateListener();
    _socketServices.errorOccuredListener();

    state = state.copyWith(
      isLoading: asyncState?.isLoading,
      roomData: asyncState?.roomData,
      hasError: asyncState?.hasError,
      errorMessage: asyncState?.errorMessage,
    );
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    _socketServices.tapGrid(index, roomId, displayElements);
  }

  void updateDisplayElements(int index, String choice) {
    var stateElements = [...state.displayElements];
    stateElements[index] = choice;
    int filledBox = stateElements.where((element) => element != '').length;
    checkGame(stateElements);
    state = state.copyWith(
      displayElements: stateElements,
      filledBoxes: filledBox,
    );
  }

  void checkGame(List<String> displayElements) {
    final GameMethods gameMethods = GameMethods();
    final winner = gameMethods.checkWinner(displayElements);
    if (state.filledBoxes == 9 && winner == '') {
      print('match draw');
    }
    if (winner != '') {
      state = state.copyWith(filledBoxes: 9);
      var winnerSocketId = '';
      if (winner == state.player1?.playerType) {
        winnerSocketId = state.player1!.socketID;
      } else {
        winnerSocketId = state.player2!.socketID;
      }
      _socketServices.winner(winnerSocketId, state.roomData['_id']);
    }
  }

  void clearBoard() {
    final GameMethods gameMethods = GameMethods();

    final winner = gameMethods.checkWinner(state.displayElements);
    print(winner);
    if (winner != '' || state.filledBoxes == 9) {
      for (int i = 0; i < 9; i++) {
        updateDisplayElements(i, '');
      }
    } else {
      print(state.roomData);
      print('you cannot reset game');
    }
  }

  void setFilledBoxesTo0() {
    state = state.copyWith(filledBoxes: 0);
  }
}

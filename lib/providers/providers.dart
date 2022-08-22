import 'package:flutter_project/data/socket_methods.dart';
import 'package:flutter_project/models/game_data.dart';
import 'package:flutter_project/providers/states/game_state.dart';
import 'package:flutter_project/resources/game_methods.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums/game_states.dart';

final dataProvider =
    StateNotifierProvider<DataProvider, GameState>(DataProvider.new);

final socketService = StreamProvider((ref) {
  final ss = ref.read(socketProvider);

  return ss.socketResponse.stream;
});

class DataProvider extends StateNotifier<GameState> {
  final StateNotifierProviderRef ref;
  bool isCreator = false;
  DataProvider(this.ref) : super(GameState()) {
    ref.listen(
      socketService,
      (AsyncValue<GameData>? _, AsyncValue<GameData> data) {
        var gameData = data.value;

        final tempState = state.copyWith(
          roomData: gameData?.roomData,
          player1: gameData?.player1,
          player2: gameData?.player2,
          isLoading: true,
        );
        if (gameData is CreateRoomData) {
          state = tempState.copyWith(
            gameState: Game.createSuccess,
            roomData: gameData.roomData,
            isCreator: gameData.isCreator,
          );
        } else if (gameData is JoinRoomData) {
          state = tempState.copyWith(
            gameState: Game.joinSuccess,
            roomData: gameData.roomData,
            isCreator: gameData.isCreator,
          );
        } else if (gameData is JoinRoomErrorData) {
          state = tempState.copyWith(
            errorMessage: gameData.errorMessage,
            gameState: Game.joinError,
          );
        } else if (gameData is UpdatePlayerData) {
          state = tempState.copyWith(
            player1: gameData.player1,
            player2: gameData.player2,
          );
        } else if (gameData is UpdateRoomData) {
          state = tempState.copyWith(
            roomData: gameData.roomData,
            gameState: Game.joinSuccess,
          );
        } else if (gameData is PointIncreaseData) {
          incrementRound();
          clearBoard();
          state = state.copyWith(
            player1: gameData.player1,
            player2: gameData.player2,
            gameState: Game.roundCompleted,
          );
        } else if (gameData is UpdateGameData) {
          final takenElement = gameData.displayElements;
          int valueIndex = takenElement.indexWhere((element) => element != '');
          updateDisplayElements(valueIndex, takenElement[valueIndex]);

          state = state.copyWith(
            roomData: gameData.roomData,
          );
        } else if (gameData is EndGameData) {
          state = state.copyWith(
            gameState: Game.gameCompleted,
            winner: gameData.winner,
          );
        }
        state = state.copyWith(isLoading: false);
      },
    );
  }
  SocketServices get _socketServices => ref.read(socketProvider);
  void createRoom(String name) async {
    state = state.copyWith(
      isLoading: true,
    );
    _socketServices.createRoom(name);
    _socketServices.onCreateRoomSuccess();
    _socketServices.onPlayerUpdated();
    _socketServices.onRoomUpdated();
    state = state.copyWith(
      isLoading: false,
    );
  }

  void listenToTap() {
    _socketServices.onGameUpdated();
  }

  void gameProgress() {
    _socketServices.onEndGame();
  }

  void onroundComplete() {
    _socketServices.onPointIncreased(state.player1!.socketID);
  }

  void onEndGame() {
    _socketServices.onEndGame();
  }

  void joinRoom(String name, String roomId) {
    state = state.copyWith(
      isLoading: true,
    );
    _socketServices.joinRoom(name, roomId);
    _socketServices.onJoinRoomSuccess();
    _socketServices.onPlayerUpdated();
    _socketServices.onErrorOccured();
    state = state.copyWith(isLoading: false);
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    _socketServices.tapGrid(index, roomId, displayElements);
  }

  void updateDisplayElements(int index, String choice) {
    var stateElements = [...state.displayElements];
    stateElements[index] = choice;
    int filledBox = stateElements.where((element) => element != '').length;
    if (state.isCreator == false) {
      checkGame(stateElements);
    }
    state = state.copyWith(
      displayElements: stateElements,
      filledBoxes: filledBox,
    );
  }

  void checkGame(List<String> displayElements) {
    final GameMethods gameMethods = GameMethods();
    final winner = gameMethods.checkWinner(displayElements);
    if (state.filledBoxes == 9 && winner == '') {
      state = state.copyWith(gameState: Game.gameCompleted);
    }
    if (winner != '') {
      state = state.copyWith(filledBoxes: 9);
      var winnerSocketId = '';
      if (winner == state.player1?.playerType) {
        winnerSocketId = state.player1!.socketID;
      } else {
        winnerSocketId = state.player2!.socketID;
      }

      _socketServices.winner(
        winnerSocketId,
        state.roomData['_id'],
      );
    }
  }

  void clearBoard() {
    final GameMethods gameMethods = GameMethods();

    final winner = gameMethods.checkWinner(state.displayElements);
    if (winner != '' || state.filledBoxes == 9) {
      for (int i = 0; i < 9; i++) {
        updateDisplayElements(i, '');
      }
    }
    setFilledBoxesTo0();
  }

  void incrementRound() {
    int incr = state.round + 1;
    state = state.copyWith(round: incr);
  }

  void setFilledBoxesTo0() {
    incrementRound();
    state = state.copyWith(filledBoxes: 0);
  }
}

import 'package:flutter_project/data/socket_methods.dart';
import 'package:flutter_project/models/player_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataProvider =
    StateNotifierProvider<DataProvider, GameState>(DataProvider.new);

final socketService = Provider((ref) {
  return SocketServices();
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
  });
  final Map<String, dynamic> roomData;
  final List<String> displayElements;
  final int filledBoxes;
  final Player? player1;
  final Player? player2;
  final bool isLoading;
  final String? errorMessage;
//getters

  GameState copyWith({
    Map<String, dynamic>? roomData,
    List<String>? displayElements,
    int? filledBoxes,
    Player? player1,
    bool? isLoading,
    Player? player2,
    String? errorMessage,
  }) {
    return GameState(
      roomData: roomData ?? this.roomData,
      displayElements: displayElements ?? this.displayElements,
      filledBoxes: filledBoxes ?? this.filledBoxes,
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DataProvider extends StateNotifier<GameState> {
  final StateNotifierProviderRef ref;
  DataProvider(this.ref) : super(GameState()) {
    showError();
  }
  SocketServices get _socketServices => ref.read(socketService);

  void createRoom() {
    state = state.copyWith(
      roomData: {},
      isLoading: true,
    );
    _socketServices.createRoomSuccessListener(showJoined);
    _socketServices.updateRoomListener(showJoined);
    _socketServices.createRoom('utsav');
    state = state.copyWith(
      isLoading: false,
    );
  }

  void joinRoom(String roomId) {
    _socketServices.joinRoomSuccessListener(showJoined);
    _socketServices.joinRoom('iphone', roomId);
  }

  void showError() {
    _socketServices.errorOccuredListener(oError);
  }

  void oError(String data) {
    print('error =$data');
    state = GameState(errorMessage: data);
  }

  void showJoined(Map<String, dynamic> data) {
    print('lenght');
    print(data['players']?.length);
    print(data);
    print('data=$data');
    updateRoomData(data);
    // state = GameState(isLoading: false, roomData: (data['players']));
  }

  void updateRoomData(Map<String, dynamic> data) {
    state = GameState(isLoading: false, roomData: data);
    print('updated room data');
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    state = state.copyWith(isLoading: true);
    Player player1 = Player.fromMap(player1Data);
    state = state.copyWith(
      player1: player1,
      isLoading: false,
    );
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    state = state.copyWith(isLoading: true);
    Player player2 = Player.fromMap(player2Data);
    state = state.copyWith(
      player2: player2,
      isLoading: false,
    );
  }

  void updateDisplayElements(int index, String choice) {
    state = state.copyWith(isLoading: true);
    print(index);
    print(choice);
    final displayElement = state.displayElements;
    displayElement[index] = choice;

    state = state.copyWith(
      filledBoxes: state.filledBoxes + 1,
      displayElements: displayElement,
      isLoading: false,
    );
  }

  void setFilledBoxesTo0() {
    state = state.copyWith(filledBoxes: 0);
  }
}

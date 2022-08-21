import 'dart:async';

import 'package:flutter_project/data/socket_client.dart';
import 'package:flutter_project/models/player_model.dart';
import 'package:flutter_project/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

final socketProvider = Provider((_) => SocketServices());

class SocketServices {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;
  final socketResponse = StreamController<GameState>();
  // EMITS
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  void winner(String winnerSocketId, String roomId) {
    _socketClient.emit('winner', {
      'winnerSocketId': winnerSocketId,
      'roomId': roomId,
    });
  }

  // LISTENERS
  void createRoomSuccessListener() {
    _socketClient.on('createRoomSuccess', (data) {
      socketResponse.sink.add(GameState(
        isLoading: false,
        roomData: data,
        isCreator: true,
      ));
    });
  }

  void joinRoomSuccessListener() {
    _socketClient.on('joinRoomSuccess', (data) {
      socketResponse.sink.add(GameState(
        isLoading: false,
        roomData: data,
        isCreator: false,
      ));
    });
  }

  void errorOccuredListener() {
    _socketClient.on('errorOccurred', (e) {
      socketResponse.sink.add(
        GameState(
          errorMessage: e,
          hasError: true,
          isLoading: false,
        ),
      );
    });
  }

  void updatePlayersStateListener() {
    _socketClient.on('updatePlayers', (playerData) {
      socketResponse.sink.add(
        GameState(
          isLoading: false,
          player1: Player.fromMap(playerData[0]),
          player2: Player.fromMap(playerData[1]),
        ),
      );
    });
  }

  void updateRoomListener() {
    _socketClient.on('updateRoom', (data) {
      socketResponse.sink.add(GameState(isLoading: false, roomData: data));
    });
  }

  void tappedListener() {
    _socketClient.on('tapped', (data) {
      if (data != null) {
        var emptyList = List.generate(9, (index) => '');
        emptyList[data['index']] = data['choice'];
        socketResponse.sink.add(
          GameState(
            displayElements: emptyList,
            isTapped: true,
            roomData: data['room'],
          ),
        );
      }
    });
  }

  void pointIncreaseListener(GameState state) {
    _socketClient.on('pointIncrease', (playerData) {
      GameState winnerState;
      if (playerData['socketID'] == state.player1?.socketID) {
        winnerState = GameState(
          isLoading: false,
          player1: Player.fromMap(playerData),
        );
      } else {
        winnerState = GameState(
          isLoading: false,
          player2: Player.fromMap(playerData),
        );
      }
      socketResponse.sink.add(winnerState);
    });
  }

  void endGameListener() {
    _socketClient.on('endGame', (playerData) {
      // showGameDialog('${playerData['nickname']} won the game!');
    });
  }
}

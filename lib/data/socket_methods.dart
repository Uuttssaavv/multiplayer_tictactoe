import 'dart:async';

import 'package:flutter_project/data/socket_client.dart';
import 'package:flutter_project/models/game_data.dart';
import 'package:flutter_project/models/player_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

final socketProvider = Provider(SocketServices.new);

class SocketServices {
  final ProviderRef ref;
  Socket get _socketClient => ref.read(socketClientProvider).socket!;
  final socketResponse = StreamController<GameData>();
  SocketServices(this.ref) {
    //
  }
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
  void onCreateRoomSuccess() {
    _socketClient.on('createRoomSuccess', (data) {
      socketResponse.sink.add(
        CreateRoomData(
          roomData: data,
          isCreator: true,
        ),
      );
    });
  }

  void onJoinRoomSuccess() {
    _socketClient.on('joinRoomSuccess', (data) {
      socketResponse.sink.add(
        JoinRoomData(
          roomData: data,
          isCreator: false,
        ),
      );
    });
  }

  void onErrorOccured() {
    _socketClient.on('errorOccurred', (e) {
      socketResponse.sink.add(
        JoinRoomErrorData(
          errorMessage: e,
        ),
      );
    });
  }

  void onPlayerUpdated() {
    _socketClient.on('updatePlayers', (playerData) {
      socketResponse.sink.add(
        UpdatePlayerData(
          player1: Player.fromMap(playerData[0]),
          player2: Player.fromMap(playerData[1]),
        ),
      );
    });
  }

  void onRoomUpdated() {
    _socketClient.on('updateRoom', (data) {
      socketResponse.sink.add(
        UpdateRoomData(
          roomData: data,
        ),
      );
    });
  }

  void onGameUpdated() {
    _socketClient.on('tapped', (data) {
      print('tapped data');

      if (data != null) {
        var emptyList = List.generate(9, (index) => '');
        emptyList[data['index']] = data['choice'];
        socketResponse.sink.add(
          UpdateGameData(
            displayElements: emptyList,
            roomData: data['room'],
          ),
        );
      }
    });
  }

  void onPointIncreased(String player1SocketId) {
    _socketClient.on('pointIncrease', (playerData) {
      print('pointIncrease data');
      GameData gameData;
      if (playerData['socketID'] == player1SocketId) {
        gameData = PointIncreaseData(
          player1: Player.fromMap(playerData),
        );
      } else {
        gameData = PointIncreaseData(
          player2: Player.fromMap(playerData),
        );
      }
      socketResponse.sink.add(gameData);
    });
  }

  void onEndGame() {
    _socketClient.on('endGame', (playerData) {
      print('match end\n $playerData');
      socketResponse.sink.add(
        EndGameData(
          winner: Player.fromMap(playerData),
        ),
      );
    });
  }
}

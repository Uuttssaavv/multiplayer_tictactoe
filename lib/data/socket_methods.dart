import 'package:flutter_project/data/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketServices {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

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

  // LISTENERS
  void createRoomSuccessListener(Function(Map<String, dynamic> data) listener) {
    _socketClient.on('createRoomSuccess', (data) => listener(data));
  }

  void joinRoomSuccessListener(Function(Map<String, dynamic> data) listener) {
    _socketClient.on('joinRoomSuccess', (data) => listener(data));
  }

  // void lobbyListener() {
  //   _socketClient.on('joinRoomSuccess', (room) {
  //     return room;
  //   });
  // }

  void errorOccuredListener(Function(String) error) {
    _socketClient.on('errorOccurred', (e) => error(e));
  }

  // void updatePlayersStateListener() {
  //   _socketClient.on('updatePlayers', (playerData) {
  //     gameDateProvider.updatePlayer1(playerData[0]);
  //     gameDateProvider.updatePlayer2(playerData[1]);
  //   });
  // }

  void updateRoomListener(Function(Map<String, dynamic> data) listener) {
    _socketClient.on('updateRoom', (data) => listener(data));
  }

  // void tappedListener() {
  //   _socketClient.on('tapped', (data) {
  //     gameDateProvider.updateDisplayElements(
  //       data['index'],
  //       data['choice'],
  //     );
  //   });
  //

  // void pointIncreaseListener() {
  //   _socketClient.on('pointIncrease', (playerData) {
  //     if (playerData['socketID'] == gameDateProvider.state.player1?.socketID) {
  //       gameDateProvider.updatePlayer1(playerData);
  //     } else {
  //       gameDateProvider.updatePlayer2(playerData);
  //     }
  //   });
  // }

  void endGameListener() {
    // _socketClient.on('endGame', (playerData) {
    //   showGameDialog('${playerData['nickname']} won the game!');
    // });
  }
}
/*
import 'package:flutter/material.dart';
import 'package:flutter_project/data/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

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

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    
    _socketClient.on('createRoomSuccess', (room) {
      // Provider.of<RoomDataProvider>(context, listen: false)
      //     .updateRoomData(room);
      // Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      // Provider.of<RoomDataProvider>(context, listen: false)
      //     .updateRoomData(room);
      // Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      // showSnackBar(context, data);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      // Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
      //   playerData[0],
      // );
      // Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
      //   playerData[1],
      // );
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      // Provider.of<RoomDataProvider>(context, listen: false)
      //     .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      // RoomDataProvider roomDataProvider =
      //     Provider.of<RoomDataProvider>(context, listen: false);
      // roomDataProvider.updateDisplayElements(
      //   data['index'],
      //   data['choice'],
      // );
      // roomDataProvider.updateRoomData(data['room']);
      // // check winnner
      // GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      // var roomDataProvider =
      //     Provider.of<RoomDataProvider>(context, listen: false);
      // if (playerData['socketID'] == roomDataProvider.player1.socketID) {
      //   roomDataProvider.updatePlayer1(playerData);
      // } else {
      //   roomDataProvider.updatePlayer2(playerData);
      // }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      // showGameDialog(context, '${playerData['nickname']} won the game!');
      // Navigator.popUntil(context, (route) => false);
    });
  }
}



 */

import 'package:flutter_project/models/player_model.dart';

abstract class GameData {
  Map<String, dynamic>? roomData;
  List<String> displayElements;
  int filledBoxes;
  Player? player1;
  Player? player2;
  String errorMessage;
  bool isCreator;
  GameData({
    this.roomData,
    this.displayElements = const [],
    this.filledBoxes = 0,
    this.errorMessage = '',
    this.isCreator = false,
    this.player1,
    this.player2,
  });
}

class CreateRoomData extends GameData {
  CreateRoomData({super.roomData, super.isCreator});
}

class JoinRoomData extends GameData {
  JoinRoomData({
    super.roomData,
    super.isCreator,
  });
}

class JoinRoomErrorData extends GameData {
  JoinRoomErrorData({
    super.errorMessage,
  });
}

class UpdatePlayerData extends GameData {
  UpdatePlayerData({
    super.player1,
    super.player2,
  });
}

class PointIncreaseData extends GameData {
  PointIncreaseData({
    super.player1,
    super.player2,
  });
}

class UpdateRoomData extends GameData {
  UpdateRoomData({
    super.roomData,
    super.displayElements,
  });
}

class UpdateGameData extends GameData {
  UpdateGameData({
    super.roomData,
    super.displayElements,
  });
}

class EndGameData extends GameData {
  final Player winner;

  EndGameData({required this.winner});
}

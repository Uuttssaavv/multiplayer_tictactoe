import 'package:flutter_project/models/enums/game_states.dart';
import 'package:flutter_project/models/player_model.dart';

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
    this.gameState = Game.idle,
    this.winner,
    this.round = 0,
  });
  final Map<String, dynamic> roomData;
  final List<String> displayElements;
  final int filledBoxes;
  final Player? player1;
  final Player? player2;
  final Player? winner;
  final bool isLoading;
  final String? errorMessage;
  final bool hasError;
  final bool isTapped;
  final bool isCreator;
  final bool isRoundCompleted;
  final Game gameState;
  final int round;
  GameState copyWith({
    Map<String, dynamic>? roomData,
    List<String>? displayElements,
    int? filledBoxes,
    Player? player1,
    bool? isLoading,
    Player? player2,
    String? errorMessage,
    bool? isCreator,
    Game? gameState,
    Player? winner,
    int? round,
  }) {
    return GameState(
      roomData: roomData?['_id'] != null ? roomData! : this.roomData,
      displayElements: displayElements ?? this.displayElements,
      filledBoxes: filledBoxes ?? this.filledBoxes,
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isCreator: isCreator ?? this.isCreator,
      gameState: gameState ?? this.gameState,
      winner: winner ?? this.winner,
      round: round ?? this.round,
    );
  }
}

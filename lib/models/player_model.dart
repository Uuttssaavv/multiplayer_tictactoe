class Player {
  final String nickname;
  final String socketID;
  final double points;
  final String playerType;
  final bool isCreator;
  Player({
    required this.nickname,
    required this.socketID,
    required this.points,
    required this.playerType,
    required this.isCreator,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'points': points,
      'playerType': playerType,
      'isCreator': isCreator,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] ?? '',
      socketID: map['socketID'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      playerType: map['playerType'] ?? '',
      isCreator: map['isCreator'] ?? false,
    );
  }

  Player copyWith({
    String? nickname,
    String? socketID,
    double? points,
    String? playerType,
    bool? isCreator,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
      isCreator: isCreator ?? this.isCreator,
    );
  }
}

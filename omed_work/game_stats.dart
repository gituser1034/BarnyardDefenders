class GameStats {
  final int? gamesPlayed;
  final int? gamesWon;
  final int? highestScore;

  GameStats({this.gamesPlayed, this.gamesWon, this.highestScore});

  Map<String, dynamic> toMap() {
    return {
      'gamesPlayed': gamesPlayed,
      'gamesWon': gamesWon,
      'highestScore': highestScore,
    };
  }
}
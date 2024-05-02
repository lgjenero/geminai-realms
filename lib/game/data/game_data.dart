import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geminai_realms/game/data/game_chapter.dart';
import 'package:geminai_realms/utils/constants/realms.dart';

part 'game_data.freezed.dart';
part 'game_data.g.dart';

enum GameLength {
  none._('None'),
  short._('A Short Game'),
  medium._('A Medium Lenght Game'),
  long._('A Long Game');

  final String label;
  const GameLength._(this.label);
}

@freezed
class GameData with _$GameData {
  const factory GameData({
    required AppRealms realm,
    required GameLength length,
    String? world,
    String? character,
    String? intro,
    @Default([]) List<GameChapter> chapters,
  }) = _GameData;

  factory GameData.fromJson(Map<String, dynamic> json) => _$GameDataFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geminai_realms/game/data/game_chapter_event.dart';

part 'game_chapter.freezed.dart';
part 'game_chapter.g.dart';

@freezed
class GameChapter with _$GameChapter {
  const factory GameChapter({
    required String location,
    required String situation,
    required String summary,
    required String intro,
    @Default([]) List<GameChapterEvent> events,
    required bool finished,
    String? finishText,
    String? compression,
  }) = _GameChapter;

  factory GameChapter.fromJson(Map<String, dynamic> json) => _$GameChapterFromJson(json);
}

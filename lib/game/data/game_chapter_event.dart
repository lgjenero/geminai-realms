// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_chapter_event.freezed.dart';
part 'game_chapter_event.g.dart';

@freezed
class GameChapterEvent with _$GameChapterEvent {
  const factory GameChapterEvent({
    @JsonKey(name: 'call_for_action') required String callForAction,
    @JsonKey(name: 'action_options') required List<String> actionOptions,
    @JsonKey(name: 'action_options_probablity') required List<double> actionOptionsProbability,
    @JsonKey(name: 'selected_action') String? selectedAction,
    bool? success,
    String? result,
  }) = _GameChapterEvent;

  factory GameChapterEvent.fromJson(Map<String, dynamic> json) => _$GameChapterEventFromJson(json);
}

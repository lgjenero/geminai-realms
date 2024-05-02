// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_chapter_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameChapterEventImpl _$$GameChapterEventImplFromJson(
        Map<String, dynamic> json) =>
    _$GameChapterEventImpl(
      callForAction: json['call_for_action'] as String,
      actionOptions: (json['action_options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      actionOptionsProbability:
          (json['action_options_probablity'] as List<dynamic>)
              .map((e) => (e as num).toDouble())
              .toList(),
      selectedAction: json['selected_action'] as String?,
      success: json['success'] as bool?,
      result: json['result'] as String?,
    );

Map<String, dynamic> _$$GameChapterEventImplToJson(
        _$GameChapterEventImpl instance) =>
    <String, dynamic>{
      'call_for_action': instance.callForAction,
      'action_options': instance.actionOptions,
      'action_options_probablity': instance.actionOptionsProbability,
      'selected_action': instance.selectedAction,
      'success': instance.success,
      'result': instance.result,
    };

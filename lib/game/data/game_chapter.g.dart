// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameChapterImpl _$$GameChapterImplFromJson(Map<String, dynamic> json) =>
    _$GameChapterImpl(
      location: json['location'] as String,
      situation: json['situation'] as String,
      summary: json['summary'] as String,
      intro: json['intro'] as String,
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => GameChapterEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      finished: json['finished'] as bool,
      finishText: json['finishText'] as String?,
      compression: json['compression'] as String?,
    );

Map<String, dynamic> _$$GameChapterImplToJson(_$GameChapterImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'situation': instance.situation,
      'summary': instance.summary,
      'intro': instance.intro,
      'events': instance.events.map((e) => e.toJson()).toList(),
      'finished': instance.finished,
      'finishText': instance.finishText,
      'compression': instance.compression,
    };

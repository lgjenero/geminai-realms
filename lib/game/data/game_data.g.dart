// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameDataImpl _$$GameDataImplFromJson(Map<String, dynamic> json) =>
    _$GameDataImpl(
      realm: $enumDecode(_$AppRealmsEnumMap, json['realm']),
      length: $enumDecode(_$GameLengthEnumMap, json['length']),
      world: json['world'] as String?,
      character: json['character'] as String?,
      intro: json['intro'] as String?,
      chapters: (json['chapters'] as List<dynamic>?)
              ?.map((e) => GameChapter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GameDataImplToJson(_$GameDataImpl instance) =>
    <String, dynamic>{
      'realm': _$AppRealmsEnumMap[instance.realm]!,
      'length': _$GameLengthEnumMap[instance.length]!,
      'world': instance.world,
      'character': instance.character,
      'intro': instance.intro,
      'chapters': instance.chapters.map((e) => e.toJson()).toList(),
    };

const _$AppRealmsEnumMap = {
  AppRealms.none: 'none',
  AppRealms.fantasy: 'fantasy',
  AppRealms.greek: 'greek',
  AppRealms.cyberpunk: 'cyberpunk',
};

const _$GameLengthEnumMap = {
  GameLength.none: 'none',
  GameLength.short: 'short',
  GameLength.medium: 'medium',
  GameLength.long: 'long',
};

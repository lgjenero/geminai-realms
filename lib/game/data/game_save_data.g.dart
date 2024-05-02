// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_save_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameSaveDataImpl _$$GameSaveDataImplFromJson(Map<String, dynamic> json) =>
    _$GameSaveDataImpl(
      gameData: GameData.fromJson(json['gameData'] as Map<String, dynamic>),
      status: $enumDecode(_$GameStatusEnumMap, json['status']),
      slot: json['slot'] as String,
      name: json['name'] as String?,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$GameSaveDataImplToJson(_$GameSaveDataImpl instance) =>
    <String, dynamic>{
      'gameData': instance.gameData.toJson(),
      'status': _$GameStatusEnumMap[instance.status]!,
      'slot': instance.slot,
      'name': instance.name,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };

const _$GameStatusEnumMap = {
  GameStatus.none: 'none',
  GameStatus.loading: 'loading',
  GameStatus.chooseRealm: 'chooseRealm',
  GameStatus.chooseLength: 'chooseLength',
  GameStatus.ready: 'ready',
  GameStatus.playing: 'playing',
  GameStatus.died: 'died',
  GameStatus.gameOver: 'gameOver',
};

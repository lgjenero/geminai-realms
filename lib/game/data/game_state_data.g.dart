// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateDataImpl _$$GameStateDataImplFromJson(Map<String, dynamic> json) =>
    _$GameStateDataImpl(
      gameData: GameData.fromJson(json['gameData'] as Map<String, dynamic>),
      status: $enumDecode(_$GameStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$GameStateDataImplToJson(_$GameStateDataImpl instance) =>
    <String, dynamic>{
      'gameData': instance.gameData.toJson(),
      'status': _$GameStatusEnumMap[instance.status]!,
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

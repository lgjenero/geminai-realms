// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameStateData _$GameStateDataFromJson(Map<String, dynamic> json) {
  return _GameStateData.fromJson(json);
}

/// @nodoc
mixin _$GameStateData {
  GameData get gameData => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameStateDataCopyWith<GameStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateDataCopyWith<$Res> {
  factory $GameStateDataCopyWith(
          GameStateData value, $Res Function(GameStateData) then) =
      _$GameStateDataCopyWithImpl<$Res, GameStateData>;
  @useResult
  $Res call({GameData gameData, GameStatus status});

  $GameDataCopyWith<$Res> get gameData;
}

/// @nodoc
class _$GameStateDataCopyWithImpl<$Res, $Val extends GameStateData>
    implements $GameStateDataCopyWith<$Res> {
  _$GameStateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameData = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      gameData: null == gameData
          ? _value.gameData
          : gameData // ignore: cast_nullable_to_non_nullable
              as GameData,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameDataCopyWith<$Res> get gameData {
    return $GameDataCopyWith<$Res>(_value.gameData, (value) {
      return _then(_value.copyWith(gameData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStateDataImplCopyWith<$Res>
    implements $GameStateDataCopyWith<$Res> {
  factory _$$GameStateDataImplCopyWith(
          _$GameStateDataImpl value, $Res Function(_$GameStateDataImpl) then) =
      __$$GameStateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GameData gameData, GameStatus status});

  @override
  $GameDataCopyWith<$Res> get gameData;
}

/// @nodoc
class __$$GameStateDataImplCopyWithImpl<$Res>
    extends _$GameStateDataCopyWithImpl<$Res, _$GameStateDataImpl>
    implements _$$GameStateDataImplCopyWith<$Res> {
  __$$GameStateDataImplCopyWithImpl(
      _$GameStateDataImpl _value, $Res Function(_$GameStateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameData = null,
    Object? status = null,
  }) {
    return _then(_$GameStateDataImpl(
      gameData: null == gameData
          ? _value.gameData
          : gameData // ignore: cast_nullable_to_non_nullable
              as GameData,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateDataImpl implements _GameStateData {
  const _$GameStateDataImpl({required this.gameData, required this.status});

  factory _$GameStateDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateDataImplFromJson(json);

  @override
  final GameData gameData;
  @override
  final GameStatus status;

  @override
  String toString() {
    return 'GameStateData(gameData: $gameData, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateDataImpl &&
            (identical(other.gameData, gameData) ||
                other.gameData == gameData) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, gameData, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateDataImplCopyWith<_$GameStateDataImpl> get copyWith =>
      __$$GameStateDataImplCopyWithImpl<_$GameStateDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateDataImplToJson(
      this,
    );
  }
}

abstract class _GameStateData implements GameStateData {
  const factory _GameStateData(
      {required final GameData gameData,
      required final GameStatus status}) = _$GameStateDataImpl;

  factory _GameStateData.fromJson(Map<String, dynamic> json) =
      _$GameStateDataImpl.fromJson;

  @override
  GameData get gameData;
  @override
  GameStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$GameStateDataImplCopyWith<_$GameStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

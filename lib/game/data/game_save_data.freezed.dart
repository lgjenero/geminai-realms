// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_save_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameSaveData _$GameSaveDataFromJson(Map<String, dynamic> json) {
  return _GameSaveData.fromJson(json);
}

/// @nodoc
mixin _$GameSaveData {
  GameData get gameData => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  String get slot => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameSaveDataCopyWith<GameSaveData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameSaveDataCopyWith<$Res> {
  factory $GameSaveDataCopyWith(
          GameSaveData value, $Res Function(GameSaveData) then) =
      _$GameSaveDataCopyWithImpl<$Res, GameSaveData>;
  @useResult
  $Res call(
      {GameData gameData,
      GameStatus status,
      String slot,
      String? name,
      @DateTimeConverter() DateTime? createdAt});

  $GameDataCopyWith<$Res> get gameData;
}

/// @nodoc
class _$GameSaveDataCopyWithImpl<$Res, $Val extends GameSaveData>
    implements $GameSaveDataCopyWith<$Res> {
  _$GameSaveDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameData = null,
    Object? status = null,
    Object? slot = null,
    Object? name = freezed,
    Object? createdAt = freezed,
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
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
abstract class _$$GameSaveDataImplCopyWith<$Res>
    implements $GameSaveDataCopyWith<$Res> {
  factory _$$GameSaveDataImplCopyWith(
          _$GameSaveDataImpl value, $Res Function(_$GameSaveDataImpl) then) =
      __$$GameSaveDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GameData gameData,
      GameStatus status,
      String slot,
      String? name,
      @DateTimeConverter() DateTime? createdAt});

  @override
  $GameDataCopyWith<$Res> get gameData;
}

/// @nodoc
class __$$GameSaveDataImplCopyWithImpl<$Res>
    extends _$GameSaveDataCopyWithImpl<$Res, _$GameSaveDataImpl>
    implements _$$GameSaveDataImplCopyWith<$Res> {
  __$$GameSaveDataImplCopyWithImpl(
      _$GameSaveDataImpl _value, $Res Function(_$GameSaveDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameData = null,
    Object? status = null,
    Object? slot = null,
    Object? name = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$GameSaveDataImpl(
      gameData: null == gameData
          ? _value.gameData
          : gameData // ignore: cast_nullable_to_non_nullable
              as GameData,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameSaveDataImpl implements _GameSaveData {
  const _$GameSaveDataImpl(
      {required this.gameData,
      required this.status,
      required this.slot,
      this.name,
      @DateTimeConverter() this.createdAt});

  factory _$GameSaveDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameSaveDataImplFromJson(json);

  @override
  final GameData gameData;
  @override
  final GameStatus status;
  @override
  final String slot;
  @override
  final String? name;
  @override
  @DateTimeConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'GameSaveData(gameData: $gameData, status: $status, slot: $slot, name: $name, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameSaveDataImpl &&
            (identical(other.gameData, gameData) ||
                other.gameData == gameData) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, gameData, status, slot, name, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameSaveDataImplCopyWith<_$GameSaveDataImpl> get copyWith =>
      __$$GameSaveDataImplCopyWithImpl<_$GameSaveDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameSaveDataImplToJson(
      this,
    );
  }
}

abstract class _GameSaveData implements GameSaveData {
  const factory _GameSaveData(
      {required final GameData gameData,
      required final GameStatus status,
      required final String slot,
      final String? name,
      @DateTimeConverter() final DateTime? createdAt}) = _$GameSaveDataImpl;

  factory _GameSaveData.fromJson(Map<String, dynamic> json) =
      _$GameSaveDataImpl.fromJson;

  @override
  GameData get gameData;
  @override
  GameStatus get status;
  @override
  String get slot;
  @override
  String? get name;
  @override
  @DateTimeConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$GameSaveDataImplCopyWith<_$GameSaveDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

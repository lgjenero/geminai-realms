// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameData _$GameDataFromJson(Map<String, dynamic> json) {
  return _GameData.fromJson(json);
}

/// @nodoc
mixin _$GameData {
  AppRealms get realm => throw _privateConstructorUsedError;
  GameLength get length => throw _privateConstructorUsedError;
  String? get world => throw _privateConstructorUsedError;
  String? get character => throw _privateConstructorUsedError;
  String? get intro => throw _privateConstructorUsedError;
  List<GameChapter> get chapters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameDataCopyWith<GameData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameDataCopyWith<$Res> {
  factory $GameDataCopyWith(GameData value, $Res Function(GameData) then) =
      _$GameDataCopyWithImpl<$Res, GameData>;
  @useResult
  $Res call(
      {AppRealms realm,
      GameLength length,
      String? world,
      String? character,
      String? intro,
      List<GameChapter> chapters});
}

/// @nodoc
class _$GameDataCopyWithImpl<$Res, $Val extends GameData>
    implements $GameDataCopyWith<$Res> {
  _$GameDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? realm = null,
    Object? length = null,
    Object? world = freezed,
    Object? character = freezed,
    Object? intro = freezed,
    Object? chapters = null,
  }) {
    return _then(_value.copyWith(
      realm: null == realm
          ? _value.realm
          : realm // ignore: cast_nullable_to_non_nullable
              as AppRealms,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as GameLength,
      world: freezed == world
          ? _value.world
          : world // ignore: cast_nullable_to_non_nullable
              as String?,
      character: freezed == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String?,
      intro: freezed == intro
          ? _value.intro
          : intro // ignore: cast_nullable_to_non_nullable
              as String?,
      chapters: null == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<GameChapter>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameDataImplCopyWith<$Res>
    implements $GameDataCopyWith<$Res> {
  factory _$$GameDataImplCopyWith(
          _$GameDataImpl value, $Res Function(_$GameDataImpl) then) =
      __$$GameDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppRealms realm,
      GameLength length,
      String? world,
      String? character,
      String? intro,
      List<GameChapter> chapters});
}

/// @nodoc
class __$$GameDataImplCopyWithImpl<$Res>
    extends _$GameDataCopyWithImpl<$Res, _$GameDataImpl>
    implements _$$GameDataImplCopyWith<$Res> {
  __$$GameDataImplCopyWithImpl(
      _$GameDataImpl _value, $Res Function(_$GameDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? realm = null,
    Object? length = null,
    Object? world = freezed,
    Object? character = freezed,
    Object? intro = freezed,
    Object? chapters = null,
  }) {
    return _then(_$GameDataImpl(
      realm: null == realm
          ? _value.realm
          : realm // ignore: cast_nullable_to_non_nullable
              as AppRealms,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as GameLength,
      world: freezed == world
          ? _value.world
          : world // ignore: cast_nullable_to_non_nullable
              as String?,
      character: freezed == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String?,
      intro: freezed == intro
          ? _value.intro
          : intro // ignore: cast_nullable_to_non_nullable
              as String?,
      chapters: null == chapters
          ? _value._chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<GameChapter>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameDataImpl implements _GameData {
  const _$GameDataImpl(
      {required this.realm,
      required this.length,
      this.world,
      this.character,
      this.intro,
      final List<GameChapter> chapters = const []})
      : _chapters = chapters;

  factory _$GameDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameDataImplFromJson(json);

  @override
  final AppRealms realm;
  @override
  final GameLength length;
  @override
  final String? world;
  @override
  final String? character;
  @override
  final String? intro;
  final List<GameChapter> _chapters;
  @override
  @JsonKey()
  List<GameChapter> get chapters {
    if (_chapters is EqualUnmodifiableListView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chapters);
  }

  @override
  String toString() {
    return 'GameData(realm: $realm, length: $length, world: $world, character: $character, intro: $intro, chapters: $chapters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameDataImpl &&
            (identical(other.realm, realm) || other.realm == realm) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.world, world) || other.world == world) &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.intro, intro) || other.intro == intro) &&
            const DeepCollectionEquality().equals(other._chapters, _chapters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, realm, length, world, character,
      intro, const DeepCollectionEquality().hash(_chapters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameDataImplCopyWith<_$GameDataImpl> get copyWith =>
      __$$GameDataImplCopyWithImpl<_$GameDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameDataImplToJson(
      this,
    );
  }
}

abstract class _GameData implements GameData {
  const factory _GameData(
      {required final AppRealms realm,
      required final GameLength length,
      final String? world,
      final String? character,
      final String? intro,
      final List<GameChapter> chapters}) = _$GameDataImpl;

  factory _GameData.fromJson(Map<String, dynamic> json) =
      _$GameDataImpl.fromJson;

  @override
  AppRealms get realm;
  @override
  GameLength get length;
  @override
  String? get world;
  @override
  String? get character;
  @override
  String? get intro;
  @override
  List<GameChapter> get chapters;
  @override
  @JsonKey(ignore: true)
  _$$GameDataImplCopyWith<_$GameDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

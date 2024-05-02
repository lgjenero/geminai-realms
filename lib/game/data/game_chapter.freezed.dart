// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_chapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameChapter _$GameChapterFromJson(Map<String, dynamic> json) {
  return _GameChapter.fromJson(json);
}

/// @nodoc
mixin _$GameChapter {
  String get location => throw _privateConstructorUsedError;
  String get situation => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get intro => throw _privateConstructorUsedError;
  List<GameChapterEvent> get events => throw _privateConstructorUsedError;
  bool get finished => throw _privateConstructorUsedError;
  String? get finishText => throw _privateConstructorUsedError;
  String? get compression => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameChapterCopyWith<GameChapter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameChapterCopyWith<$Res> {
  factory $GameChapterCopyWith(
          GameChapter value, $Res Function(GameChapter) then) =
      _$GameChapterCopyWithImpl<$Res, GameChapter>;
  @useResult
  $Res call(
      {String location,
      String situation,
      String summary,
      String intro,
      List<GameChapterEvent> events,
      bool finished,
      String? finishText,
      String? compression});
}

/// @nodoc
class _$GameChapterCopyWithImpl<$Res, $Val extends GameChapter>
    implements $GameChapterCopyWith<$Res> {
  _$GameChapterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? situation = null,
    Object? summary = null,
    Object? intro = null,
    Object? events = null,
    Object? finished = null,
    Object? finishText = freezed,
    Object? compression = freezed,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      situation: null == situation
          ? _value.situation
          : situation // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      intro: null == intro
          ? _value.intro
          : intro // ignore: cast_nullable_to_non_nullable
              as String,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<GameChapterEvent>,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      finishText: freezed == finishText
          ? _value.finishText
          : finishText // ignore: cast_nullable_to_non_nullable
              as String?,
      compression: freezed == compression
          ? _value.compression
          : compression // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameChapterImplCopyWith<$Res>
    implements $GameChapterCopyWith<$Res> {
  factory _$$GameChapterImplCopyWith(
          _$GameChapterImpl value, $Res Function(_$GameChapterImpl) then) =
      __$$GameChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String location,
      String situation,
      String summary,
      String intro,
      List<GameChapterEvent> events,
      bool finished,
      String? finishText,
      String? compression});
}

/// @nodoc
class __$$GameChapterImplCopyWithImpl<$Res>
    extends _$GameChapterCopyWithImpl<$Res, _$GameChapterImpl>
    implements _$$GameChapterImplCopyWith<$Res> {
  __$$GameChapterImplCopyWithImpl(
      _$GameChapterImpl _value, $Res Function(_$GameChapterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? situation = null,
    Object? summary = null,
    Object? intro = null,
    Object? events = null,
    Object? finished = null,
    Object? finishText = freezed,
    Object? compression = freezed,
  }) {
    return _then(_$GameChapterImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      situation: null == situation
          ? _value.situation
          : situation // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      intro: null == intro
          ? _value.intro
          : intro // ignore: cast_nullable_to_non_nullable
              as String,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<GameChapterEvent>,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      finishText: freezed == finishText
          ? _value.finishText
          : finishText // ignore: cast_nullable_to_non_nullable
              as String?,
      compression: freezed == compression
          ? _value.compression
          : compression // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameChapterImpl implements _GameChapter {
  const _$GameChapterImpl(
      {required this.location,
      required this.situation,
      required this.summary,
      required this.intro,
      final List<GameChapterEvent> events = const [],
      required this.finished,
      this.finishText,
      this.compression})
      : _events = events;

  factory _$GameChapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameChapterImplFromJson(json);

  @override
  final String location;
  @override
  final String situation;
  @override
  final String summary;
  @override
  final String intro;
  final List<GameChapterEvent> _events;
  @override
  @JsonKey()
  List<GameChapterEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  final bool finished;
  @override
  final String? finishText;
  @override
  final String? compression;

  @override
  String toString() {
    return 'GameChapter(location: $location, situation: $situation, summary: $summary, intro: $intro, events: $events, finished: $finished, finishText: $finishText, compression: $compression)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameChapterImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.situation, situation) ||
                other.situation == situation) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.intro, intro) || other.intro == intro) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            (identical(other.finished, finished) ||
                other.finished == finished) &&
            (identical(other.finishText, finishText) ||
                other.finishText == finishText) &&
            (identical(other.compression, compression) ||
                other.compression == compression));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      location,
      situation,
      summary,
      intro,
      const DeepCollectionEquality().hash(_events),
      finished,
      finishText,
      compression);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameChapterImplCopyWith<_$GameChapterImpl> get copyWith =>
      __$$GameChapterImplCopyWithImpl<_$GameChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameChapterImplToJson(
      this,
    );
  }
}

abstract class _GameChapter implements GameChapter {
  const factory _GameChapter(
      {required final String location,
      required final String situation,
      required final String summary,
      required final String intro,
      final List<GameChapterEvent> events,
      required final bool finished,
      final String? finishText,
      final String? compression}) = _$GameChapterImpl;

  factory _GameChapter.fromJson(Map<String, dynamic> json) =
      _$GameChapterImpl.fromJson;

  @override
  String get location;
  @override
  String get situation;
  @override
  String get summary;
  @override
  String get intro;
  @override
  List<GameChapterEvent> get events;
  @override
  bool get finished;
  @override
  String? get finishText;
  @override
  String? get compression;
  @override
  @JsonKey(ignore: true)
  _$$GameChapterImplCopyWith<_$GameChapterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

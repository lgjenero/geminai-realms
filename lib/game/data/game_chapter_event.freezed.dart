// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_chapter_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameChapterEvent _$GameChapterEventFromJson(Map<String, dynamic> json) {
  return _GameChapterEvent.fromJson(json);
}

/// @nodoc
mixin _$GameChapterEvent {
  @JsonKey(name: 'call_for_action')
  String get callForAction => throw _privateConstructorUsedError;
  @JsonKey(name: 'action_options')
  List<String> get actionOptions => throw _privateConstructorUsedError;
  @JsonKey(name: 'action_options_probablity')
  List<double> get actionOptionsProbability =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'selected_action')
  String? get selectedAction => throw _privateConstructorUsedError;
  bool? get success => throw _privateConstructorUsedError;
  String? get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameChapterEventCopyWith<GameChapterEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameChapterEventCopyWith<$Res> {
  factory $GameChapterEventCopyWith(
          GameChapterEvent value, $Res Function(GameChapterEvent) then) =
      _$GameChapterEventCopyWithImpl<$Res, GameChapterEvent>;
  @useResult
  $Res call(
      {@JsonKey(name: 'call_for_action') String callForAction,
      @JsonKey(name: 'action_options') List<String> actionOptions,
      @JsonKey(name: 'action_options_probablity')
      List<double> actionOptionsProbability,
      @JsonKey(name: 'selected_action') String? selectedAction,
      bool? success,
      String? result});
}

/// @nodoc
class _$GameChapterEventCopyWithImpl<$Res, $Val extends GameChapterEvent>
    implements $GameChapterEventCopyWith<$Res> {
  _$GameChapterEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callForAction = null,
    Object? actionOptions = null,
    Object? actionOptionsProbability = null,
    Object? selectedAction = freezed,
    Object? success = freezed,
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      callForAction: null == callForAction
          ? _value.callForAction
          : callForAction // ignore: cast_nullable_to_non_nullable
              as String,
      actionOptions: null == actionOptions
          ? _value.actionOptions
          : actionOptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      actionOptionsProbability: null == actionOptionsProbability
          ? _value.actionOptionsProbability
          : actionOptionsProbability // ignore: cast_nullable_to_non_nullable
              as List<double>,
      selectedAction: freezed == selectedAction
          ? _value.selectedAction
          : selectedAction // ignore: cast_nullable_to_non_nullable
              as String?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameChapterEventImplCopyWith<$Res>
    implements $GameChapterEventCopyWith<$Res> {
  factory _$$GameChapterEventImplCopyWith(_$GameChapterEventImpl value,
          $Res Function(_$GameChapterEventImpl) then) =
      __$$GameChapterEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'call_for_action') String callForAction,
      @JsonKey(name: 'action_options') List<String> actionOptions,
      @JsonKey(name: 'action_options_probablity')
      List<double> actionOptionsProbability,
      @JsonKey(name: 'selected_action') String? selectedAction,
      bool? success,
      String? result});
}

/// @nodoc
class __$$GameChapterEventImplCopyWithImpl<$Res>
    extends _$GameChapterEventCopyWithImpl<$Res, _$GameChapterEventImpl>
    implements _$$GameChapterEventImplCopyWith<$Res> {
  __$$GameChapterEventImplCopyWithImpl(_$GameChapterEventImpl _value,
      $Res Function(_$GameChapterEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callForAction = null,
    Object? actionOptions = null,
    Object? actionOptionsProbability = null,
    Object? selectedAction = freezed,
    Object? success = freezed,
    Object? result = freezed,
  }) {
    return _then(_$GameChapterEventImpl(
      callForAction: null == callForAction
          ? _value.callForAction
          : callForAction // ignore: cast_nullable_to_non_nullable
              as String,
      actionOptions: null == actionOptions
          ? _value._actionOptions
          : actionOptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      actionOptionsProbability: null == actionOptionsProbability
          ? _value._actionOptionsProbability
          : actionOptionsProbability // ignore: cast_nullable_to_non_nullable
              as List<double>,
      selectedAction: freezed == selectedAction
          ? _value.selectedAction
          : selectedAction // ignore: cast_nullable_to_non_nullable
              as String?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameChapterEventImpl implements _GameChapterEvent {
  const _$GameChapterEventImpl(
      {@JsonKey(name: 'call_for_action') required this.callForAction,
      @JsonKey(name: 'action_options')
      required final List<String> actionOptions,
      @JsonKey(name: 'action_options_probablity')
      required final List<double> actionOptionsProbability,
      @JsonKey(name: 'selected_action') this.selectedAction,
      this.success,
      this.result})
      : _actionOptions = actionOptions,
        _actionOptionsProbability = actionOptionsProbability;

  factory _$GameChapterEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameChapterEventImplFromJson(json);

  @override
  @JsonKey(name: 'call_for_action')
  final String callForAction;
  final List<String> _actionOptions;
  @override
  @JsonKey(name: 'action_options')
  List<String> get actionOptions {
    if (_actionOptions is EqualUnmodifiableListView) return _actionOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actionOptions);
  }

  final List<double> _actionOptionsProbability;
  @override
  @JsonKey(name: 'action_options_probablity')
  List<double> get actionOptionsProbability {
    if (_actionOptionsProbability is EqualUnmodifiableListView)
      return _actionOptionsProbability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actionOptionsProbability);
  }

  @override
  @JsonKey(name: 'selected_action')
  final String? selectedAction;
  @override
  final bool? success;
  @override
  final String? result;

  @override
  String toString() {
    return 'GameChapterEvent(callForAction: $callForAction, actionOptions: $actionOptions, actionOptionsProbability: $actionOptionsProbability, selectedAction: $selectedAction, success: $success, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameChapterEventImpl &&
            (identical(other.callForAction, callForAction) ||
                other.callForAction == callForAction) &&
            const DeepCollectionEquality()
                .equals(other._actionOptions, _actionOptions) &&
            const DeepCollectionEquality().equals(
                other._actionOptionsProbability, _actionOptionsProbability) &&
            (identical(other.selectedAction, selectedAction) ||
                other.selectedAction == selectedAction) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      callForAction,
      const DeepCollectionEquality().hash(_actionOptions),
      const DeepCollectionEquality().hash(_actionOptionsProbability),
      selectedAction,
      success,
      result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameChapterEventImplCopyWith<_$GameChapterEventImpl> get copyWith =>
      __$$GameChapterEventImplCopyWithImpl<_$GameChapterEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameChapterEventImplToJson(
      this,
    );
  }
}

abstract class _GameChapterEvent implements GameChapterEvent {
  const factory _GameChapterEvent(
      {@JsonKey(name: 'call_for_action') required final String callForAction,
      @JsonKey(name: 'action_options')
      required final List<String> actionOptions,
      @JsonKey(name: 'action_options_probablity')
      required final List<double> actionOptionsProbability,
      @JsonKey(name: 'selected_action') final String? selectedAction,
      final bool? success,
      final String? result}) = _$GameChapterEventImpl;

  factory _GameChapterEvent.fromJson(Map<String, dynamic> json) =
      _$GameChapterEventImpl.fromJson;

  @override
  @JsonKey(name: 'call_for_action')
  String get callForAction;
  @override
  @JsonKey(name: 'action_options')
  List<String> get actionOptions;
  @override
  @JsonKey(name: 'action_options_probablity')
  List<double> get actionOptionsProbability;
  @override
  @JsonKey(name: 'selected_action')
  String? get selectedAction;
  @override
  bool? get success;
  @override
  String? get result;
  @override
  @JsonKey(ignore: true)
  _$$GameChapterEventImplCopyWith<_$GameChapterEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

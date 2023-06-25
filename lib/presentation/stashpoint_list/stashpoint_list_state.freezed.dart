// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stashpoint_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StashpointListState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<StashpointItem> get stashpointList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StashpointListStateCopyWith<StashpointListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StashpointListStateCopyWith<$Res> {
  factory $StashpointListStateCopyWith(
          StashpointListState value, $Res Function(StashpointListState) then) =
      _$StashpointListStateCopyWithImpl<$Res, StashpointListState>;
  @useResult
  $Res call({bool isLoading, List<StashpointItem> stashpointList});
}

/// @nodoc
class _$StashpointListStateCopyWithImpl<$Res, $Val extends StashpointListState>
    implements $StashpointListStateCopyWith<$Res> {
  _$StashpointListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? stashpointList = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      stashpointList: null == stashpointList
          ? _value.stashpointList
          : stashpointList // ignore: cast_nullable_to_non_nullable
              as List<StashpointItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StashpointListStateCopyWith<$Res>
    implements $StashpointListStateCopyWith<$Res> {
  factory _$$_StashpointListStateCopyWith(_$_StashpointListState value,
          $Res Function(_$_StashpointListState) then) =
      __$$_StashpointListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<StashpointItem> stashpointList});
}

/// @nodoc
class __$$_StashpointListStateCopyWithImpl<$Res>
    extends _$StashpointListStateCopyWithImpl<$Res, _$_StashpointListState>
    implements _$$_StashpointListStateCopyWith<$Res> {
  __$$_StashpointListStateCopyWithImpl(_$_StashpointListState _value,
      $Res Function(_$_StashpointListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? stashpointList = null,
  }) {
    return _then(_$_StashpointListState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      stashpointList: null == stashpointList
          ? _value._stashpointList
          : stashpointList // ignore: cast_nullable_to_non_nullable
              as List<StashpointItem>,
    ));
  }
}

/// @nodoc

class _$_StashpointListState implements _StashpointListState {
  const _$_StashpointListState(
      {this.isLoading = true,
      final List<StashpointItem> stashpointList = const []})
      : _stashpointList = stashpointList;

  @override
  @JsonKey()
  final bool isLoading;
  final List<StashpointItem> _stashpointList;
  @override
  @JsonKey()
  List<StashpointItem> get stashpointList {
    if (_stashpointList is EqualUnmodifiableListView) return _stashpointList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stashpointList);
  }

  @override
  String toString() {
    return 'StashpointListState(isLoading: $isLoading, stashpointList: $stashpointList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StashpointListState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._stashpointList, _stashpointList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_stashpointList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StashpointListStateCopyWith<_$_StashpointListState> get copyWith =>
      __$$_StashpointListStateCopyWithImpl<_$_StashpointListState>(
          this, _$identity);
}

abstract class _StashpointListState implements StashpointListState {
  const factory _StashpointListState(
      {final bool isLoading,
      final List<StashpointItem> stashpointList}) = _$_StashpointListState;

  @override
  bool get isLoading;
  @override
  List<StashpointItem> get stashpointList;
  @override
  @JsonKey(ignore: true)
  _$$_StashpointListStateCopyWith<_$_StashpointListState> get copyWith =>
      throw _privateConstructorUsedError;
}

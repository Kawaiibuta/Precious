// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'option_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OptionValue _$OptionValueFromJson(Map<String, dynamic> json) {
  return _OptionValue.fromJson(json);
}

/// @nodoc
mixin _$OptionValue {
  int? get id => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OptionValueCopyWith<OptionValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionValueCopyWith<$Res> {
  factory $OptionValueCopyWith(
          OptionValue value, $Res Function(OptionValue) then) =
      _$OptionValueCopyWithImpl<$Res, OptionValue>;
  @useResult
  $Res call({int? id, String value});
}

/// @nodoc
class _$OptionValueCopyWithImpl<$Res, $Val extends OptionValue>
    implements $OptionValueCopyWith<$Res> {
  _$OptionValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OptionValueImplCopyWith<$Res>
    implements $OptionValueCopyWith<$Res> {
  factory _$$OptionValueImplCopyWith(
          _$OptionValueImpl value, $Res Function(_$OptionValueImpl) then) =
      __$$OptionValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String value});
}

/// @nodoc
class __$$OptionValueImplCopyWithImpl<$Res>
    extends _$OptionValueCopyWithImpl<$Res, _$OptionValueImpl>
    implements _$$OptionValueImplCopyWith<$Res> {
  __$$OptionValueImplCopyWithImpl(
      _$OptionValueImpl _value, $Res Function(_$OptionValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? value = null,
  }) {
    return _then(_$OptionValueImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OptionValueImpl with DiagnosticableTreeMixin implements _OptionValue {
  _$OptionValueImpl({this.id = null, required this.value});

  factory _$OptionValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$OptionValueImplFromJson(json);

  @override
  @JsonKey()
  final int? id;
  @override
  final String value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OptionValue(id: $id, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OptionValue'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionValueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionValueImplCopyWith<_$OptionValueImpl> get copyWith =>
      __$$OptionValueImplCopyWithImpl<_$OptionValueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OptionValueImplToJson(
      this,
    );
  }
}

abstract class _OptionValue implements OptionValue {
  factory _OptionValue({final int? id, required final String value}) =
      _$OptionValueImpl;

  factory _OptionValue.fromJson(Map<String, dynamic> json) =
      _$OptionValueImpl.fromJson;

  @override
  int? get id;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$OptionValueImplCopyWith<_$OptionValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

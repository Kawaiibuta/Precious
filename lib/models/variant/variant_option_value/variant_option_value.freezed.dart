// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variant_option_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VariantOptionValue _$VariantOptionValueFromJson(Map<String, dynamic> json) {
  return _VariantOptionValue.fromJson(json);
}

/// @nodoc
mixin _$VariantOptionValue {
  int? get id => throw _privateConstructorUsedError;
  Option get option => throw _privateConstructorUsedError;
  @JsonKey(name: 'option_value')
  OptionValue get optionValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VariantOptionValueCopyWith<VariantOptionValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariantOptionValueCopyWith<$Res> {
  factory $VariantOptionValueCopyWith(
          VariantOptionValue value, $Res Function(VariantOptionValue) then) =
      _$VariantOptionValueCopyWithImpl<$Res, VariantOptionValue>;
  @useResult
  $Res call(
      {int? id,
      Option option,
      @JsonKey(name: 'option_value') OptionValue optionValue});

  $OptionCopyWith<$Res> get option;
  $OptionValueCopyWith<$Res> get optionValue;
}

/// @nodoc
class _$VariantOptionValueCopyWithImpl<$Res, $Val extends VariantOptionValue>
    implements $VariantOptionValueCopyWith<$Res> {
  _$VariantOptionValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? option = null,
    Object? optionValue = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      option: null == option
          ? _value.option
          : option // ignore: cast_nullable_to_non_nullable
              as Option,
      optionValue: null == optionValue
          ? _value.optionValue
          : optionValue // ignore: cast_nullable_to_non_nullable
              as OptionValue,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OptionCopyWith<$Res> get option {
    return $OptionCopyWith<$Res>(_value.option, (value) {
      return _then(_value.copyWith(option: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OptionValueCopyWith<$Res> get optionValue {
    return $OptionValueCopyWith<$Res>(_value.optionValue, (value) {
      return _then(_value.copyWith(optionValue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VariantOptionValueImplCopyWith<$Res>
    implements $VariantOptionValueCopyWith<$Res> {
  factory _$$VariantOptionValueImplCopyWith(_$VariantOptionValueImpl value,
          $Res Function(_$VariantOptionValueImpl) then) =
      __$$VariantOptionValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      Option option,
      @JsonKey(name: 'option_value') OptionValue optionValue});

  @override
  $OptionCopyWith<$Res> get option;
  @override
  $OptionValueCopyWith<$Res> get optionValue;
}

/// @nodoc
class __$$VariantOptionValueImplCopyWithImpl<$Res>
    extends _$VariantOptionValueCopyWithImpl<$Res, _$VariantOptionValueImpl>
    implements _$$VariantOptionValueImplCopyWith<$Res> {
  __$$VariantOptionValueImplCopyWithImpl(_$VariantOptionValueImpl _value,
      $Res Function(_$VariantOptionValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? option = null,
    Object? optionValue = null,
  }) {
    return _then(_$VariantOptionValueImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      option: null == option
          ? _value.option
          : option // ignore: cast_nullable_to_non_nullable
              as Option,
      optionValue: null == optionValue
          ? _value.optionValue
          : optionValue // ignore: cast_nullable_to_non_nullable
              as OptionValue,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VariantOptionValueImpl
    with DiagnosticableTreeMixin
    implements _VariantOptionValue {
  _$VariantOptionValueImpl(
      {this.id = null,
      required this.option,
      @JsonKey(name: 'option_value') required this.optionValue});

  factory _$VariantOptionValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariantOptionValueImplFromJson(json);

  @override
  @JsonKey()
  final int? id;
  @override
  final Option option;
  @override
  @JsonKey(name: 'option_value')
  final OptionValue optionValue;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VariantOptionValue(id: $id, option: $option, optionValue: $optionValue)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VariantOptionValue'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('option', option))
      ..add(DiagnosticsProperty('optionValue', optionValue));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariantOptionValueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.option, option) || other.option == option) &&
            (identical(other.optionValue, optionValue) ||
                other.optionValue == optionValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, option, optionValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VariantOptionValueImplCopyWith<_$VariantOptionValueImpl> get copyWith =>
      __$$VariantOptionValueImplCopyWithImpl<_$VariantOptionValueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VariantOptionValueImplToJson(
      this,
    );
  }
}

abstract class _VariantOptionValue implements VariantOptionValue {
  factory _VariantOptionValue(
      {final int? id,
      required final Option option,
      @JsonKey(name: 'option_value')
      required final OptionValue optionValue}) = _$VariantOptionValueImpl;

  factory _VariantOptionValue.fromJson(Map<String, dynamic> json) =
      _$VariantOptionValueImpl.fromJson;

  @override
  int? get id;
  @override
  Option get option;
  @override
  @JsonKey(name: 'option_value')
  OptionValue get optionValue;
  @override
  @JsonKey(ignore: true)
  _$$VariantOptionValueImplCopyWith<_$VariantOptionValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

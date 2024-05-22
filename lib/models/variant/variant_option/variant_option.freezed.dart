// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variant_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VariantOption _$VariantOptionFromJson(Map<String, dynamic> json) {
  return _VariantOption.fromJson(json);
}

/// @nodoc
mixin _$VariantOption {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "option_id", includeToJson: false)
  int get optionId => throw _privateConstructorUsedError;
  Option? get option => throw _privateConstructorUsedError;
  @JsonKey(name: "option_value", includeToJson: false)
  OptionValue get optionValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VariantOptionCopyWith<VariantOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariantOptionCopyWith<$Res> {
  factory $VariantOptionCopyWith(
          VariantOption value, $Res Function(VariantOption) then) =
      _$VariantOptionCopyWithImpl<$Res, VariantOption>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: "option_id", includeToJson: false) int optionId,
      Option? option,
      @JsonKey(name: "option_value", includeToJson: false)
      OptionValue optionValue});

  $OptionCopyWith<$Res>? get option;
  $OptionValueCopyWith<$Res> get optionValue;
}

/// @nodoc
class _$VariantOptionCopyWithImpl<$Res, $Val extends VariantOption>
    implements $VariantOptionCopyWith<$Res> {
  _$VariantOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? optionId = null,
    Object? option = freezed,
    Object? optionValue = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      optionId: null == optionId
          ? _value.optionId
          : optionId // ignore: cast_nullable_to_non_nullable
              as int,
      option: freezed == option
          ? _value.option
          : option // ignore: cast_nullable_to_non_nullable
              as Option?,
      optionValue: null == optionValue
          ? _value.optionValue
          : optionValue // ignore: cast_nullable_to_non_nullable
              as OptionValue,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OptionCopyWith<$Res>? get option {
    if (_value.option == null) {
      return null;
    }

    return $OptionCopyWith<$Res>(_value.option!, (value) {
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
abstract class _$$VariantOptionImplCopyWith<$Res>
    implements $VariantOptionCopyWith<$Res> {
  factory _$$VariantOptionImplCopyWith(
          _$VariantOptionImpl value, $Res Function(_$VariantOptionImpl) then) =
      __$$VariantOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: "option_id", includeToJson: false) int optionId,
      Option? option,
      @JsonKey(name: "option_value", includeToJson: false)
      OptionValue optionValue});

  @override
  $OptionCopyWith<$Res>? get option;
  @override
  $OptionValueCopyWith<$Res> get optionValue;
}

/// @nodoc
class __$$VariantOptionImplCopyWithImpl<$Res>
    extends _$VariantOptionCopyWithImpl<$Res, _$VariantOptionImpl>
    implements _$$VariantOptionImplCopyWith<$Res> {
  __$$VariantOptionImplCopyWithImpl(
      _$VariantOptionImpl _value, $Res Function(_$VariantOptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? optionId = null,
    Object? option = freezed,
    Object? optionValue = null,
  }) {
    return _then(_$VariantOptionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      optionId: null == optionId
          ? _value.optionId
          : optionId // ignore: cast_nullable_to_non_nullable
              as int,
      option: freezed == option
          ? _value.option
          : option // ignore: cast_nullable_to_non_nullable
              as Option?,
      optionValue: null == optionValue
          ? _value.optionValue
          : optionValue // ignore: cast_nullable_to_non_nullable
              as OptionValue,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VariantOptionImpl
    with DiagnosticableTreeMixin
    implements _VariantOption {
  _$VariantOptionImpl(
      {@JsonKey(includeToJson: false) this.id = null,
      @JsonKey(name: "option_id", includeToJson: false) required this.optionId,
      this.option,
      @JsonKey(name: "option_value", includeToJson: false)
      required this.optionValue});

  factory _$VariantOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariantOptionImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: "option_id", includeToJson: false)
  final int optionId;
  @override
  final Option? option;
  @override
  @JsonKey(name: "option_value", includeToJson: false)
  final OptionValue optionValue;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VariantOption(id: $id, optionId: $optionId, option: $option, optionValue: $optionValue)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VariantOption'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('optionId', optionId))
      ..add(DiagnosticsProperty('option', option))
      ..add(DiagnosticsProperty('optionValue', optionValue));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariantOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.optionId, optionId) ||
                other.optionId == optionId) &&
            (identical(other.option, option) || other.option == option) &&
            (identical(other.optionValue, optionValue) ||
                other.optionValue == optionValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, optionId, option, optionValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VariantOptionImplCopyWith<_$VariantOptionImpl> get copyWith =>
      __$$VariantOptionImplCopyWithImpl<_$VariantOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VariantOptionImplToJson(
      this,
    );
  }
}

abstract class _VariantOption implements VariantOption {
  factory _VariantOption(
      {@JsonKey(includeToJson: false) final int? id,
      @JsonKey(name: "option_id", includeToJson: false)
      required final int optionId,
      final Option? option,
      @JsonKey(name: "option_value", includeToJson: false)
      required final OptionValue optionValue}) = _$VariantOptionImpl;

  factory _VariantOption.fromJson(Map<String, dynamic> json) =
      _$VariantOptionImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  @JsonKey(name: "option_id", includeToJson: false)
  int get optionId;
  @override
  Option? get option;
  @override
  @JsonKey(name: "option_value", includeToJson: false)
  OptionValue get optionValue;
  @override
  @JsonKey(ignore: true)
  _$$VariantOptionImplCopyWith<_$VariantOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

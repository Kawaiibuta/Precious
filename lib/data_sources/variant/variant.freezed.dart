// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Variant _$VariantFromJson(Map<String, dynamic> json) {
  return _Variant.fromJson(json);
}

/// @nodoc
mixin _$Variant {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: "variant_option_values", includeToJson: false)
  List<VariantOption>? get variantOptionValues =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "img_paths_url", includeToJson: false)
  List<String> get imgPathUrls => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VariantCopyWith<Variant> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariantCopyWith<$Res> {
  factory $VariantCopyWith(Variant value, $Res Function(Variant) then) =
      _$VariantCopyWithImpl<$Res, Variant>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      String name,
      double price,
      int quantity,
      @JsonKey(name: "variant_option_values", includeToJson: false)
      List<VariantOption>? variantOptionValues,
      @JsonKey(name: "img_paths_url", includeToJson: false)
      List<String> imgPathUrls});
}

/// @nodoc
class _$VariantCopyWithImpl<$Res, $Val extends Variant>
    implements $VariantCopyWith<$Res> {
  _$VariantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
    Object? variantOptionValues = freezed,
    Object? imgPathUrls = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      variantOptionValues: freezed == variantOptionValues
          ? _value.variantOptionValues
          : variantOptionValues // ignore: cast_nullable_to_non_nullable
              as List<VariantOption>?,
      imgPathUrls: null == imgPathUrls
          ? _value.imgPathUrls
          : imgPathUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VariantImplCopyWith<$Res> implements $VariantCopyWith<$Res> {
  factory _$$VariantImplCopyWith(
          _$VariantImpl value, $Res Function(_$VariantImpl) then) =
      __$$VariantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      String name,
      double price,
      int quantity,
      @JsonKey(name: "variant_option_values", includeToJson: false)
      List<VariantOption>? variantOptionValues,
      @JsonKey(name: "img_paths_url", includeToJson: false)
      List<String> imgPathUrls});
}

/// @nodoc
class __$$VariantImplCopyWithImpl<$Res>
    extends _$VariantCopyWithImpl<$Res, _$VariantImpl>
    implements _$$VariantImplCopyWith<$Res> {
  __$$VariantImplCopyWithImpl(
      _$VariantImpl _value, $Res Function(_$VariantImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
    Object? variantOptionValues = freezed,
    Object? imgPathUrls = null,
  }) {
    return _then(_$VariantImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      variantOptionValues: freezed == variantOptionValues
          ? _value._variantOptionValues
          : variantOptionValues // ignore: cast_nullable_to_non_nullable
              as List<VariantOption>?,
      imgPathUrls: null == imgPathUrls
          ? _value._imgPathUrls
          : imgPathUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VariantImpl with DiagnosticableTreeMixin implements _Variant {
  _$VariantImpl(
      {@JsonKey(includeToJson: false) this.id = null,
      required this.name,
      this.price = 0.0,
      this.quantity = 0,
      @JsonKey(name: "variant_option_values", includeToJson: false)
      final List<VariantOption>? variantOptionValues,
      @JsonKey(name: "img_paths_url", includeToJson: false)
      final List<String> imgPathUrls = const <String>[]})
      : _variantOptionValues = variantOptionValues,
        _imgPathUrls = imgPathUrls;

  factory _$VariantImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariantImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  final String name;
  @override
  @JsonKey()
  final double price;
  @override
  @JsonKey()
  final int quantity;
  final List<VariantOption>? _variantOptionValues;
  @override
  @JsonKey(name: "variant_option_values", includeToJson: false)
  List<VariantOption>? get variantOptionValues {
    final value = _variantOptionValues;
    if (value == null) return null;
    if (_variantOptionValues is EqualUnmodifiableListView)
      return _variantOptionValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _imgPathUrls;
  @override
  @JsonKey(name: "img_paths_url", includeToJson: false)
  List<String> get imgPathUrls {
    if (_imgPathUrls is EqualUnmodifiableListView) return _imgPathUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imgPathUrls);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Variant(id: $id, name: $name, price: $price, quantity: $quantity, variantOptionValues: $variantOptionValues, imgPathUrls: $imgPathUrls)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Variant'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('variantOptionValues', variantOptionValues))
      ..add(DiagnosticsProperty('imgPathUrls', imgPathUrls));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            const DeepCollectionEquality()
                .equals(other._variantOptionValues, _variantOptionValues) &&
            const DeepCollectionEquality()
                .equals(other._imgPathUrls, _imgPathUrls));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      price,
      quantity,
      const DeepCollectionEquality().hash(_variantOptionValues),
      const DeepCollectionEquality().hash(_imgPathUrls));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VariantImplCopyWith<_$VariantImpl> get copyWith =>
      __$$VariantImplCopyWithImpl<_$VariantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VariantImplToJson(
      this,
    );
  }
}

abstract class _Variant implements Variant {
  factory _Variant(
      {@JsonKey(includeToJson: false) final int? id,
      required final String name,
      final double price,
      final int quantity,
      @JsonKey(name: "variant_option_values", includeToJson: false)
      final List<VariantOption>? variantOptionValues,
      @JsonKey(name: "img_paths_url", includeToJson: false)
      final List<String> imgPathUrls}) = _$VariantImpl;

  factory _Variant.fromJson(Map<String, dynamic> json) = _$VariantImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  String get name;
  @override
  double get price;
  @override
  int get quantity;
  @override
  @JsonKey(name: "variant_option_values", includeToJson: false)
  List<VariantOption>? get variantOptionValues;
  @override
  @JsonKey(name: "img_paths_url", includeToJson: false)
  List<String> get imgPathUrls;
  @override
  @JsonKey(ignore: true)
  _$$VariantImplCopyWith<_$VariantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

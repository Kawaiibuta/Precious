// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ordered_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderedProduct _$OrderedProductFromJson(Map<String, dynamic> json) {
  return _OrderedProduct.fromJson(json);
}

/// @nodoc
mixin _$OrderedProduct {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "variant_id")
  int get variantId => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Variant? get variant => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  double get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderedProductCopyWith<OrderedProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderedProductCopyWith<$Res> {
  factory $OrderedProductCopyWith(
          OrderedProduct value, $Res Function(OrderedProduct) then) =
      _$OrderedProductCopyWithImpl<$Res, OrderedProduct>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: "variant_id") int variantId,
      @JsonKey(includeFromJson: false, includeToJson: false) Variant? variant,
      int quantity,
      @JsonKey(includeToJson: false) double price});

  $VariantCopyWith<$Res>? get variant;
}

/// @nodoc
class _$OrderedProductCopyWithImpl<$Res, $Val extends OrderedProduct>
    implements $OrderedProductCopyWith<$Res> {
  _$OrderedProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? variantId = null,
    Object? variant = freezed,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      variantId: null == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int,
      variant: freezed == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as Variant?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VariantCopyWith<$Res>? get variant {
    if (_value.variant == null) {
      return null;
    }

    return $VariantCopyWith<$Res>(_value.variant!, (value) {
      return _then(_value.copyWith(variant: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderedProductImplCopyWith<$Res>
    implements $OrderedProductCopyWith<$Res> {
  factory _$$OrderedProductImplCopyWith(_$OrderedProductImpl value,
          $Res Function(_$OrderedProductImpl) then) =
      __$$OrderedProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: "variant_id") int variantId,
      @JsonKey(includeFromJson: false, includeToJson: false) Variant? variant,
      int quantity,
      @JsonKey(includeToJson: false) double price});

  @override
  $VariantCopyWith<$Res>? get variant;
}

/// @nodoc
class __$$OrderedProductImplCopyWithImpl<$Res>
    extends _$OrderedProductCopyWithImpl<$Res, _$OrderedProductImpl>
    implements _$$OrderedProductImplCopyWith<$Res> {
  __$$OrderedProductImplCopyWithImpl(
      _$OrderedProductImpl _value, $Res Function(_$OrderedProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? variantId = null,
    Object? variant = freezed,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_$OrderedProductImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      variantId: null == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int,
      variant: freezed == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as Variant?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderedProductImpl implements _OrderedProduct {
  _$OrderedProductImpl(
      {@JsonKey(includeToJson: false) this.id,
      @JsonKey(name: "variant_id") required this.variantId,
      @JsonKey(includeFromJson: false, includeToJson: false) this.variant,
      required this.quantity,
      @JsonKey(includeToJson: false) required this.price});

  factory _$OrderedProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderedProductImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: "variant_id")
  final int variantId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Variant? variant;
  @override
  final int quantity;
  @override
  @JsonKey(includeToJson: false)
  final double price;

  @override
  String toString() {
    return 'OrderedProduct(id: $id, variantId: $variantId, variant: $variant, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderedProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, variantId, variant, quantity, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderedProductImplCopyWith<_$OrderedProductImpl> get copyWith =>
      __$$OrderedProductImplCopyWithImpl<_$OrderedProductImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderedProductImplToJson(
      this,
    );
  }
}

abstract class _OrderedProduct implements OrderedProduct {
  factory _OrderedProduct(
          {@JsonKey(includeToJson: false) final int? id,
          @JsonKey(name: "variant_id") required final int variantId,
          @JsonKey(includeFromJson: false, includeToJson: false)
          final Variant? variant,
          required final int quantity,
          @JsonKey(includeToJson: false) required final double price}) =
      _$OrderedProductImpl;

  factory _OrderedProduct.fromJson(Map<String, dynamic> json) =
      _$OrderedProductImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  @JsonKey(name: "variant_id")
  int get variantId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Variant? get variant;
  @override
  int get quantity;
  @override
  @JsonKey(includeToJson: false)
  double get price;
  @override
  @JsonKey(ignore: true)
  _$$OrderedProductImplCopyWith<_$OrderedProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

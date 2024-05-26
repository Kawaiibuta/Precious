// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "category_id")
  int get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: "short_description")
  String get shortDescription => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: "img_paths_url", includeToJson: false)
  List<String> get imgPathUrls => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  List<Variant> get variants => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  List<Option> get options => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  double get price => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  int get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      String name,
      @JsonKey(name: "category_id") int categoryId,
      @JsonKey(name: "short_description") String shortDescription,
      String description,
      @JsonKey(name: "img_paths_url", includeToJson: false)
      List<String> imgPathUrls,
      @JsonKey(includeToJson: false) List<Variant> variants,
      double rating,
      @JsonKey(includeToJson: false) List<Option> options,
      @JsonKey(includeToJson: false) double price,
      @JsonKey(includeToJson: false) int quantity});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? categoryId = null,
    Object? shortDescription = null,
    Object? description = null,
    Object? imgPathUrls = null,
    Object? variants = null,
    Object? rating = null,
    Object? options = null,
    Object? price = null,
    Object? quantity = null,
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
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imgPathUrls: null == imgPathUrls
          ? _value.imgPathUrls
          : imgPathUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      variants: null == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<Variant>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      String name,
      @JsonKey(name: "category_id") int categoryId,
      @JsonKey(name: "short_description") String shortDescription,
      String description,
      @JsonKey(name: "img_paths_url", includeToJson: false)
      List<String> imgPathUrls,
      @JsonKey(includeToJson: false) List<Variant> variants,
      double rating,
      @JsonKey(includeToJson: false) List<Option> options,
      @JsonKey(includeToJson: false) double price,
      @JsonKey(includeToJson: false) int quantity});
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? categoryId = null,
    Object? shortDescription = null,
    Object? description = null,
    Object? imgPathUrls = null,
    Object? variants = null,
    Object? rating = null,
    Object? options = null,
    Object? price = null,
    Object? quantity = null,
  }) {
    return _then(_$ProductImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imgPathUrls: null == imgPathUrls
          ? _value.imgPathUrls
          : imgPathUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      variants: null == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<Variant>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl with DiagnosticableTreeMixin implements _Product {
  _$ProductImpl(
      {@JsonKey(includeToJson: false) this.id,
      this.name = "",
      @JsonKey(name: "category_id") this.categoryId = -1,
      @JsonKey(name: "short_description") this.shortDescription = "",
      this.description = "",
      @JsonKey(name: "img_paths_url", includeToJson: false)
      this.imgPathUrls = const <String>[],
      @JsonKey(includeToJson: false) this.variants = const [],
      this.rating = 0.0,
      @JsonKey(includeToJson: false) this.options = const [],
      @JsonKey(includeToJson: false) this.price = 0.0,
      @JsonKey(includeToJson: false) this.quantity = 0});

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey(name: "category_id")
  final int categoryId;
  @override
  @JsonKey(name: "short_description")
  final String shortDescription;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: "img_paths_url", includeToJson: false)
  final List<String> imgPathUrls;
  @override
  @JsonKey(includeToJson: false)
  final List<Variant> variants;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey(includeToJson: false)
  final List<Option> options;
  @override
  @JsonKey(includeToJson: false)
  final double price;
  @override
  @JsonKey(includeToJson: false)
  final int quantity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Product(id: $id, name: $name, categoryId: $categoryId, shortDescription: $shortDescription, description: $description, imgPathUrls: $imgPathUrls, variants: $variants, rating: $rating, options: $options, price: $price, quantity: $quantity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Product'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('categoryId', categoryId))
      ..add(DiagnosticsProperty('shortDescription', shortDescription))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('imgPathUrls', imgPathUrls))
      ..add(DiagnosticsProperty('variants', variants))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('quantity', quantity));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other.imgPathUrls, imgPathUrls) &&
            const DeepCollectionEquality().equals(other.variants, variants) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality().equals(other.options, options) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      categoryId,
      shortDescription,
      description,
      const DeepCollectionEquality().hash(imgPathUrls),
      const DeepCollectionEquality().hash(variants),
      rating,
      const DeepCollectionEquality().hash(options),
      price,
      quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  factory _Product(
      {@JsonKey(includeToJson: false) final int? id,
      final String name,
      @JsonKey(name: "category_id") final int categoryId,
      @JsonKey(name: "short_description") final String shortDescription,
      final String description,
      @JsonKey(name: "img_paths_url", includeToJson: false)
      final List<String> imgPathUrls,
      @JsonKey(includeToJson: false) final List<Variant> variants,
      final double rating,
      @JsonKey(includeToJson: false) final List<Option> options,
      @JsonKey(includeToJson: false) final double price,
      @JsonKey(includeToJson: false) final int quantity}) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  String get name;
  @override
  @JsonKey(name: "category_id")
  int get categoryId;
  @override
  @JsonKey(name: "short_description")
  String get shortDescription;
  @override
  String get description;
  @override
  @JsonKey(name: "img_paths_url", includeToJson: false)
  List<String> get imgPathUrls;
  @override
  @JsonKey(includeToJson: false)
  List<Variant> get variants;
  @override
  double get rating;
  @override
  @JsonKey(includeToJson: false)
  List<Option> get options;
  @override
  @JsonKey(includeToJson: false)
  double get price;
  @override
  @JsonKey(includeToJson: false)
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/data_sources/variant/variant.dart';

part 'product.g.dart';
part 'product.freezed.dart';

@Freezed()
class Product with _$Product {
  factory Product({
    @Default(null) int? id,
    @Default("") String name,
    @Default(-1) int category_id,
    @Default("") String short_description,
    @Default("") String description,
    @Default(<String>[]) List<String> img_paths_url,
    @Default(null) List<Variant>? variants,
    @Default(0.0) double rating,
    @Default(0.0) double price,
  }) = _Product;
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

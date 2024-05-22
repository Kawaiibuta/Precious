// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/models/option/option.dart';
import 'package:precious/models/variant/variant.dart';

part 'product.g.dart';
part 'product.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Product with _$Product {
  factory Product({
    @JsonKey(includeToJson: false) int? id,
    @Default("") String name,
    @JsonKey(name: "category_id") @Default(-1) int categoryId,
    @JsonKey(name: "short_description") @Default("") String shortDescription,
    @Default("") String description,
    @JsonKey(name: "img_paths_url", includeToJson: false)
    @Default(<String>[])
    List<String> imgPathUrls,
    @JsonKey(includeToJson: false) @Default([]) List<Variant> variants,
    @Default(0.0) double rating,
    @JsonKey(includeToJson: false) @Default([]) List<Option> options,
    @JsonKey(includeToJson: false) @Default(0.0) double price,
    @JsonKey(includeToJson: false) @Default(0) int quantity,
  }) = _Product;
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/models/variant/variant_option/variant_option.dart';

part 'variant.g.dart';
part 'variant.freezed.dart';

@Freezed()
class Variant with _$Variant {
  factory Variant(
      {@JsonKey(includeToJson: false) @Default(null) int? id,
      required String name,
      @Default(0.0) double price,
      @Default(0) int quantity,
      @JsonKey(name: "product_id") required int productId,
      @JsonKey(name: "variant_option_values", includeToJson: false)
      List<VariantOption>? variantOptionValues,
      @JsonKey(name: "img_paths_url", includeToJson: false)
      @Default(<String>[])
      List<String> imgPathUrls}) = _Variant;
  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);
}

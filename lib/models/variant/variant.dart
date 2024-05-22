import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/variant/variant_option_value/variant_option_value.dart';

part 'variant.g.dart';
part 'variant.freezed.dart';

@Freezed()
class Variant with _$Variant {
  factory Variant(
      {@Default(null) int? id,
      @Default(0.0) double price,
      @Default(<String>[]) List<String> img_paths_url,
      @JsonKey(name: 'variant_option_values')
      @Default(<VariantOptionValue>[])
      List<VariantOptionValue> variantOptionValues,
      required Product product}) = _Variant;
  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);
}

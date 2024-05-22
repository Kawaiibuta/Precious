// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/models/variant/variant.dart';

part 'ordered_product.g.dart';
part 'ordered_product.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class OrderedProduct with _$OrderedProduct {
  factory OrderedProduct({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: "variant_id") required int variantId,
    @JsonKey(includeFromJson: false, includeToJson: false) Variant? variant,
    required int quantity,
    @JsonKey(includeToJson: false) required double price,
  }) = _OrderedProduct;
  factory OrderedProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderedProductFromJson(json);
}

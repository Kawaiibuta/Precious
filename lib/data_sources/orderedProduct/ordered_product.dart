import 'package:freezed_annotation/freezed_annotation.dart';

part 'ordered_product.g.dart';
part 'ordered_product.freezed.dart';

@Freezed()
class OrderedProduct with _$OrderedProduct {
  factory OrderedProduct({
    required int id,
    @JsonKey(name: "variant_id") required int variantId,
    required int quantity,
    required double price,
  }) = _OrderedProduct;
  factory OrderedProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderedProductFromJson(json);
}

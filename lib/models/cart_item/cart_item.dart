import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/data_sources/variant/variant.dart';
import 'package:flutter/foundation.dart';

part 'cart_item.freezed.dart';

part 'cart_item.g.dart';

@Freezed()
class CartItem with _$CartItem {
  const factory CartItem({
    required int id,
    String? cart,
    required Variant variant,
    @Default(0) int quantity,
    required double price,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

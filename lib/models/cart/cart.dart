import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/models/cart_item/cart_item.dart';
import 'package:flutter/foundation.dart';

part 'cart.freezed.dart';

part 'cart.g.dart';

@Freezed()
class Cart with _$Cart {
  const factory Cart(
      {required int id,
      String? user,
      @Default([]) List<CartItem> items,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt}) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}

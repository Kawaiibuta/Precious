import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/data_sources/orderedProduct/ordered_product.dart';
import 'package:precious/data_sources/user/user.dart';

part 'order.g.dart';
part 'order.freezed.dart';

DateTime _sendDateTimeFromJson(String string) {
  return DateTime.parse(string);
}

@Freezed()
class Order with _$Order {
  const factory Order(
      {@Default(null) int? id,
      @JsonKey(name: "user_id") @Default(null) int? userId,
      @Default(null) User? user,
      required String status,
      @JsonKey(name: "created_at", fromJson: _sendDateTimeFromJson)
      @Default(null)
      DateTime? createAt,
      @JsonKey(name: "total_price") required double totalPrice,
      @Default([]) List<OrderedProduct> items}) = _Order;
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

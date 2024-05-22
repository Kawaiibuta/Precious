// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/models/orderedProduct/ordered_product.dart';
import 'package:precious/models/user/user.dart';

part 'order.g.dart';
part 'order.freezed.dart';

DateTime _sendDateTimeFromJson(String string) {
  return DateTime.parse(string);
}

@Freezed(makeCollectionsUnmodifiable: false)
class Order with _$Order {
  const factory Order(
      {@JsonKey(includeToJson: false) @Default(null) int? id,
      @JsonKey(name: "user_id") required int userId,
      @JsonKey(name: "is_paid", includeToJson: false) required bool isPaid,
      @JsonKey(includeToJson: false) User? user,
      @JsonKey(includeToJson: false) required String status,
      @JsonKey(
          name: "created_at",
          fromJson: _sendDateTimeFromJson,
          includeToJson: false)
      required DateTime? createAt,
      @JsonKey(name: "total_price", includeToJson: false)
      required double totalPrice,
      required String address,
      @JsonKey(name: "phone_number") String? phoneNumber,
      @Default([]) List<OrderedProduct> items}) = _Order;
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

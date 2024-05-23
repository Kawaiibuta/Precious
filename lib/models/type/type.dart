import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/models/product/product.dart';

part 'type.g.dart';
part 'type.freezed.dart';

@Freezed()
class Type with _$Type {
  factory Type(
      {@Default(null) int? id,
      @Default("") String name,
      @JsonKey(includeFromJson: false, includeToJson: false)
      @Default([])
      List<Product> products}) = _Type;
  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
}

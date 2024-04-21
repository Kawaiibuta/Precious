import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'variant.g.dart';
part 'variant.freezed.dart';

@Freezed()
class Variant with _$Variant {
  factory Variant(
      {@Default(null) int? id,
      @Default(0.0) double price,
      @Default(<String>[]) List<String> img_paths_url}) = _Variant;
  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);
}

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/models/variant/variant_option_value/option_value/option_value.dart';

part 'option.g.dart';
part 'option.freezed.dart';

@Freezed()
class Option with _$Option {
  factory Option(
      {@Default(null) int? id,
      @JsonKey(name: 'product_id') int? productId,
      String? name,
      @Default(<OptionValue>[]) List<OptionValue> values,
      }) = _Option;
  factory Option.fromJson(Map<String, dynamic> json) =>
      _$OptionFromJson(json);
}
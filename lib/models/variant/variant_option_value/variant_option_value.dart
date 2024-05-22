import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/variant/variant_option_value/option/option.dart';
import 'package:precious/models/variant/variant_option_value/option_value/option_value.dart';

part 'variant_option_value.g.dart';
part 'variant_option_value.freezed.dart';

@Freezed()
class VariantOptionValue with _$VariantOptionValue {
  factory VariantOptionValue(
      {@Default(null) int? id,
      required Option option,
      @JsonKey(name: 'option_value') required OptionValue optionValue}) = _VariantOptionValue;
  factory VariantOptionValue.fromJson(Map<String, dynamic> json) =>
      _$VariantOptionValueFromJson(json);
}
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/data_sources/option/optionValue/option_value.dart';

part 'variant_option.g.dart';
part 'variant_option.freezed.dart';

@Freezed()
class VariantOption with _$VariantOption {
  factory VariantOption(
      {@JsonKey(includeToJson: false) @Default(null) int? id,
      @JsonKey(name: "option_id", includeToJson: false) required int optionId,
      @JsonKey(name: "option_value", includeToJson: false)
      required OptionValue optionValue}) = _VariantOption;
  factory VariantOption.fromJson(Map<String, dynamic> json) =>
      _$VariantOptionFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:precious/data_sources/option/optionValue/option_value.dart';

part 'option.g.dart';
part 'option.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Option with _$Option {
  factory Option({
    @JsonKey(includeToJson: false) @Default(null) int? id,
    required String name,
    @JsonKey(name: "product_id") int? productId,
    @Default([]) List<OptionValue> values,
  }) = _Option;
  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}

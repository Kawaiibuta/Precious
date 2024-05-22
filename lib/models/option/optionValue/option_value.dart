import 'package:freezed_annotation/freezed_annotation.dart';

part 'option_value.g.dart';
part 'option_value.freezed.dart';

@Freezed()
class OptionValue with _$OptionValue {
  factory OptionValue({
    @JsonKey(includeToJson: false) int? id,
    required String value,
  }) = _OptionValue;

  factory OptionValue.fromJson(Map<String, dynamic> json) =>
      _$OptionValueFromJson(json);
}

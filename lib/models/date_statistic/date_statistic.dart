import 'package:freezed_annotation/freezed_annotation.dart';

part "date_statistic.freezed.dart";
part "date_statistic.g.dart";

DateTime dateTimeFromJson(String value) {
  return DateTime.tryParse(value) ?? DateTime.now();
}

@Freezed()
class DateStatistic with _$DateStatistic {
  factory DateStatistic({
    @JsonKey(name: 'date', fromJson: dateTimeFromJson) required DateTime date,
    @JsonKey(name: "orders") @Default(0.0) double orders,
    @JsonKey(name: "new_users") @Default(0.0) double newUsers,
  }) = _DateStatistic;

  factory DateStatistic.fromJson(Map<String, dynamic> json) =>
      _$DateStatisticFromJson(json);
}

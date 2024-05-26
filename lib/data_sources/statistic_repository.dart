import 'package:precious/models/date_statistic/date_statistic.dart';

final data = [
  {
    "date": DateTime(2024, 8, 10),
    "orders": 19.0,
  },
  {
    "date": DateTime(2024, 8, 11),
    "orders": 19.0,
  },
  {
    "date": DateTime(2024, 8, 12),
    "orders": 19.0,
  },
  {
    "date": DateTime(2024, 8, 13),
    "orders": 19.0,
  },
  {
    "date": DateTime(2024, 8, 14),
    "orders": 19.0,
  },
  {
    "date": DateTime(2024, 8, 15),
    "orders": 19.0,
  },
];

class StatisticRepository {
  static Map<DateTime, DateStatistic> list = {};

  static Future<List<DateStatistic>> getFromTo(
      DateTime from, DateTime to) async {
    //For development of UI only
    //Will change to APU handling when have API
    final result = data.map((e) => DateStatistic(
        date: e["date"] as DateTime, orders: e["orders"] as double));
    return result.toList();
  }
}

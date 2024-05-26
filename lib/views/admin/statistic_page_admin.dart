import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:precious/models/date_statistic/date_statistic.dart';
import 'package:precious/presenters/admiin_statistic_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/statistic_pie_chart.dart';

class StatisticPageAdmin extends StatefulWidget {
  const StatisticPageAdmin({Key? key}) : super(key: key);

  @override
  _StatisticPageAdminState createState() => _StatisticPageAdminState();
}

final titles = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class _StatisticPageAdminState extends State<StatisticPageAdmin>
    implements AdminStatisticContract {
  AdminStatisticPresenter? _presenter;
  DateTime? startTime = DateTime.now();
  DateTime? endTime = DateTime.now();

  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  int touchedGroupIndex = -1;

  bool error = false;
  @override
  void initState() {
    super.initState();
    _presenter = Get.put(AdminStatisticPresenter(contract: this));
    _presenter!.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        firstDate: DateTime.now()
                            .copyWith(year: DateTime.now().year - 1),
                        lastDate: DateTime.now())
                    .then((value) => setState(() {
                          startTime = value;
                        }));
              },
              child: Text(
                  DateFormat.yMMMMd().format(startTime ?? DateTime.now()))),
          TextButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        firstDate: DateTime.now()
                            .copyWith(year: DateTime.now().year - 1),
                        lastDate: DateTime.now())
                    .then((value) => setState(() {
                          startTime = value;
                        }));
              },
              child:
                  Text(DateFormat.yMMMMd().format(endTime ?? DateTime.now()))),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Order value",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600, fontSize: 20.h),
              )
            ],
          ),
        ),
        if (showingBarGroups.isNotEmpty)
          SizedBox(
            height: 200.h,
            child: BarChart(BarChartData(
              maxY: 20,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: ((group) {
                    return Colors.grey;
                  }),
                  getTooltipItem: (a, b, c, d) => null,
                ),
                touchCallback: (FlTouchEvent event, response) {
                  if (response == null || response.spot == null) {
                    setState(() {
                      touchedGroupIndex = -1;
                      showingBarGroups = List.of(rawBarGroups);
                    });
                    return;
                  }

                  touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                  setState(() {
                    if (!event.isInterestedForInteractions) {
                      touchedGroupIndex = -1;
                      showingBarGroups = List.of(rawBarGroups);
                      return;
                    }
                    showingBarGroups = List.of(rawBarGroups);
                    if (touchedGroupIndex != -1) {
                      var sum = 0.0;
                      for (final rod
                          in showingBarGroups[touchedGroupIndex].barRods) {
                        sum += rod.toY;
                      }
                      final avg = sum /
                          showingBarGroups[touchedGroupIndex].barRods.length;

                      showingBarGroups[touchedGroupIndex] =
                          showingBarGroups[touchedGroupIndex].copyWith(
                        barRods: showingBarGroups[touchedGroupIndex]
                            .barRods
                            .map((rod) {
                          return rod.copyWith(
                              toY: avg, color: Colors.orange.shade200);
                        }).toList(),
                      );
                    }
                  });
                },
              ),
              titlesData: const FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitles,
                    reservedSize: 42,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    interval: 1,
                    getTitlesWidget: leftTitles,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: showingBarGroups,
              gridData: const FlGridData(show: false),
            )),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "New user:",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600, fontSize: 20.h),
              )
            ],
          ),
        ),
        if (showingBarGroups.isNotEmpty)
          SizedBox(
            height: 200.h,
            child: BarChart(BarChartData(
              maxY: 20,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: ((group) {
                    return Colors.grey;
                  }),
                  getTooltipItem: (a, b, c, d) => null,
                ),
                touchCallback: (FlTouchEvent event, response) {
                  if (response == null || response.spot == null) {
                    setState(() {
                      touchedGroupIndex = -1;
                      showingBarGroups = List.of(rawBarGroups);
                    });
                    return;
                  }

                  touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                  setState(() {
                    if (!event.isInterestedForInteractions) {
                      touchedGroupIndex = -1;
                      showingBarGroups = List.of(rawBarGroups);
                      return;
                    }
                    showingBarGroups = List.of(rawBarGroups);
                    if (touchedGroupIndex != -1) {
                      var sum = 0.0;
                      for (final rod
                          in showingBarGroups[touchedGroupIndex].barRods) {
                        sum += rod.toY;
                      }
                      final avg = sum /
                          showingBarGroups[touchedGroupIndex].barRods.length;

                      showingBarGroups[touchedGroupIndex] =
                          showingBarGroups[touchedGroupIndex].copyWith(
                        barRods: showingBarGroups[touchedGroupIndex]
                            .barRods
                            .map((rod) {
                          return rod.copyWith(
                              toY: avg, color: Colors.orange.shade200);
                        }).toList(),
                      );
                    }
                  });
                },
              ),
              titlesData: const FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitles,
                    reservedSize: 42,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    interval: 1,
                    getTitlesWidget: leftTitles,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: showingBarGroups,
              gridData: const FlGridData(show: false),
            )),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Product by category:",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600, fontSize: 20.h),
              )
            ],
          ),
        ),
        StatisticPieChart()
      ]))),
    );
  }

  @override
  onEndAsyncFunction() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  onInitFail() {
    setState(() {
      error = true;
    });
  }

  @override
  onInitSuccess(List<DateStatistic> value) {
    final items = value
        .map((e) => makeGroupData(
            titles.indexOf(DateFormat.E().format(e.date)), e.orders))
        .toList();
    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  onRefreshFail() {}

  @override
  onRefreshSuccess(List<DateStatistic> value) {}

  @override
  onStartAsyncFunction() {
    // Get.dialog(const Center(child: CircularProgressIndicator()));
  }
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff7589a2),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  if (value == 0) {
    text = '1K';
  } else if (value == 10) {
    text = '5K';
  } else if (value == 19) {
    text = '10K';
  } else {
    return Container();
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: style),
  );
}

BarChartGroupData makeGroupData(int x, double y1) {
  return BarChartGroupData(
    barsSpace: 4,
    x: x,
    barRods: [
      BarChartRodData(
        toY: y1,
        color: Colors.black,
        width: 10.h,
      ),
    ],
  );
}

Widget bottomTitles(double value, TitleMeta meta) {
  final Widget text = Text(
    titles[value.toInt()],
    style: const TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16, //margin top
    child: text,
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:precious/data_sources/order/order.dart';
import 'package:precious/main.dart';
import 'package:precious/presenters/admin_order_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';
import 'package:precious/resources/widgets/order_card_admin.dart';

class OrderPageAdmin extends StatefulWidget {
  const OrderPageAdmin({Key? key}) : super(key: key);

  @override
  _OrderPageAdminState createState() => _OrderPageAdminState();
}

class _OrderPageAdminState extends State<OrderPageAdmin>
    implements AdminOrderContract {
  late AdminOrderPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = AdminOrderPresenter(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _presenter.init());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _presenter.refresh();
      },
      child: DefaultTabController(
        length: 3,
        child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(children: [
                CustomSearchBar(
                  onChange: (p0) {
                    setState(() {
                      _presenter.searchString = p0;
                    });
                  },
                ),
                SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 4,
                    indicatorColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    onTap: (i) => setState(() {
                      _presenter.selectedTab = i;
                    }),
                    tabs: const [
                      Tab(icon: Text('Day')),
                      Tab(icon: Text('Month')),
                      Tab(icon: Text('Year')),
                    ],
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      _presenter.option = !_presenter.option;
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: Row(
                        children: [
                          const Text("Options"),
                          AnimatedRotation(
                            turns: _presenter.option ? 0 : 1 / 4,
                            duration: Durations.long2,
                            child: const Icon(Icons.arrow_drop_down_rounded),
                          )
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    height: _presenter.option ? 50.h : 0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    duration: Durations.long2,
                    child: CheckboxListTile(
                      title: const Text("Pending only"),
                      value: _presenter.checkedValue,
                      onChanged: (newValue) {
                        setState(() {
                          _presenter.checkedValue = !_presenter.checkedValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: buildOrderList())
                ]))
              ]),
            )),
      ),
    );
  }

  Widget buildOrderList() {
    final seperatorList = buildSeperatorList();
    final list = filterStatus(_presenter.checkedValue ? "PENDING" : null);
    var seperatorNumber = 0;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (seperatorList.containsKey(index - 1)) {
            seperatorNumber += 1;
            return Container(
                color: Colors.black,
                height: 50.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 5.h),
                child: Center(
                  child: Text(
                    seperatorList[index - 1]!,
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 20.h,
                        fontWeight: FontWeight.bold),
                  ),
                ));
          }
          index -= seperatorNumber;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: OrderCardAdmin(order: list[index]),
          );
        },
        itemCount: list.length + seperatorList.length);
  }

  List<Order> filterStatus(String? status) {
    if (status == null) return _presenter.orderList;
    return _presenter.orderList
        .where((element) => element.status == status)
        .toList();
  }

  Map<int, String> buildSeperatorList() {
    var result = <int, String>{};
    switch (_presenter.selectedTab) {
      case 0:
        result.addEntries(<int, String>{-1: "Today"}.entries);
        var current = DateTime.now().copyWith(
          hour: 24,
          minute: 60,
          second: 60,
        );
        for (var order in _presenter.orderList) {
          if (current.difference(order.createAt!) > const Duration(days: 1)) {
            result.addEntries(<int, String>{
              _presenter.orderList.indexOf(order) - 1:
                  DateFormat('dd/MM/yyyy').format(order.createAt!)
            }.entries);

            current = order.createAt!.copyWith(
              hour: 24,
              minute: 60,
              second: 60,
            );
          }
        }
        break;
      case 1:
        result.addEntries(<int, String>{
          -1: DateFormat("MM/yyyy").format(DateTime.now())
        }.entries);
        var current =
            DateTime.now().copyWith(month: DateTime.now().month + 1, day: 0);
        var duration =
            Duration(days: DateTime(current.year, current.month + 1, 0).day);
        for (var order in _presenter.orderList) {
          if (current.difference(order.createAt!) > duration) {
            result.addEntries(<int, String>{
              _presenter.orderList.indexOf(order) - 1:
                  DateFormat('dd/MM/yyyy').format(order.createAt!)
            }.entries);
            current = order.createAt!
                .copyWith(month: DateTime.now().month + 1, day: 0);
            duration = Duration(
                days: DateTime(current.year, current.month + 1, 0).day);
          }
        }
        break;
      case 2:
        result.addEntries(<int, String>{
          -1: DateFormat("yyyy").format(DateTime.now())
        }.entries);
        var current =
            DateTime.now().copyWith(year: DateTime.now().year + 1, day: 0);
        for (var order in _presenter.orderList) {
          if (current.difference(order.createAt!) > const Duration(days: 365)) {
            result.addEntries(<int, String>{
              _presenter.orderList.indexOf(order) - 1:
                  DateFormat('yyyy').format(order.createAt!)
            }.entries);
            current =
                order.createAt!.copyWith(year: DateTime.now().year + 1, day: 0);
          }
        }
        break;
      default:
    }
    return result;
  }

  @override
  void onDeleteFail() {
    // TODO: implement onDeleteFail
  }

  @override
  void onDeleteSuccess() {
    // TODO: implement onDeleteSuccess
  }

  @override
  void onEndAsyncTask() {
    Get.back();
  }

  @override
  void onInitSuccess() {
    setState(() {});
  }

  @override
  void onRefreshSuccess() {
    setState(() {});
  }

  @override
  void onStartAsyncTask() {
    showDialog(
        context: NavigationService.navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        });
  }
}

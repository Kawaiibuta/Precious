import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/presenters/base_presenter.dart';
import 'package:precious/presenters/order_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/views/admin/inventory_form.dart';
import 'package:precious/views/admin/order_form.dart';
import 'package:precious/views/admin/order_page_admin.dart';
import 'package:precious/views/admin/product_page_admin.dart';
import 'package:precious/views/admin/user_page_admin.dart';
import 'package:sidebarx/sidebarx.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});
  static const name = "home_page_admin";
  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

final divider = Divider(color: Colors.white.withOpacity(0.3), height: 1);
final _controller = SidebarXController(selectedIndex: 0, extended: true);

final floatingButtonList = [
  {"icon": Icons.add, "name": "add"},
  {"icon": Icons.delete, "name": "delete"},
  {"icon": Icons.edit, "name": "edit"}
];

final drawerItemList = [
  {"icon": Icons.inventory, "name": "Inventory"},
  {
    "icon": Icons.person,
    "name": "User",
  },
  {
    "icon": Icons.receipt,
    "name": "Order",
  },
  {"icon": Icons.monitor, "name": "Statistic"}
];

class _HomePageAdminState extends State<HomePageAdmin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = SidebarXController(selectedIndex: 0, extended: true);
  late Presenter _presenter;
  StreamController floatingButtonStreamController =
      StreamController<List<int>>();
  Stream get floatingButtonStream => floatingButtonStreamController.stream;
  @override
  void initState() {
    super.initState();
    _presenter = getPresenter();
  }

  @override
  void dispose() {
    floatingButtonStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: getRoute(),
        drawer: SidebarX(
          controller: _controller,
          theme: SidebarXTheme(
            margin: const EdgeInsets.all(10),
            textStyle: const TextStyle(color: Colors.white),
            selectedTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            itemTextPadding: const EdgeInsets.only(left: 30),
            selectedItemTextPadding: const EdgeInsets.only(left: 30),
            selectedItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white24,
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: 20,
            ),
          ),
          extendedTheme: SidebarXTheme(
            width: MediaQuery.of(context).size.width / 1.6,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            margin: const EdgeInsets.only(right: 10),
          ),
          footerDivider: divider,
          headerBuilder: (context, extended) {
            return SafeArea(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: CachedNetworkImage(
                            imageUrl:
                                "https://cdn2.thecatapi.com/images/_6x-3TiCA.jpg"),
                      ),
                      const Text(
                        "Hello, \nPhap",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          items: drawerItemList
              .map((e) => SidebarXItem(
                  icon: e["icon"] as IconData,
                  label: e['name'] as String,
                  onTap: () => setState(() {
                        _presenter.selected.clear();
                        controller.selectIndex(drawerItemList.indexOf(e));
                      })))
              .toList(),
        ),
        floatingActionButton: StreamBuilder<List<int>>(
            stream: floatingButtonStreamController.stream as Stream<List<int>>,
            builder: (context, snapshot) {
              var openList = (snapshot.data ?? []).toList();
              return Stack(
                children: [
                  ...floatingButtonList.reversed
                      .toList()
                      .asMap()
                      .map((key, value) => MapEntry(
                          key,
                          AnimatedPositioned(
                              duration: const Duration(milliseconds: 900),
                              curve: Curves.easeOut,
                              bottom: openList.isNotEmpty &&
                                      key != 0 &&
                                      openList.contains(key)
                                  ? key * 65
                                  : 0,
                              right: 10.0,
                              child: Container(
                                width: 60,
                                height: 60,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.black,
                                  onPressed: () {
                                    switch (value['name']) {
                                      case "add":
                                        Navigator.of(context).pushNamed(
                                            "${(drawerItemList[controller.selectedIndex]['name'] as String).toLowerCase()}_form");
                                        break;
                                      case "delete":
                                        _handleDeleteItem();
                                      case "edit":
                                        _handleUpdateItem();
                                      default:
                                    }
                                  },
                                  child: Icon(
                                    value["icon"] as IconData,
                                    color: Colors.white,
                                  ),
                                ),
                              ))))
                      .values
                ],
              );
            }));
  }

  void _handleDeleteItem() async {
    debugPrint(_presenter.selected.toString());
    final futureItemList = _presenter.selected.map((e) => _presenter.getOne(e));
    final itemList = await Future.wait(futureItemList);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Delete items"),
                  Text("Do you want to delete ${itemList.length} items?"),
                  DataTable(
                      columns: const [
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Id',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'name',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                      rows: itemList
                          .map((e) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(e!.id!.toString())),
                                  DataCell(Text(e.name)),
                                ],
                              ))
                          .toList()),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.openSans(color: Colors.black),
                            )),
                        OutlinedButton(
                            onPressed: () async {
                              final futureResult = _presenter.selected
                                  .map((e) => _presenter.delete(e))
                                  .toList();
                              final result = await Future.wait(futureResult);
                              Fluttertoast.showToast(
                                  msg:
                                      "${result.where((element) => element == true).length} have been removed successfully");

                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            child: Text("OK",
                                style:
                                    GoogleFonts.openSans(color: Colors.white))),
                      ])
                ],
              ),
            )).then((value) => Navigator.of(context).setState(() {}));
  }

  Widget getRoute() => switch (controller.selectedIndex) {
        0 => ProductPageAdmin(
            presenter: _presenter as ProductPresenter,
            openFloatingButton: (List<int> e) =>
                floatingButtonStreamController.sink.add(e),
          ),
        1 => const UserPageAdmin(),
        2 => const OrderPageAdmin(),
        _ => const OrderPageAdmin()
      };

  Presenter getPresenter() => switch (controller.selectedIndex) {
        0 => ProductPresenter(),
        1 => ProductPresenter(),
        2 => OrderPresenter(),
        _ => ProductPresenter(),
      };

  void _handleUpdateItem() async {
    debugPrint(_presenter.selected.toString());
    if (_presenter.selected.isEmpty) {
      return;
    }
    final item = await _presenter.getOne(_presenter.selected[0]);
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => InventoryForm(
                  product: item as Product,
                )))
        .then((value) => setState(() {}));
  }

  Widget getAddForm() => switch (controller.selectedIndex) {
        0 => const InventoryForm(),
        1 => const OrderForm(),
        2 => const OrderPageAdmin(),
        _ => const SizedBox.shrink()
      };
}

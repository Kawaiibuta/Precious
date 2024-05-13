import 'package:flutter/material.dart';
import 'package:precious/data_sources/order/order.dart';
import 'package:precious/presenters/order_presenter.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';

class OrderPageAdmin extends StatefulWidget {
  const OrderPageAdmin({Key? key}) : super(key: key);

  @override
  _OrderPageAdminState createState() => _OrderPageAdminState();
}

class _OrderPageAdminState extends State<OrderPageAdmin> {
  String? searchString;
  OrderPresenter _orderPresenter = OrderPresenter();
  late Future<List<Order>> futureOrderList;
  @override
  void initState() {
    futureOrderList = _orderPresenter.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
          child: Column(children: [
            CustomSearchBar(
              onChange: (p0) {
                setState(() {
                  searchString = p0;
                });
              },
            ),
            FutureBuilder(
                future: futureOrderList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) debugPrint(snapshot.data.toString());
                  return SizedBox.shrink();
                })
          ])),
    );
  }
}

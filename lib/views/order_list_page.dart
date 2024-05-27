import 'package:flutter/material.dart';
import 'package:precious/data_sources/auth_repository.dart';
import 'package:precious/models/order/order.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/round_container_box.dart';

class OrderListPage extends StatefulWidget {
  static const name = '/myOrders';

  final List<Order> orders = AuthRepository.currentUser!.orders;

  OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<OrderListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: Container(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.my_order_button_title,
                  style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 40.v),
              for (var order in widget.orders)
                RoundContainerBox(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant),
                  padding: EdgeInsets.symmetric(vertical: 16.v),
                  child: Column(
                    children: [
                      Text(order.id.toString(),
                          style: Theme.of(context).textTheme.titleMedium),
                      Row(
                        children: [
                          Text(AppLocalizations.of(context)!.status_order_title,
                              style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(width: 8.h),
                          Text(order.status,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: order.status == 'COMPLETED'
                                          ? Colors.green
                                          : Colors.red)),
                        ],
                      )
                    ],
                  ),
                ),
              if (widget.orders.isEmpty) ...[
                SizedBox(height: 250.v),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.empty_order_available_body,
                  ),
                )]
            ],
          ),
        ),
      ),
    );
  }
}

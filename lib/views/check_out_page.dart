import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/models/cart/cart.dart';
import 'package:precious/resources/widgets/custom_elevated_button.dart';
import 'package:precious/resources/widgets/product_card_large.dart';
import 'package:precious/resources/widgets/round_container_box.dart';

class CheckOutPage extends StatefulWidget {
  final Cart cart;
  const CheckOutPage(this.cart, {super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  bool _isAddressEdit = false;

  final _detailAddressController =
      TextEditingController(text: 'Khu phố 3, phường Đông Hòa, TP. Thủ Đức');

  final _provinceAddressController =
      TextEditingController(text: 'TP. Hồ Chí Minh');

  final _countryAddressController = TextEditingController(text: 'Việt Nam');

  final _detailAddressFocusNode = FocusNode();

  final _provinceFocusNode = FocusNode();

  final _countryFocusNode = FocusNode();

  final _numberFormat = NumberFormat.compactSimpleCurrency(locale: 'vi');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            body: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Text(
                          AppLocalizations.of(context)!
                              .checkout_product_list_title,
                          style: Theme.of(context).textTheme.titleLarge),
                      for (var item in widget.cart.items)
                        ProductCardLarge(item.variant.product),

                      // DELIVERY ADDRESS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .delivery_address_title,
                              style: Theme.of(context).textTheme.titleLarge),
                          IconButton(
                              onPressed: () => setState(() {
                                    _isAddressEdit = true;
                                  }),
                              icon: Icon(
                                  _isAddressEdit ? Icons.check : Icons.edit,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground)),
                        ],
                      ),
                      RoundContainerBox(
                          hasShadow: true,
                          shadowWidth: 1.h,
                          child: Column(children: [
                            if (!_isAddressEdit)
                              Row(children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .address_detail_title,
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                Text(_detailAddressController.text,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ])
                            else ...[
                              Text(
                                  AppLocalizations.of(context)!
                                      .address_detail_title,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              TextFormField(
                                controller: _detailAddressController,
                                focusNode: _detailAddressFocusNode,
                                onTap: _detailAddressFocusNode.requestFocus,
                              )
                            ],
                            if (!_isAddressEdit)
                              Row(children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .province_or_city_title,
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                Text(_provinceAddressController.text,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ])
                            else ...[
                              Text(
                                  AppLocalizations.of(context)!
                                      .province_or_city_title,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              TextFormField(
                                  controller: _provinceAddressController,
                                  focusNode: _provinceFocusNode,
                                  onTap: _provinceFocusNode.requestFocus)
                            ],
                            if (!_isAddressEdit)
                              Row(children: [
                                Text(
                                    AppLocalizations.of(context)!.country_title,
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                Text(_countryAddressController.text,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ])
                            else ...[
                              Text(AppLocalizations.of(context)!.country_title,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              TextFormField(
                                controller: _countryAddressController,
                                focusNode: _countryFocusNode,
                                onTap: _countryFocusNode.requestFocus,
                              )
                            ],
                          ])),
                      // Payment
                      Text(
                        AppLocalizations.of(context)!.payment_title,
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ]),
                  ),
                ),
                Container(
                  height: 120.v,
                  padding: EdgeInsets.all(8.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                AppLocalizations.of(context)!.total_price_title,
                                style: Theme.of(context).textTheme.bodyLarge),
                            // TODO: Implement prices
                            Text(_numberFormat.format(1500000),
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                        CustomElevatedButton(
                            width: 130.h,
                            buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary),
                            text: AppLocalizations.of(context)!
                                .place_order_button_title,
                            buttonTextStyle:
                                Theme.of(context).textTheme.labelLarge,
                            onPressed: _placeOrder),
                      ]),
                )
              ],
            )));
  }

  void _placeOrder() {}
}

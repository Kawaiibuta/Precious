import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/data_sources/cart/cart.dart';
import 'package:precious/presenters/cart_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/cart_item.dart';
import 'package:precious/data_sources/cart_item/cart_item.dart' as model;
import 'package:precious/views/item_detail_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> implements CartPageContract {
  List<model.CartItem>? cartList;

  late CartPagePresenter _presenter;

  var selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    _presenter = CartPagePresenter(this);
    _presenter.getCart();
  }

  @override
  Widget build(BuildContext context) {
    if (cartList == null) {
      return Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ));
    }
    return SizedBox(
      width: double.maxFinite,
      child: Stack(children: [
        SizedBox(
          height: double.maxFinite,
          child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: Navigator.of(context).pop,
                        icon: const Icon(Icons.arrow_back_ios)),
                    Text(
                      AppLocalizations.of(context)!.my_cart,
                      style: GoogleFonts.openSans(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(Icons.deselect))
              ],
            ),
            cartList == null || cartList!.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: 340.v),
                    child: Text(
                      AppLocalizations.of(context)!.empty_cart_msg,
                      textAlign: TextAlign.center,
                    ))
                : Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              AppLocalizations.of(context)!
                                  .delete_all_text_button,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                            ))
                      ],
                    ),
                    for (var cartItem in cartList!)
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.v),
                        child: CartItem(
                          backgroundImage:
                              NetworkImage(cartItem.variant.img_paths_url[0]),
                          name: cartItem.variant.product.name,
                          quantity: cartItem.quantity.toDouble(),
                          onTap: () => _goToItemDetailPage(cartItem.id),
                          onQuantityChange: (quantity) =>
                              _callQuantityChange(cartItem, quantity),
                          maxQuantity: 10.0,
                        ),
                      ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .total_buy_item_text(cartList!.length),
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(
                              AppLocalizations.of(context)!.currency_value(
                                  cartList!.fold<double>(
                                      0,
                                      (previousValue, element) =>
                                          previousValue +
                                          element.variant.price *
                                              element.quantity)),
                              style: Theme.of(context).textTheme.headlineSmall)
                        ],
                      ),
                    )
                  ])
          ])),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: selectedQuantity > 0 ? 1.0 : 0.0,
            child: Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.only(right: 8.v, bottom: 8.h),
              child: FittedBox(
                child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: _checkOut,
                    child: const Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        )
      ]),
    );
  }

  @override
  void onGetCartComplete(Cart cart) {
    setState(() => cartList = cart.items);
  }

  @override
  void onGetCartFailed(Exception e) {
    if (e is HttpException) {
      showSnackBar(
          AppLocalizations.of(context)!.unexpected_error_msg(e.message));
    }
  }

  void callLoadingScreen() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
            child: CircularProgressIndicator(color: Colors.white)));
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _checkOut() {
    if (cartList != null && cartList!.isNotEmpty) {}
  }

  void _callQuantityChange(model.CartItem cartItem, double quantity) {
    _presenter.updateQuantity(cartItem, quantity);
  }

  _goToItemDetailPage(int id) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ItemDetailPage(id: id)));
  }
}

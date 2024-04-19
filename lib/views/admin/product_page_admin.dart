import 'package:flutter/material.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';
import 'package:precious/resources/widgets/product_card_admin.dart';

class ProductPageAdmin extends StatefulWidget {
  const ProductPageAdmin({super.key, this.openFloatingButton, this.onSelected});
  final Function? openFloatingButton;
  final Function? onSelected;

  static ProductPageAdmin fromMap(Map<String, dynamic> param) {
    return ProductPageAdmin(
        openFloatingButton: param['openFloatingButton'],
        onSelected: param['onSelected']);
  }

  @override
  _ProductPageAdminState createState() => _ProductPageAdminState();
}

class _ProductPageAdminState extends State<ProductPageAdmin> {
  late Future<List<Product>> productListFuture;

  final productPresenter = ProductPresenter();
  List<int> count = [];
  @override
  void initState() {
    super.initState();
    productListFuture = productPresenter.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomSearchBar(),
          FutureBuilder(
              future: productListFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                      child: Center(
                    child: Text(snapshot.error.toString()),
                  ));
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return const Expanded(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                }
                final productList = snapshot.data!;
                return Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: productList
                        .map((e) => Container(
                              margin:
                                  const EdgeInsets.only(top: 5.0, bottom: 3.0),
                              child: ProductCardAdmin(
                                product: e,
                                onSelected: (int i) {
                                  _handleSelect(i);
                                },
                                onDisSelected: (int i) {
                                  _handleSelect(i);
                                },
                              ),
                            ))
                        .toList(),
                  ),
                );
              })
        ],
      ),
    );
  }

  void _handleSelect(int i) {
    if (count.contains(i)) {
      count.remove(i);
    } else {
      count.add(i);
    }
    if (widget.onSelected != null) widget.onSelected!();
    if (widget.openFloatingButton != null) {
      if (count.length >= 2) widget.openFloatingButton!([0, 1]);
      if (count.isEmpty) widget.openFloatingButton!([0]);
      if (count.length == 1) widget.openFloatingButton!([0, 1, 2]);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';
import 'package:precious/resources/widgets/product_card_admin.dart';

class ProductPageAdmin extends StatefulWidget {
  const ProductPageAdmin({super.key});

  @override
  _ProductPageAdminState createState() => _ProductPageAdminState();
}

class _ProductPageAdminState extends State<ProductPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
      child: Column(
        children: [CustomSearchBar(), ProductCardAdmin()],
      ),
    );
  }
}

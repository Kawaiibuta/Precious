import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCardAdmin extends StatefulWidget {
  const ProductCardAdmin({super.key, this.product, this.productId})
      : assert(productId == null || product == null),
        assert(productId == null && product == null);
  final Product? product;
  final int? productId;
  @override
  _ProductCardAdminState createState() => _ProductCardAdminState();
}

class _ProductCardAdminState extends State<ProductCardAdmin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1))]),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.product))),
            )
          ],
        ),
      ),
    );
  }
}

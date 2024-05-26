import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/views/item_detail_page.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final noSymbolInVNFormat = NumberFormat.currency(locale: "vi_VN");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ItemDetailPage(id: widget.product.id!),
              ));
            },
            child: Column(
              children: [
                Image.network(widget.product.imgPathUrls[0],
                    height: 110.v,
                    cacheHeight: 110.v.toInt(),
                    cacheWidth: 165.h.toInt(),
                    fit: BoxFit.cover),
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                Text(
                  widget.product.shortDescription,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 10),
                ),
                Text(noSymbolInVNFormat.format(widget.product.price),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
              ],
            ),
          ),
        ),
        Positioned(
            right: 12.h,
            top: 12.v,
            child: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
              child: const Icon(
                Icons.favorite_border_outlined,
                size: 20,
                color: Colors.white,
              ),
            ))
      ],
    );
  }
}

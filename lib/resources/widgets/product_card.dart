import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/views/item_detail_page.dart';

var noSimbolInUSFormat = NumberFormat.currency(locale: "en_US");

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ItemDetailPage(id: widget.product.id!),
            ));
          },
          child: SizedBox(
            width: 165,
            child: Column(
              children: [
                Container(
                  height: 195,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: (Uri.parse(widget.product.img_paths_url[0])
                                      .isAbsolute
                                  ? CachedNetworkImageProvider(
                                      widget.product.img_paths_url[0])
                                  : AssetImage(widget.product.img_paths_url[0]))
                              as ImageProvider,
                          fit: BoxFit.cover)),
                ),
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                Text(
                  widget.product.short_description,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 10),
                ),
                Text(
                  noSimbolInUSFormat.format(widget.product.price),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            right: 7,
            top: 7,
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

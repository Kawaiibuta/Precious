import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var noSimbolInUSFormat = NumberFormat.currency(locale: "en_US");

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.name,
      required this.type,
      required this.price,
      required this.url});
  final String name;
  final String type;
  final double price;
  final String url;
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          child: Container(
            width: 165,
            child: Column(
              children: [
                Container(
                  height: 195,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: (Uri.parse(widget.url).isAbsolute
                              ? NetworkImage(widget.url)
                              : AssetImage(widget.url)) as ImageProvider,
                          fit: BoxFit.cover)),
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                Text(
                  widget.type,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 10),
                ),
                Text(
                  noSimbolInUSFormat.format(widget.price),
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

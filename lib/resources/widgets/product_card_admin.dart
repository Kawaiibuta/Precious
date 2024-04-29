import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/variant/variant.dart';
import 'package:precious/presenters/product_presenter.dart';

class ProductCardAdmin extends StatefulWidget {
  const ProductCardAdmin(
      {super.key,
      this.product,
      this.productId,
      this.onSelected,
      this.onDisSelected})
      : assert(productId == null || product == null),
        assert(!(productId == null && product == null));
  final Product? product;
  final int? productId;
  final Function? onSelected;
  final Function? onDisSelected;
  @override
  _ProductCardAdminState createState() => _ProductCardAdminState();
}

class _ProductCardAdminState extends State<ProductCardAdmin> {
  var detailSelected = false;
  var check = false;
  var variantSelected = -1;
  var price = 0.0;
  var image = <String>[];
  Product? product;
  ProductPresenter productPresenter = ProductPresenter();
  @override
  void initState() {
    if (widget.product != null) {
      product = widget.product!;
      image = widget.product!.img_paths_url;
      price = widget.product!.price;
      if (product!.variants == null) {
        productPresenter
            .getOne(widget.product!.id!, detail: true)
            .then((value) => setState(() {
                  product = value;
                }));
      } else {
        setState(() {});
      }
    } else {
      productPresenter.getOne(widget.productId!).then((value) {
        if (value == null) Navigator.of(context).pop();
        setState(() {
          product = value!;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          detailSelected = !detailSelected;
          if (widget.onSelected != null && detailSelected) {
            widget.onSelected!(product!.id);
          }
          if (widget.onDisSelected != null && !detailSelected) {
            widget.onDisSelected!(product!.id);
          }
        });
      },
      child: AnimatedContainer(
        height: detailSelected ? 520 : 100,
        curve: Curves.easeOut,
        padding: EdgeInsets.all(detailSelected ? 10.0 : 5.0),
        duration: const Duration(milliseconds: 1000),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08))]),
        alignment: Alignment.topCenter,
        child: product == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Flex(
                direction: detailSelected ? Axis.vertical : Axis.horizontal,
                children: [
                  AnimatedContainer(
                    height: detailSelected ? 250 : 100,
                    width: detailSelected ? 400 : 100,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(image[0]),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: detailSelected ? 0 : 10,
                        top: detailSelected ? 5 : 0),
                    child: Column(children: [
                      detailSelected
                          ? Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(children: [
                                    Row(
                                      children: [
                                        Text(
                                          product!.name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 27),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Center(
                                          child: Text(
                                            product!.short_description,
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Text(
                                      price > 10 ^ 6
                                          ? "${(price ~/ pow(10, 6))}Tr"
                                          : "${(price ~/ pow(10, 3))}K",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black))
                                ],
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                                text: product!.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        " - ${widget.product!.short_description}",
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .merge(const TextStyle(
                                            overflow: TextOverflow.ellipsis)),
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                      detailSelected
                          ? Column(
                              children: [
                                detailSelected
                                    ? Row(
                                        children: [
                                          Text(
                                            "Description:",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                                Wrap(
                                  children: [
                                    Text(
                                      product!.description,
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Variant:",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    ...(product!.variants ?? <Variant>[])
                                        .asMap()
                                        .map((key, value) => MapEntry(
                                            key,
                                            InkWell(
                                              onTap: () {
                                                _handleChangeVariant(key);
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                margin: const EdgeInsets.only(
                                                    right: 3.0, bottom: 3.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.black
                                                            .withOpacity(0.4)),
                                                    color:
                                                        variantSelected == key
                                                            ? Colors.black
                                                            : Colors.white70),
                                                child: Center(
                                                    child: Text(
                                                  key.toString(),
                                                  style: TextStyle(
                                                      color: (variantSelected ==
                                                              key
                                                          ? Colors.white
                                                          : null),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )),
                                              ),
                                            )))
                                        .values
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox.shrink()
                    ]),
                  ),
                ],
              ),
      ),
    );
  }

  void _handleChangeVariant(int key) {
    setState(() {
      variantSelected = key;
      image = product!.variants![key].img_paths_url;
      price = product!.variants![key].price;
    });
  }
}

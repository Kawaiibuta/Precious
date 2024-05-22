import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/models/option/option.dart';
import 'package:precious/models/option/optionValue/option_value.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/models/variant/variant.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/utils/utils.dart';

const variantSize = 50;

class ProductCardAdmin extends StatefulWidget {
  const ProductCardAdmin(
      {super.key,
      required this.product,
      this.productId,
      this.onSelected,
      this.onDisSelected,
      this.multiSelect = false,
      this.onLongTap})
      : assert(productId == null);
  final Product product;
  final int? productId;
  final Function? onLongTap;
  final Function? onSelected;
  final Function? onDisSelected;
  final bool multiSelect;
  @override
  _ProductCardAdminState createState() => _ProductCardAdminState();
}

class _ProductCardAdminState extends State<ProductCardAdmin> {
  var detailSelected = false;
  var check = false;
  var variantSelected = -1;
  var price = 0.0;
  var image = <String>[];
  late Product product;
  late List<OptionValue> optionList;
  Variant? variant;
  @override
  void initState() {
    super.initState();
    product = widget.product;
    image = widget.product.imgPathUrls;
    price = widget.product.price;
    image = variant?.imgPathUrls ?? product.imgPathUrls;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        debugPrint(widget.multiSelect.toString());
        if (!detailSelected) {
          await ProductRepository.getOne(product.id!).then((value) {
            product = value!;
          });
        }
        debugPrint(product.toString());
        setState(() {
          if (!detailSelected) {
            if (product.options.isNotEmpty) {
              optionList = widget.product.options
                  .where((element) => element.values.isNotEmpty)
                  .map((e) => e.values[0])
                  .toList();
              variant = getVariant(product, optionList);
            }
          }
          detailSelected = !detailSelected;
          if (widget.onSelected != null && detailSelected) {
            widget.onSelected!(product.id);
          }
          if (widget.onDisSelected != null && !detailSelected) {
            widget.onDisSelected!(product.id);
          }
        });
      },
      onLongPress: () {
        if (widget.onLongTap != null && !widget.multiSelect) {
          widget.onLongTap!(product.id);
        }
        setState(() {
          detailSelected = true;
        });
        if (widget.onSelected != null && detailSelected) {
          widget.onSelected!(product.id);
        }
      },
      child: AnimatedContainer(
        height: detailSelected && !widget.multiSelect
            ? product.options.length /
                    (MediaQuery.of(context).size.width / 50) *
                    800 +
                430
            : 100,
        curve: Curves.easeOut,
        padding: EdgeInsets.all(detailSelected ? 10.0 : 5.0),
        duration: const Duration(milliseconds: 1000),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: widget.multiSelect && detailSelected ? Border.all() : null,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08))]),
        alignment: Alignment.topCenter,
        child: product == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Flex(
                direction: detailSelected && !widget.multiSelect
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  AnimatedContainer(
                    height: detailSelected && !widget.multiSelect ? 250 : 100,
                    width: detailSelected && !widget.multiSelect ? 400 : 150,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(image.isNotEmpty
                                ? image[0]
                                : "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: detailSelected && !widget.multiSelect ? 0 : 10,
                          top: detailSelected && !widget.multiSelect ? 5 : 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            detailSelected && !widget.multiSelect
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
                                                product.name,
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
                                                  product.shortDescription,
                                                  style: DefaultTextStyle.of(
                                                          context)
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
                                : Text(
                                    product.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                            !detailSelected || widget.multiSelect
                                ? Text(
                                    widget.product.shortDescription,
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .merge(const TextStyle(
                                            overflow: TextOverflow.ellipsis)),
                                  )
                                : const SizedBox.shrink(),
                            !detailSelected || widget.multiSelect
                                ? Text("Quantity: ${product.quantity}")
                                : const SizedBox.shrink(),
                            detailSelected && !widget.multiSelect
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
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      Wrap(
                                        children: [
                                          Text(
                                            product.description,
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          )
                                        ],
                                      ),
                                      ...widget.product.options
                                          .map((e) => buildOptionCard(e))
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ]),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  buildOptionCard(Option option) {
    final index = widget.product.options.indexOf(option);
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(option.name,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400, fontSize: 20.h))
                    ],
                  ),
                ],
              ),
            ],
          ),
          Wrap(
            children: option.values
                .map((e) => Padding(
                      padding: EdgeInsets.only(right: 8.0.h),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            optionList[index] = e;
                            variant = getVariant(product, optionList);
                            image = variant?.imgPathUrls ?? [];
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                optionList.contains(e)
                                    ? Colors.black
                                    : Colors.grey.shade200)),
                        child: Text(
                          e.value,
                          style: TextStyle(
                              color:
                                  optionList.contains(e) ? Colors.white : null),
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

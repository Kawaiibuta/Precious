import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:precious/models/option/option.dart';
import 'package:precious/models/option/optionValue/option_value.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/variant/variant.dart';
import 'package:precious/presenters/item_detail_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/utils/string_utils.dart';
import 'package:precious/resources/utils/utils.dart';
import 'package:precious/resources/widgets/custom_elevated_button.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';

const imageList = [
  'assets/images/sale.jpg',
  'assets/images/sale.jpg',
  'assets/images/sale.jpg',
  'assets/images/sale.jpg',
];

const des =
    "This beautiful 14k yellow gold bracelet features a delicate chain with a polished finish. The highlight of the bracelet is a charming heart-shaped charm, adorned with sparkling cubic zirconia gemstones. The charm dangles freely from the chain, adding a touch of movement and whimsy. Secured with a lobster clasp closure, this bracelet is a perfect addition to any jewelry collection. https://picsum.photos/id/237/200/300";

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key, required this.id});
  final int id;
  static const name = '/productDetail';

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage>
    implements ItemDetailPageContract {
  var selectedSize = -1;
  var favoriteed = false;
  var quantity = 0;
  late Future<Product?> productFuture;
  Map<Option, OptionValue> optionMap = {};
  final productPresenter = ProductPresenter();
  var open = false;

  late Variant _currentVariant;

  late ItemDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ItemDetailPresenter(this);
    productFuture = productPresenter.getOne(widget.id, detail: true).then((e) {
      if (e != null) {
        var list = <OptionValue>[];
        for (var option in e.options) {
          optionMap.addAll({
            option: option.values[0],
          });
          list.add(option.values[0]);
        }
        _currentVariant = getVariant(e, list);
      }
      return e;
    }).catchError(onError);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: productFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  (!snapshot.hasData || snapshot.data == null)) {
                Navigator.of(context).pop();
                return const SizedBox.shrink();
              }
              final product = snapshot.data!;
              return Flex(
                direction: Axis.vertical,
                children: [
                  SizedBox(
                    child: Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              height: 400.v, viewportFraction: 1),
                          items: _currentVariant.imgPathUrls.map((i) {
                            return InkWell(
                              onTap: () {
                                showImageViewer(
                                    context,
                                    (Uri.parse(i).isAbsolute
                                        ? CachedNetworkImageProvider(i,
                                            maxHeight: 400.v.toInt())
                                        : AssetImage(i)) as ImageProvider,
                                    onViewerDismissed: () =>
                                        debugPrint("dismissed"));
                              },
                              child: CachedNetworkImage(
                                imageUrl: i,
                                fit: BoxFit.cover,
                                // placeholder: (context, e) => const Center(
                                //     child: CircularProgressIndicator()),
                                progressIndicatorBuilder:
                                    (context, e, progress) =>
                                        CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 5.0,
                                  percent: progress.downloaded /
                                      (progress.totalSize ??
                                          progress.downloaded),
                                  progressColor: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        // AnimatedPositioned(
                        //     top: 25,
                        //     left: 0,
                        //     right: 0,
                        //     height: open ? 50 : 0,
                        //     duration: const Duration(seconds: 2),
                        //     child: const Padding(
                        //         padding: EdgeInsets.only(left: 30, right: 30),
                        //         child: CustomSearchBar())),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 600,
                          padding: const EdgeInsets.all(18.0),
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: GoogleFonts.openSans(
                                              fontSize: 27,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(product.shortDescription,
                                            style: GoogleFonts.openSans(
                                                fontSize: 10,
                                                color: Colors.grey,
                                                fontWeight:
                                                    FontWeight.bold)),
                                        const Row(
                                          children: [
                                            //Review goes here in the 2.0 version
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              favoriteed = !favoriteed;
                                            });
                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: favoriteed
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Icon(
                                              favoriteed
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border_outlined,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(top: 18.0, bottom: 18.0),
                                //   child: Row(children: [
                                //     Text("Sizes:",
                                //         style: GoogleFonts.openSans(
                                //             fontSize: 20,
                                //             color: Colors.black,
                                //             fontWeight: FontWeight.bold))
                                //   ]),
                                // ),
                                // Row(children: [
                                //   if (product.variants.isEmpty)
                                //     Text(
                                //         AppLocalizations.of(context)!.no_variants_msg,
                                //         style: Theme.of(context).textTheme.bodyMedium)
                                //   else
                                //     ...product.options
                                //         .asMap()
                                //         .map((key, option) => MapEntry(
                                //               key,
                                //               Container(
                                //                 width: 50,
                                //                 height: 50,
                                //                 alignment: Alignment.center,
                                //                 margin: const EdgeInsets.only(
                                //                     right: 10.0),
                                //                 decoration: BoxDecoration(
                                //                     shape: BoxShape.circle,
                                //                     border: Border.all(
                                //                         color: Colors.grey),
                                //                     color: selectedSize == key
                                //                         ? Colors.black
                                //                         : null),
                                //                 child: InkWell(
                                //                   onTap: () {
                                //                     selectedSize = key;
                                //                     setState(() {});
                                //                   },
                                //                   child: Text(
                                //                       option.
                                //                           .firstWhere((e) =>
                                //                               e.option.name == 'size')
                                //                           .optionValue
                                //                           .value,
                                //                       style: GoogleFonts.openSans(
                                //                           fontSize: 17,
                                //                           color: selectedSize == key
                                //                               ? Colors.white
                                //                               : Colors.grey,
                                //                           fontWeight:
                                //                               FontWeight.bold)),
                                //                 ),
                                //               ),
                                //             ))
                                //         .values
                                // ]),
                                SizedBox(height: 20.v),
                                Text('Variant', style: Theme.of(context).textTheme.titleLarge),
                                SizedBox(height: 8.v),
                                for (var option in product.options) ...[
                                  Text(option.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.v),
                                    child: Wrap(
                                      spacing: 8.h,
                                      direction: Axis.horizontal,
                                      children: [
                                        for (var optionValue in option.values)
                                          InkWell(
                                            onTap: () => setState(() {
                                              optionMap[option] = optionValue;
                                              _currentVariant = getVariant(
                                                  product, [
                                                for (var e in optionMap.entries)
                                                  e.value
                                              ]);
                                            }),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.h),
                                                    color: optionMap[option] ==
                                                            optionValue
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.h,
                                                      vertical: 8.v),
                                                  child: Text(
                                                    optionValue.value,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: optionMap[
                                                                        option] ==
                                                                    optionValue
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSecondary),
                                                  ),
                                                )),
                                          )
                                      ],
                                    ),
                                  )
                                ],
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Text("Descriptions",
                                        style: GoogleFonts.openSans(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))),
                                Wrap(
                                  children: [
                                    ...getLink(product.description).map((e) {
                                      if (Uri.parse(e).isAbsolute) {
                                        return InkWell(
                                            onTap: () {
                                              showImageViewer(context,
                                                  CachedNetworkImageProvider(e),
                                                  onViewerDismissed: () {
                                                debugPrint("Dismissed");
                                              });
                                            },
                                            child: Image.network(
                                              e,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ));
                                      } else {
                                        return Text(e,
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500));
                                      }
                                    })
                                  ],
                                ),
                                SizedBox(
                                  height: 100.v,
                                )
                              ])),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                                height: 100.v,
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Total price"),
                                          Text(
                                            product.price > 10 ^ 6
                                                ? "${(product.price ~/ pow(10, 6))}Tr"
                                                : "${(product.price ~/ pow(10, 3))}K",
                                            style: GoogleFonts.openSans(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: CustomElevatedButton(
                                            isDisabled:
                                                _currentVariant.quantity == 0,
                                            onPressed: _addToCart,
                                            buttonStyle:
                                                ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                            text: AppLocalizations.of(context)!
                                                .add_to_cart_btn_title,
                                            buttonTextStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge))
                                  ],
                                ))),
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  void _addToCart() {
    _presenter.addToCart(_currentVariant);
  }

  @override
  void onAddToCartError(e) {
    if (e is DioException) {
      debugPrint(e.message);
      debugPrint('${e.response?.statusCode}: ${e.response?.statusMessage}');
      showSnackBar(AppLocalizations.of(context)!
          .unexpected_error_msg(e.response?.statusMessage ?? 'UNKNOWN'));
    }
  }

  @override
  void onAddToCartSuccess() {
    showSnackBar(AppLocalizations.of(context)!.add_to_cart_success_msg);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  onError(e) {
    if (e is DataException) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.reason)));
    } else if (e is DioException) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.response?.statusMessage ?? 'UNKNOWN')));
    }
  }
}

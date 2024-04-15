import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:precious/resources/utils/string_utils.dart';
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
  final String id;
  static const name = '/productDetail';

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  var selectedSize = -1;
  var favoriteed = false;
  var quantity = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => __handleUp());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                  aspectRatio: MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height),
              items: imageList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        showImageViewer(
                            context,
                            (Uri.parse(i).isAbsolute
                                ? NetworkImage(i)
                                : AssetImage(i)) as ImageProvider,
                            onViewerDismissed: () {
                          print("dismissed");
                        });
                      },
                      child: Image.asset(
                        i,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const Positioned(
              top: 25,
              left: 0,
              right: 0,
              child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: CustomSearchBar())),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          __handleUp();
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void __handleUp() {
    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return Material(
                  child: Stack(
                    children: [
                      Container(
                        height: 600,
                        padding: const EdgeInsets.all(18.0),
                        child: SingleChildScrollView(
                            child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Necklace",
                                            style: GoogleFonts.openSans(
                                                fontSize: 27,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("Hermes",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      //Review goes here in the 2.0 version
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                            : Icons.favorite_border_outlined,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 18.0, bottom: 18.0),
                            child: Row(children: [
                              Text("Sizes:",
                                  style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ]),
                          ),
                          Row(children: [
                            ...[8, 9, 10, 11]
                                .asMap()
                                .map((key, value) => MapEntry(
                                      key,
                                      Container(
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.grey),
                                            color: selectedSize == key
                                                ? Colors.black
                                                : null),
                                        child: InkWell(
                                          onTap: () {
                                            selectedSize = key;
                                            setState(() {});
                                          },
                                          child: Text(value.toString(),
                                              style: GoogleFonts.openSans(
                                                  fontSize: 17,
                                                  color: selectedSize == key
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ))
                                .values
                                .toList()
                          ]),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Row(
                              children: [
                                Text("Descriptions",
                                    style: GoogleFonts.openSans(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Wrap(
                            children: [
                              ...getLink(des).map((e) {
                                if (Uri.parse(e).isAbsolute) {
                                  return InkWell(
                                      onTap: () {
                                        showImageViewer(
                                            context, NetworkImage(e),
                                            onViewerDismissed: () {
                                          print("dismissed");
                                        });
                                      },
                                      child: Image.network(
                                        e,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
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
                          const SizedBox(
                            height: 70,
                          )
                        ])),
                      ),
                      Positioned(
                          bottom: 30,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                height: 50,
                                margin: const EdgeInsets.only(
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
                                        children: [
                                          const Text("Total price"),
                                          Text(
                                            "198.00",
                                            style: GoogleFonts.openSans(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: InkWell(
                                          child: Container(
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.black),
                                            child: const Center(
                                              child: Text("Add to cart",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ))
                                  ],
                                )),
                          )),
                    ],
                  ),
                );
              },
            ));
  }
}

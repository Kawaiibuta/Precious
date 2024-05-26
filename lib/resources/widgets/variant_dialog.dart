import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:precious/models/option/optionValue/option_value.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/models/variant/variant.dart';
import 'package:precious/main.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/utils/dio_utils.dart';
import 'package:precious/resources/utils/utils.dart';

class VariantDialog extends StatefulWidget {
  const VariantDialog({super.key, required this.product});

  final Product product;
  @override
  _VariantDialogState createState() => _VariantDialogState();
}

class _VariantDialogState extends State<VariantDialog> {
  late List<OptionValue> optionList;
  Variant? variant;
  List<XFile> imageList = [];
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  List<String> modifiedVariantImageList = [];
  @override
  void initState() {
    super.initState();
    optionList = widget.product.options
        .where((element) => element.values.isNotEmpty)
        .map((e) => e.values[0])
        .toList();
    optionList = widget.product.options.map((e) => e.values[0]).toList();
    variant = getVariant(widget.product, optionList);
    if (variant != null) {
      nameController.text = variant!.name;
      priceController.text = variant!.price.toString();
      quantityController.text = variant!.quantity.toString();
      modifiedVariantImageList = variant!.imgPathUrls;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Variant"),
          IconButton(
              onPressed: () {
                variant = getVariant(widget.product, optionList);
                imageList.clear();
                if (variant != null) {
                  nameController.text = variant!.name;
                  priceController.text = variant!.price.toString();
                  quantityController.text = variant!.quantity.toString();
                  modifiedVariantImageList = variant!.imgPathUrls;
                }
              },
              icon: const Icon(Icons.restore))
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 300.h,
            child: SingleChildScrollView(
              child: Column(children: [
                ...widget.product.options.map((e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${e.name}: ",
                            style: GoogleFonts.openSans(
                                fontSize: 15.h, fontWeight: FontWeight.w300),
                          ),
                          DropdownMenu<OptionValue>(
                            initialSelection: e.values.first,
                            onSelected: (OptionValue? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                if (value != null) {
                                  optionList[widget.product.options
                                      .indexOf(e)] = value;
                                  variant =
                                      getVariant(widget.product, optionList);
                                  if (variant != null) {
                                    nameController.text = variant!.name;
                                    priceController.text =
                                        variant!.price.toString();
                                    quantityController.text =
                                        variant!.quantity.toString();
                                    modifiedVariantImageList =
                                        variant!.imgPathUrls;
                                  }
                                }
                              });
                              debugPrint(optionList.toString());
                            },
                            dropdownMenuEntries: e.values
                                .map<DropdownMenuEntry<OptionValue>>((value) {
                              return DropdownMenuEntry<OptionValue>(
                                  value: value, label: value.value);
                            }).toList(),
                          )
                        ])),
                Row(
                  children: [
                    const Text("Name: "),
                    Flexible(
                        child: TextField(
                      controller: nameController,
                      style: GoogleFonts.openSans(
                          fontSize: 15.h, fontWeight: FontWeight.w300),
                      decoration:
                          const InputDecoration(hintText: "variant's name...."),
                    ))
                  ],
                ),
                Row(
                  children: [
                    const Text("Price: "),
                    Flexible(
                        child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.openSans(
                          fontSize: 15.h, fontWeight: FontWeight.w300),
                      decoration: const InputDecoration(
                          hintText: "variant's price...."),
                    ))
                  ],
                ),
                Row(
                  children: [
                    const Text("Quantity: "),
                    Flexible(
                        child: TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.openSans(
                          fontSize: 15.h, fontWeight: FontWeight.w300),
                      decoration: const InputDecoration(
                          hintText: "variant's quantity...."),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Images:",
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                    IconButton(
                      onPressed: () => _handleSelectImage(),
                      icon: const Icon(Icons.add),
                    )
                  ],
                ),
                Wrap(
                  children: [
                    if (variant != null)
                      ...modifiedVariantImageList.map((e) {
                        return InkWell(
                          onTap: () => setState(() {
                            modifiedVariantImageList.remove(e);
                          }),
                          child: Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(right: 5, bottom: 5),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: e,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }),
                    ...imageList.map((e) {
                      return InkWell(
                        onTap: () => setState(() {
                          imageList.remove(e);
                        }),
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(right: 5, bottom: 5),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.file(
                            File(e.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ]),
            ),
          ),
          AnimatedOpacity(
            opacity: nameController.text.isNotEmpty &&
                    priceController.text.isNotEmpty &&
                    quantityController.text.isNotEmpty
                ? 1
                : 0,
            duration: Durations.short3,
            child: TextButton(
              onPressed: () {
                _handleAddVariant();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              child: Text(
                "Update",
                style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSelectImage() {
    final ImagePicker picker = ImagePicker();
    picker.pickMultiImage().then((value) => setState(() {
          debugPrint(value.toString());
          imageList = imageList + value;
        }));
  }

  Future<void> _handleAddVariant() async {
    showDialog(
        context: NavigationService.navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        });
    if (variant == null) {
      debugPrint("No variant selected");
      return;
    }
    final newVariant = variant!.copyWith(
        name: nameController.text,
        price: double.parse(priceController.text),
        quantity: int.parse(quantityController.text));
    var imageMap = <String, Uint8List>{};
    for (var image in modifiedVariantImageList) {
      final response = await dio.get(image,
          options: Options(responseType: ResponseType.bytes));
      if (response.statusCode == 200) {
        imageMap.addEntries(<String, Uint8List>{
          image.split("/").last: response.data as Uint8List
        }.entries);
      }
    }
    for (var image in imageList) {
      imageMap.addEntries(
          <String, Uint8List>{image.name: await image.readAsBytes()}.entries);
    }
    ProductRepository.addVariant(widget.product.id!, newVariant, imageMap)
        .then((value) {
      if (value != null) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        Get.snackbar("Update variant",
            "Some error has ocurred. Please wait a moment and try again.",
            backgroundColor: Colors.white);
      }
    });
  }
}

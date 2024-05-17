import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_category/product_category.dart';
import 'package:precious/data_sources/variant/variant.dart';
import 'package:precious/presenters/category_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/views/item_detail_page.dart';

class InventoryForm extends StatefulWidget {
  const InventoryForm({super.key, this.product});
  static const name = "inventory_form";
  final Product? product;
  @override
  _InventoryFormState createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm> {
  late Future<List<ProductCategory>> futureCategoryList;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final categoryPresenter = ProductCategoryPresenter();
  final productPresenter = ProductPresenter();
  int? selectedCategory;
  List<String> currentImageList = [];
  var product = Product(variants: []);
  var variantList = <Variant>[];
  List<XFile> imageList = [];
  final nameController = TextEditingController();
  final shortDesController = TextEditingController();
  final desController = TextEditingController();
  final priceController = TextEditingController();
  var addable = false;
  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      product = widget.product!;
      nameController.text = product.name;
      shortDesController.text = product.short_description;
      desController.text = product.description;
      priceController.text = product.price.toString();
      selectedCategory = product.category_id;
    }
    futureCategoryList = categoryPresenter.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Product Form",
                  style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text("Name"),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'Your product name here',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: shortDesController,
                    onChanged: (e) => setState(() {}),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Short description cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text("Short description"),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'A little bit about your product',
                    ),
                  ),
                ),
                FutureBuilder(
                    future: futureCategoryList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) return const SizedBox.shrink();
                      final categoriesList = snapshot.data!;
                      // categoriesList.removeAt(0);
                      return Wrap(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("Categories:",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                          ),
                          ...categoriesList.map((e) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0, right: 2.0),
                                child: ButtonTheme(
                                  // minWidth: 50,
                                  height: 10,
                                  child: OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedCategory = e.id;
                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  e.id == selectedCategory
                                                      ? Colors.black
                                                      : Colors.transparent)),
                                      child: Text(
                                        e.name,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: e.id == selectedCategory
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                ),
                              ))
                        ],
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextField(
                    controller: desController,
                    style: const TextStyle(color: Colors.black),
                    maxLines: 8,
                    decoration: const InputDecoration(
                      label: Text("Description"),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'Your product description',
                    ),
                  ),
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
                      onPressed: () {
                        _handleSelectImage();
                      },
                      icon: const Icon(Icons.add),
                    )
                  ],
                ),
                Wrap(
                  children: [
                    ...imageList.map((e) {
                      return InkWell(
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(right: 5, bottom: 5),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.file(
                            width: 100,
                            height: 100,
                            File(e.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Variants:",
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                    IconButton(
                      onPressed: () {
                        _handleAddVariant();
                      },
                      icon: const Icon(Icons.add),
                    )
                  ],
                ),
                ...variantList.map(
                  (e) => buildVariantCard(e, context),
                ),
                TextButton(
                  onPressed: () {
                    _handleOnChange();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text(
                    "Add product",
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAutoID() {}

  void _handleSelectImage() {
    final ImagePicker picker = ImagePicker();
    picker.pickMultiImage().then((value) => setState(() {
          debugPrint(value.toString());
          imageList = imageList + value;
        }));
  }

  void _handleExtendImage(XFile e) async {}

  Future<bool> _handleOnChange() async {
    debugPrint("asda");
    if (selectedCategory == null) {
      Fluttertoast.showToast(msg: "Please select a category");
      return false;
    }
    if (imageList.isEmpty) {
      Fluttertoast.showToast(msg: "Atleast 1 image is needed");
      return false;
    }
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Some required fields are missing");
      return false;
    }
    final temp = Product(
        name: nameController.text,
        category_id: selectedCategory!,
        short_description: shortDesController.text,
        description: desController.text);
    final createProductResult =
        await productPresenter.add(temp, imageList).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Some unexpected error has happened");
      } else {
        Fluttertoast.showToast(msg: "Your product have been created");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ItemDetailPage(id: value.id!),
        ));
      }

      return value;
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    });
    if (createProductResult != null) {
      var futureList = <Future<Variant?>>[];
      for (var variant in variantList) {
        futureList
            .add(productPresenter.addVariant(createProductResult.id!, variant));
      }
      await Future.wait(futureList).catchError((error) {
        debugPrint(error.toString());
        return <Variant?>[];
      });
    }
    return createProductResult == null;
  }

  void _handleAddVariant({Variant? variant}) {
    var price = .0;
    var quantity = 0;
    var variantImageList = <String>[];
    if (variant != null) {
      price = variant.price;
      quantity = variant.quantity;
      variantImageList.addAll(variant.img_paths_url);
    }
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Variant",
                style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                initialValue: variant == null ? null : price.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.parse(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Price',
                ),
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                initialValue: variant == null ? null : quantity.toString(),
                onChanged: (value) {
                  quantity = int.parse(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Quantity',
                ),
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
                    onPressed: () async {
                      variantImageList.addAll(
                          (await _handleVariantSelectImage())
                              .map((e) => e.path));
                      setState(() {});
                    },
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
              Wrap(
                children: [
                  ...variantImageList.map((e) {
                    return InkWell(
                        onTap: () {
                          showImageViewer(
                              context,
                              (Uri.parse(e).isAbsolute
                                  ? CachedNetworkImageProvider(e)
                                  : FileImage(File(e))) as ImageProvider,
                              onViewerDismissed: () {});
                        },
                        child: Uri.parse(e).isAbsolute
                            ? CachedNetworkImage(
                                width: 100,
                                height: 100,
                                imageUrl: e,
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
                              )
                            : Image.file(width: 100, height: 100, File(e)));
                  })
                ],
              ),
              TextButton(
                onPressed: () {
                  if (variantImageList.isEmpty) {
                    Fluttertoast.showToast(msg: "At least 1 image is needed.");
                    return;
                  }
                  if (quantity <= 0) {
                    Fluttertoast.showToast(
                        msg: "Quantity must be an integer and not less than 1");
                    return;
                  }
                  Navigator.of(context).pop(true);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                child: Text(
                  "Add variant",
                  style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((value) {
      if (value != null && value) {
        debugPrint(quantity.toString());
        setState(() {
          if (variant == null) {
            variantList.add(Variant(
                price: price,
                quantity: quantity,
                img_paths_url: variantImageList));
            return;
          }
          final index = variantList.indexOf(variant);
          final result = variant.copyWith(
              price: price,
              quantity: quantity,
              img_paths_url: variantImageList);
          variantList[index] = result;
        });
      }
    });
  }

  Future<List<XFile>> _handleVariantSelectImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickMultiImage();
  }

  Widget buildVariantCard(Variant variant, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10.0)),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(variant.id == null ? "N/A" : variant.id.toString()),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Price: ${variant.price}"),
                      Text("Quantity: ${variant.quantity}")
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _handleAddVariant(variant: variant);
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          variantList.remove(variant);
                        });
                      },
                      icon: const Icon(Icons.delete)),
                ],
              )
            ],
          ),
          Wrap(
            children: variant.img_paths_url
                .map((e) => InkWell(
                    onTap: () {
                      showImageViewer(
                          context,
                          (Uri.parse(e).isAbsolute
                              ? CachedNetworkImageProvider(e)
                              : FileImage(File(e))) as ImageProvider,
                          onViewerDismissed: () {});
                    },
                    child: Uri.parse(e).isAbsolute
                        ? CachedNetworkImage(
                            width: 50,
                            height: 50,
                            imageUrl: e,
                            progressIndicatorBuilder: (context, e, progress) =>
                                CircularPercentIndicator(
                              radius: 30.0,
                              lineWidth: 5.0,
                              percent: progress.downloaded /
                                  (progress.totalSize ?? progress.downloaded),
                              progressColor: Colors.black,
                            ),
                          )
                        : Image.file(width: 50, height: 50, File(e))))
                .toList(),
          )
        ],
      ),
    );
  }
}

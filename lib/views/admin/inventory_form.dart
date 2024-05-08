import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_category/product_category.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/presenters/category_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';

class InventoryForm extends StatefulWidget {
  const InventoryForm({super.key});
  static const name = "inventory_form";
  @override
  _InventoryFormState createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm> {
  late Future<List<ProductCategory>> futureCategoryList;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final categoryPresenter = ProductCategoryPresenter();
  final productPresenter = ProductPresenter();
  ProductCategory? selectedCategory;
  var product = Product();
  List<XFile> imageList = [];
  final nameController = TextEditingController();
  final shortDesController = TextEditingController();
  final desController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  var addable = false;
  @override
  void initState() {
    super.initState();
    futureCategoryList = categoryPresenter.getAll();
    quantityController.value = TextEditingValue(text: "1");
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
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
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
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          controller: quantityController,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Quantity cannot be empty";
                            }
                            if (int.parse(value) <= 0) {
                              return "Quantity cannot be less than 1";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label: Text("Quantity"),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
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
                                          selectedCategory = e;
                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  e == selectedCategory
                                                      ? Colors.black
                                                      : Colors.transparent)),
                                      child: Text(
                                        e.name,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: e == selectedCategory
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
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: priceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Price cannot be empty";
                      }
                      try {
                        double.parse(value);
                      } catch (e) {
                        return "Price must be a number";
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Price"),
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      hintText: 'The price',
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
    if (selectedCategory == null) {
      Fluttertoast.showToast(msg: "Please select a category");
      return false;
    }
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Some required fields are missing");
      return false;
    }
    final temp = Product(
        name: nameController.text,
        category_id: selectedCategory!.id!,
        short_description: shortDesController.text,
        description: desController.text,
        quantity: int.parse(quantityController.text),
        price: double.parse(priceController.text));
    return ProductRepository.add(temp, imageList: imageList).then((value) {
      Fluttertoast.showToast(msg: "Your product have been created");
      return true;
    }).catchError((e) {
      Fluttertoast.showToast(msg: "Some error has happened");
      return false;
    });
  }
}

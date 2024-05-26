import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:precious/models/option/option.dart';
import 'package:precious/models/option/optionValue/option_value.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/main.dart';
import 'package:precious/presenters/inventory_form_presenter.dart';
import 'package:precious/resources/app_export.dart';

class InventoryForm extends StatefulWidget {
  const InventoryForm({super.key, this.product});
  static const name = "inventory_form";
  final Product? product;
  @override
  _InventoryFormState createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm>
    implements InventoryFormContract {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final shortDesController = TextEditingController();
  final desController = TextEditingController();
  final priceController = TextEditingController();
  var loading = false;
  late InventoryFormPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = InventoryFormPresenter(this, item: widget.product);
    WidgetsBinding.instance.addPostFrameCallback((_) => _presenter.init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50.h,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Product Form",
                            style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.arrow_back)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
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
                  if (loading)
                    const SizedBox.shrink()
                  else
                    Wrap(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text("Categories:",
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16)),
                        ),
                        ..._presenter.categoryList.map((e) => Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: ButtonTheme(
                                // minWidth: 50,
                                height: 10,
                                child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _presenter.selectedCategory = e.id;
                                      });
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(e.id ==
                                                    _presenter.selectedCategory
                                                ? Colors.black
                                                : Colors.transparent)),
                                    child: Text(
                                      e.name,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: e.id ==
                                                  _presenter.selectedCategory
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                              ),
                            ))
                      ],
                    ),
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
                      ..._presenter.imageList.map((e) {
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
                      Text("Options:",
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16)),
                      IconButton(
                        onPressed: () {
                          _handleAddOption();
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                  ..._presenter.product.options.map(
                    (e) => buildOptionCard(e, context),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("Variant:",
                  //         style: GoogleFonts.openSans(
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.w700,
                  //             fontSize: 16)),
                  //     IconButton(
                  //       onPressed: () {
                  //         _handleAddVariant();
                  //       },
                  //       icon: const Icon(Icons.add),
                  //     )
                  //   ],
                  // ),
                  // ..._presenter.product.variants!.map(
                  //   (e) => buildVariantCard(e, context),
                  // ),
                  TextButton(
                    onPressed: () {
                      _handleOnChange();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: Text(
                      "Add product",
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
        ),
      ),
    );
  }

  void _handleSelectImage() {
    final ImagePicker picker = ImagePicker();
    picker.pickMultiImage().then((value) => setState(() {
          debugPrint(value.toString());
          _presenter.imageList = _presenter.imageList + value;
        }));
  }

  Future<bool> _handleOnChange() async {
    //Validate the  before adding to the presenter to crate/update product
    //Check missing field
    //Check imageList
    //Check selected category
    if (_presenter.selectedCategory == null) {
      Get.snackbar("Fill the form", "Please select a category",
          backgroundColor: Colors.white);
      return false;
    }
    if (_presenter.imageList.isEmpty) {
      Get.snackbar("Fill the form", "At least 1 image is needed",
          backgroundColor: Colors.white);
      return false;
    }
    if (!_formKey.currentState!.validate()) {
      Get.snackbar("Fill the form", "Some required fields are missing",
          backgroundColor: Colors.white);
      return false;
    }
    _presenter.item = _presenter.product.copyWith(
        name: nameController.text,
        shortDescription: shortDesController.text,
        description: desController.text,
        categoryId: _presenter.selectedCategory ?? 0);
    if (widget.product == null) {
      _presenter.add();
    } else {
      _presenter.update();
    }
    return true;
  }

  void _handleAddOption({Option? option}) {
    List<OptionValue> optionValue = <OptionValue>[];
    var name = '';
    if (option != null) {
      optionValue = option.values;
      name = option.name;
    }
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 300.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Option",
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(
                            width: 10.0.h,
                          ),
                          Flexible(
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              initialValue:
                                  option == null ? null : name.toString(),
                              onChanged: (value) {
                                name = value;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...optionValue
                          .asMap()
                          .map((key, e) => MapEntry(
                              key,
                              Container(
                                margin: const EdgeInsets.only(top: 5.0),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  initialValue: option == null
                                      ? null
                                      : e.value.toString(),
                                  onChanged: (value) {
                                    optionValue[key] = e.copyWith(value: value);
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your value here',
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () => setState(() {
                                        debugPrint(optionValue.toString());
                                        optionValue.removeAt(key);
                                      }),
                                      icon: const Icon(Icons.clear),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                  ),
                                ),
                              )))
                          .values,
                      IconButton(
                        onPressed: () {
                          setState(() {
                            optionValue.add(OptionValue(value: ""));
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: TextButton(
                  onPressed: () {
                    if (name.isEmpty) {
                      Get.snackbar("Fill the form",
                          "Please fill out all field in the form.",
                          backgroundColor: Colors.white);
                      return;
                    }
                    if (optionValue
                        .where((element) => element.value.isEmpty)
                        .isNotEmpty) {
                      Get.snackbar("Fill the form",
                          "All the option value must have a value.",
                          backgroundColor: Colors.white);
                      return;
                    }
                    Navigator.of(context).pop(true);
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
        ),
      ),
    ).then((value) {
      if (value != null && value) {
        setState(() {
          if (option == null) {
            _presenter.product.options
                .add(Option(name: name, values: optionValue));
            return;
          }
          final index = _presenter.product.options.indexOf(option);
          final result = option.copyWith(name: name, values: optionValue);
          _presenter.product.options[index] = result;
        });
      }
    });
  }

  buildOptionCard(Option e, BuildContext context) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 20.h),
                      ),
                      Text(e.name,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400, fontSize: 20.h))
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _handleAddOption(option: e);
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _presenter.product.options.remove(e);
                        });
                      },
                      icon: const Icon(Icons.delete)),
                ],
              )
            ],
          ),
          Wrap(
            children: e.values
                .map((e) => Padding(
                      padding: EdgeInsets.only(right: 8.0.h),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.grey.shade200)),
                        child: Text(
                          e.value,
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  @override
  void onAddFail() {
    // TODO: implement onAddFail
  }

  @override
  void onAddSuccess() {}

  @override
  void onStartAsyncTask() {
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
  }

  @override
  void onEndAsyncTask() {
    Get.back();
  }

  @override
  void onInitFail() {
    // TODO: implement onInitFail
  }

  @override
  void onInitSuccess() {
    // TODO: implement onInitSuccess
  }

  @override
  void onRefreshFail() {
    // TODO: implement onRefreshFail
  }

  @override
  void onRefreshSuccess() {
    // TODO: implement onRefreshSuccess
  }
  @override
  void onUpdateFail() {
    // TODO: implement onUpdateFail
  }

  @override
  void onUpdateSuccess() {
    // TODO: implement onUpdateSuccess
  }
}

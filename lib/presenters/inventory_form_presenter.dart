import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:precious/data_sources/category_reppsitory.dart';
import 'package:precious/models/option/option.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/product_category/product_category.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/models/variant/variant.dart';
import 'package:precious/main.dart';
import 'package:precious/presenters/form_presenter.dart';

abstract class InventoryFormContract {
  void onInitSuccess();
  void onInitFail();
  void onRefreshSuccess();
  void onRefreshFail();
  void onAddSuccess();
  void onUpdateSuccess();
  void onAddFail();
  void onUpdateFail();
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

  void onEndAsyncTask() {
    Get.back();
  }
}

class InventoryFormPresenter implements FormPresenter {
  @override
  var item;
  final InventoryFormContract _contract;
  int? selectedCategory;
  List<String> currentImageList = [];
  List<XFile> imageList = [];
  InventoryFormPresenter(this._contract, {this.item}) {
    //Duplicate a product from the product input parameter
    //This handle if the form is updating a product or create
    // If update, duplicate product with new data
    // If create, create new product with input data
    item ??= Product(options: <Option>[], variants: <Variant>[]);
  }
  List<ProductCategory> get categoryList =>
      ProductCategoryRepository.list.values.toList();

  Product get product => item as Product;
  @override
  Future<void> add() async {
    try {
      _contract.onStartAsyncTask();
      //From List<XFile> get from ImagePicker to List<Uint8List> for sending Multipart
      var result = <String, Uint8List>{};
      for (var element in imageList) {
        final byte = await element.readAsBytes();
        result.addEntries(<String, Uint8List>{element.name: byte}.entries);
      }
      // The data is validated from the contract
      //No need to validate data here in presenter
      //Start update/add product to database
      final product = await ProductRepository.add(item, result);
      debugPrint("Product has been created.");
      // Throw exception if the product return from the repository is null
      if (product == null) {
        throw Exception("An error has occurred when creating a product");
      }
      // Add option to the newly created product
      final addOptionResponse = await Future.wait((item as Product)
          .options
          .map((e) => ProductRepository.addOption(product.id!, e)));
      if (addOptionResponse.contains(null)) {
        throw Exception("An error has occurred when adding option");
      } else {
        debugPrint("Option has been created");
      }
      // // Add variant to the newly created product
      // final variantResponse =
      //     await Future.wait((item as Product).variants!.map((e) async {
      //   var result = <String, Uint8List>{};
      //   for (var element in e.imgPathUrls) {
      //     final file = XFile(element);
      //     final byte = await file.readAsBytes();
      //     result.addEntries(<String, Uint8List>{file.name: byte}.entries);
      //   }
      //   return ProductRepository.addVariant(product.id!, e, result);
      // }));
      // debugPrint("Variants have been created");

      // if (variantResponse.contains(null)) {
      //   throw Exception("An error has occurred when adding option");
      // }
      //Send message to call populate variant and option
      final resultProduct =
          await ProductRepository.createVariantForProduct(product.id!);
      if (resultProduct != null && resultProduct.variants.isEmpty) {
        _contract.onAddFail();
      }

      debugPrint("Add product done");
      _contract.onAddSuccess();
    } catch (error) {
      debugPrint(error.toString());
      _contract.onAddFail();
    } finally {
      _contract.onEndAsyncTask();
    }
  }

  @override
  Future<void> update() async {
    final presetProduct = await ProductRepository.getOne(item.id!);
    //Check if product's option is different from new _presenter.product.options
    // If different, update
    if (presetProduct != null) {
      // The list of option that had been deleted on UI
      // and will be deleted on server
      final deletedOptionList = (item as Product)
          .options
          .where((element) => presetProduct.options.contains(element));
      // The list of options that had been added on the UI
      // and will added to the product on the server
      final addedOptionList = (item as Product)
          .options
          .where((element) => presetProduct.options.contains(element));
    }
  }

  @override
  Future<void> init() async {
    try {
      _contract.onStartAsyncTask();
      await ProductCategoryRepository.getAll();
      if ((item as Product).id != null) {
        item = await ProductRepository.getOne(item);
      }
      _contract.onEndAsyncTask();
    } catch (error) {
      debugPrint(error.toString());
      _contract.onInitFail();
    }
    _contract.onInitSuccess();
  }

  @override
  Future<void> refresh() async {}
}

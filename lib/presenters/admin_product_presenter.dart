import 'package:flutter/material.dart';
import 'package:precious/data_sources/category_reppsitory.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/product_category/product_category.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/presenters/page_presenter.dart';
import 'package:precious/presenters/page_contract.dart';

abstract class AdminProductContract implements PageContract {
  @override
  void onInitSuccess();
  @override
  void onRefreshSuccess();
  @override
  void onDeleteSuccess();
}

enum ProductSortOption { priceAsc, priceDesc, nameAsc, nameDesc }

List<Product> filterProductList(
    {List<Product> productList = const [],
    String searchString = "",
    List<ProductCategory> selectedCategories = const [],
    ProductSortOption sortOption = ProductSortOption.nameAsc}) {
  List<Product> filteredProductList = [...productList];

  if (searchString.isNotEmpty) {
    filteredProductList = filteredProductList.where((element) {
      return element.name.toLowerCase().contains(searchString.toLowerCase());
    }).toList();
  }
  if (selectedCategories.isNotEmpty) {
    filteredProductList = filteredProductList.where((element) {
      return selectedCategories.any((category) => element.id == category.id);
    }).toList();
  }

  switch (sortOption) {
    case ProductSortOption.priceAsc:
      filteredProductList.sort((a, b) => a.price.compareTo(b.price));
      break;
    case ProductSortOption.priceDesc:
      filteredProductList.sort((a, b) => b.price.compareTo(a.price));
      break;
    case ProductSortOption.nameAsc:
      filteredProductList.sort((a, b) => a.name.compareTo(b.name));
      break;
    case ProductSortOption.nameDesc:
      filteredProductList.sort((a, b) => b.name.compareTo(a.name));
      break;
    default:
      break;
  }
  return filteredProductList;
}

class AdminProductPresenter implements PagePresenter {
  final AdminProductContract _adminProductContract;
  String searchParam = "";
  ProductSortOption sortOption = ProductSortOption.nameAsc;
  List<ProductCategory> selectedCategory = [];
  @override
  List<int> selected = [];
  bool multipleSelection = false;
  AdminProductPresenter(this._adminProductContract);

  List<Product> get productList => filterProductList(
      productList: ProductRepository.list.values.toList(),
      searchString: searchParam,
      sortOption: sortOption,
      selectedCategories: selectedCategory);
  List<ProductCategory> get categoryList =>
      ProductCategoryRepository.list.values.toList();
  @override
  Future<void> init() async {
    _adminProductContract.onStartAsyncTask();
    await Future.wait(
            [ProductRepository.getAll(), ProductCategoryRepository.getAll()])
        .then((value) => _adminProductContract.onInitSuccess());
    debugPrint("Done init");
    _adminProductContract.onEndAsyncTask();
  }

  @override
  Future<void> refresh() async {
    _adminProductContract.onStartAsyncTask();
    selected.clear();
    ProductRepository.reset();
    await Future.wait(
            [ProductRepository.getAll(), ProductCategoryRepository.getAll()])
        .then((value) => _adminProductContract.onRefreshSuccess());
    _adminProductContract.onEndAsyncTask();
  }

  @override
  Future<bool> delete(int id) async {
    _adminProductContract.onStartAsyncTask();
    final response = await ProductRepository.delete(id);
    if (response) {
      _adminProductContract.onDeleteSuccess();
    } else {
      _adminProductContract.onDeleteFail();
    }
    _adminProductContract.onEndAsyncTask();
    return response;
  }

  void select(int i) {
    selected.add(i);
  }

  void deselect(int i) {
    selected.remove(i);
  }
}

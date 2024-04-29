import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_category/product_category.dart';
import 'package:precious/presenters/category_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';
import 'package:precious/resources/widgets/product_card_admin.dart';

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

class ProductPageAdmin extends StatefulWidget {
  const ProductPageAdmin({super.key, this.openFloatingButton, this.onSelected});
  final Function? openFloatingButton;
  final Function? onSelected;

  static ProductPageAdmin fromMap(Map<String, dynamic> param) {
    return ProductPageAdmin(
        openFloatingButton: param['openFloatingButton'],
        onSelected: param['onSelected']);
  }

  @override
  _ProductPageAdminState createState() => _ProductPageAdminState();
}

class _ProductPageAdminState extends State<ProductPageAdmin> {
  late Future<List<Product>> productListFuture;
  late List<Product> productList;
  late Future<List<ProductCategory>> categoryListFuture;
  List<ProductCategory> selectedCategory = [];
  late List<ProductCategory> categoryList;
  final productPresenter = ProductPresenter();
  final categoryPresenter = ProductCategoryPresenter();
  ProductSortOption sortOption = ProductSortOption.nameAsc;
  String searchString = "";

  @override
  void initState() {
    super.initState();
    productListFuture = productPresenter.getAll().then((e) async {
      productList = e;
      return e;
    });
    categoryListFuture = categoryPresenter.getAll().then((value) {
      categoryList = value;
      categoryList.removeAt(0);
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        debugPrint("Refresh");
        ProductPresenter.selectedProduct.clear();
        _configFloatingButton();
        productListFuture = productPresenter.getAll();
        await productListFuture;
        setState(() {});
        return;
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSearchBar(
              onChange: (p0) {
                setState(() {
                  searchString = p0;
                });
              },
            ),
            FutureBuilder(
              future: categoryListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) return const SizedBox.shrink();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        _handleChangeFilter();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              selectedCategory.isEmpty
                                  ? Colors.transparent
                                  : Colors.black)),
                      label: Text(
                        "Filters",
                        style: GoogleFonts.openSans(
                            fontSize: 15,
                            color: selectedCategory.isEmpty
                                ? Colors.black
                                : Colors.white),
                      ),
                      icon: Icon(Icons.tune,
                          size: 15,
                          color: selectedCategory.isEmpty
                              ? Colors.black
                              : Colors.white),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.list_alt_rounded,
                              size: 15,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (sortOption == ProductSortOption.nameAsc) {
                                  sortOption = ProductSortOption.nameDesc;
                                } else {
                                  sortOption = ProductSortOption.nameAsc;
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.swap_vert,
                              size: 15,
                            ))
                      ],
                    )
                  ],
                );
              },
            ),
            FutureBuilder(
                future: productListFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(
                        child: Center(
                      child: Text(snapshot.error.toString()),
                    ));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const Expanded(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }
                  final productList = filterProductList(
                      productList: snapshot.data!,
                      searchString: searchString,
                      sortOption: sortOption,
                      selectedCategories: selectedCategory);
                  return Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: productList
                          .map((e) => Container(
                                margin: const EdgeInsets.only(
                                    top: 5.0, bottom: 3.0),
                                child: ProductCardAdmin(
                                  product: e,
                                  onSelected: (int i) {
                                    _handleSelect(i);
                                  },
                                  onDisSelected: (int i) {
                                    _handleSelect(i);
                                  },
                                ),
                              ))
                          .toList(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  void _handleSelect(int i) {
    if (ProductPresenter.selectedProduct.contains(i)) {
      ProductPresenter.selectedProduct.remove(i);
    } else {
      ProductPresenter.selectedProduct.add(i);
    }
    _configFloatingButton();
  }

  void _configFloatingButton() {
    if (widget.onSelected != null) widget.onSelected!();
    if (widget.openFloatingButton != null) {
      if (ProductPresenter.selectedProduct.length >= 2) {
        widget.openFloatingButton!([0, 1]);
      }
      if (ProductPresenter.selectedProduct.isEmpty) {
        widget.openFloatingButton!([0]);
      }
      if (ProductPresenter.selectedProduct.length == 1) {
        widget.openFloatingButton!([0, 1, 2]);
      }
    }
  }

  void _handleChangeFilter() {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return Dialog(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [Icon(Icons.tune), Text("Filters")],
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      Row(
                        children: [
                          Text("Categories:",
                              style: GoogleFonts.openSans(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Wrap(
                        children: [
                          ...categoryList.map((e) => Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (selectedCategory.contains(e)) {
                                          selectedCategory.remove(e);
                                        } else {
                                          selectedCategory.add(e);
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                selectedCategory.contains(e)
                                                    ? Colors.black
                                                    : Colors.transparent)),
                                    child: Text(e.name,
                                        style: GoogleFonts.openSans(
                                            fontSize: 15,
                                            color: selectedCategory.contains(e)
                                                ? Colors.white
                                                : Colors.black))),
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  onPressed: () {
                                    setState(() {
                                      selectedCategory.clear();
                                    });
                                  },
                                  child: Text(
                                    "Reset",
                                    style: GoogleFonts.openSans(
                                        color: Colors.black),
                                  )),
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)),
                                  child: Text("OK",
                                      style: GoogleFonts.openSans(
                                          color: Colors.white))),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            })).then((value) => setState(() {}));
  }
}

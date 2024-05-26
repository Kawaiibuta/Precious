import 'package:flutter/material.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/product_category/product_category.dart';
import 'package:precious/presenters/category_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/models/type/type.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';
import 'package:precious/resources/widgets/product_card.dart';

List<Product> filterProductList(List<Product> productList, String searchString,
    List<ProductCategory> selectedCategories, SortOption sortOption) {
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
    case SortOption.priceAsc:
      filteredProductList.sort((a, b) => a.price.compareTo(b.price));
      break;
    case SortOption.priceDesc:
      filteredProductList.sort((a, b) => b.price.compareTo(a.price));
      break;
    case SortOption.nameAsc:
      filteredProductList.sort((a, b) => a.name.compareTo(b.name));
      break;
    case SortOption.nameDesc:
      filteredProductList.sort((a, b) => b.name.compareTo(a.name));
      break;
    default:
      break;
  }
  return filteredProductList;
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key});
  static const name = "/searchPage";
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchString = "";
  List<ProductCategory> selectedCategories = [];
  SortOption sortOption = SortOption.none;

  late Future<List<Product>> productListFuture;
  late Future<List<Type>> typeListFuture;
  late Future<List<ProductCategory>> categoryListFuture;

  ProductPresenter productPresenter = ProductPresenter();
  ProductCategoryPresenter categoryPresenter = ProductCategoryPresenter();

  final _controller = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    productListFuture = productPresenter.getAll();
    categoryListFuture = categoryPresenter.getAll();

    WidgetsBinding.instance.addPostFrameCallback((duration) {
      // Setup the listener.
      _controller.addListener(() {
        if (_controller.position.atEdge) {
          bool isTop = _controller.position.pixels == 0;
          if (!isTop) {
            productListFuture = productPresenter.getAll(more: true);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: CustomSearchBar(
          onChange: (value) {
            setState(() {
              searchString = value;
            });
          },
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(left: 10, top: 10),
          children: [
            const Text('Filter by Category',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            FutureBuilder(
                future: categoryListFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                  final categoryList = snapshot.data!;
                  return Column(
                    children: [
                      ...categoryList.map((e) => CheckboxListTile(
                            title: Text(e.name),
                            value: selectedCategories.contains(e),
                            onChanged: (value) {
                              setState(() {
                                if (value!) {
                                  selectedCategories.add(e);
                                } else {
                                  selectedCategories.remove(e);
                                }
                              });
                            },
                          ))
                    ],
                  );
                }),
            const Text('Sort by',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            DropdownButton<SortOption>(
              value: sortOption,
              items: [
                DropdownMenuItem(
                  value: SortOption.none,
                  child: Text(AppLocalizations.of(context)!.none_option),
                ),
                DropdownMenuItem(
                  value: SortOption.priceAsc,
                  child: Text(AppLocalizations.of(context)!.price_low_to_high_option),
                ),
                DropdownMenuItem(
                  value: SortOption.priceDesc,
                  child: Text(AppLocalizations.of(context)!.price_high_to_low_option),
                ),
                DropdownMenuItem(
                  value: SortOption.nameAsc,
                  child: Text(AppLocalizations.of(context)!.name_a_to_z_option),
                ),
                DropdownMenuItem(
                  value: SortOption.nameDesc,
                  child: Text(AppLocalizations.of(context)!.name_z_to_a_option),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  sortOption = value!;
                });
              },
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Expanded(
          child: FutureBuilder(
            future: productListFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
              List<Product> productList = snapshot.data!;
              return GridView.count(
                primary: false,
                crossAxisSpacing: 5,
                mainAxisSpacing: 100,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: <Widget>[
                  ...filterProductList(productList, searchString,
                          selectedCategories, sortOption)
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ProductCard(
                              product: e,
                            ),
                          ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

enum SortOption {
  none, priceAsc, priceDesc, nameAsc, nameDesc
}

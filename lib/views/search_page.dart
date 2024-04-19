import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/product_category/product_category.dart';
import 'package:precious/presenters/category_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/presenters/type_presenter.dart';
import 'package:precious/models/type/type.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';
import 'package:precious/resources/widgets/product_card.dart';

List<Product> filterProductList(List<Product> productList, String searchString,
    List<ProductCategory> selectedCategories, String sortOption) {
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
    case 'price-asc':
      filteredProductList.sort((a, b) => a.price.compareTo(b.price));
      break;
    case 'price-desc':
      filteredProductList.sort((a, b) => b.price.compareTo(a.price));
      break;
    case 'name-asc':
      filteredProductList.sort((a, b) => a.name.compareTo(b.name));
      break;
    case 'name-desc':
      filteredProductList.sort((a, b) => b.name.compareTo(a.name));
      break;
    default:
      break;
  }
  return filteredProductList;
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchString = "";
  List<ProductCategory> selectedCategories = [];
  String sortOption = 'none';

  late Future<List<Product>> productListFuture;
  late Future<List<Type>> typeListFuture;
  late Future<List<ProductCategory>> categoryListFuture;

  ProductPresenter productPresenter = ProductPresenter();
  TypePresenter typePresenter = TypePresenter();
  ProductCategoryPresenter categoryPresenter = ProductCategoryPresenter();

  final _controller = ScrollController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    productListFuture = productPresenter.getAll();
    categoryListFuture = categoryPresenter.getAll();
    typeListFuture = typePresenter.getAll();

    WidgetsBinding.instance!.addPostFrameCallback((duration) {
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
            DropdownButton<String>(
              value: sortOption,
              items: const [
                DropdownMenuItem(
                  child: Text('None'),
                  value: 'none',
                ),
                DropdownMenuItem(
                  child: Text('Price Low to High'),
                  value: 'price-asc',
                ),
                DropdownMenuItem(
                  child: Text('Price High to Low'),
                  value: 'price-desc',
                ),
                DropdownMenuItem(
                  child: Text('Name A-Z'),
                  value: 'name-asc',
                ),
                DropdownMenuItem(
                  child: Text('Name Z-A'),
                  value: 'name-desc',
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

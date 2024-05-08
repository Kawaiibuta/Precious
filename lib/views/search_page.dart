import 'package:flutter/material.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_category/product_category.dart';
import 'package:precious/presenters/category_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/presenters/type_presenter.dart';
import 'package:precious/data_sources/type/type.dart';
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
  static const name = "search_page";
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    productListFuture = productPresenter.getAll();
    categoryListFuture = categoryPresenter.getAll();
    typeListFuture = typePresenter.getAll();

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
        title: Hero(
          tag: "search_bar",
          child: CustomSearchBar(
            onChange: (value) {
              setState(() {
                searchString = value;
              });
            },
          ),
        ),
        toolbarHeight: 80, // Add this line to set the height of the AppBar
        elevation: 0, // Add this line to remove the shadow of the AppBar
        backgroundColor:
            Colors.transparent, // Add this line to make the AppBar transparent
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
              padding: const EdgeInsets.only(left: 20, right: 20),
              value: sortOption,
              style: const TextStyle(
                  color: Color.fromARGB(255, 43, 43, 43), fontSize: 16),
              items: const [
                DropdownMenuItem(
                  value: 'none',
                  child: Text('None'),
                ),
                DropdownMenuItem(
                  value: 'price-asc',
                  child: Text('Price Low to High'),
                ),
                DropdownMenuItem(
                  value: 'price-desc',
                  child: Text('Price High to Low'),
                ),
                DropdownMenuItem(
                  value: 'name-asc',
                  child: Text('Name A-Z'),
                ),
                DropdownMenuItem(
                  value: 'name-desc',
                  child: Text('Name Z-A'),
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
      body: FutureBuilder(
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
            padding: const EdgeInsets.only(bottom: 100),
            crossAxisSpacing: 5,
            mainAxisSpacing: 100,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: <Widget>[
              ...filterProductList(
                      productList, searchString, selectedCategories, sortOption)
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
    );
  }
}

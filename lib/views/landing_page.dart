import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_category/product_category.dart';
import 'package:precious/presenters/category_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/resources/widgets/catagory_button.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';
import 'package:precious/resources/widgets/product_card.dart';
import 'package:precious/resources/widgets/sale_banner.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, this.changePage});
  static const name = '/landingPage';
  final Function? changePage;
  @override
  _LandingPageState createState() => _LandingPageState();
}

const newArriveProductList = [
  {
    "name": "the Marc Jacob",
    "type": "Traveler tots",
    "price": 128.00,
    'url': 'assets/images/sale.jpg'
  },
  {
    "name": "Axel Arigato",
    "type": "Clean 90 Triple Sneakers",
    "price": 245.00,
    'url': 'assets/images/sale.jpg'
  },
  {
    "name": "the Marc Jacob",
    "type": "Traveler tots",
    "price": 128.00,
    'url': 'assets/images/sale.jpg'
  },
  {
    "name": "Axel Arigato",
    "type": "Clean 90 Triple Sneakers",
    "price": 245.00,
    'url': 'assets/images/sale.jpg'
  },
  {
    "name": "the Marc Jacob",
    "type": "Traveler tots",
    "price": 128.00,
    'url': 'assets/images/sale.jpg'
  },
  {
    "name": "Axel Arigato",
    "type": "Clean 90 Triple Sneakers",
    "price": 245.00,
    'url': 'assets/images/sale.jpg'
  },
];

class _LandingPageState extends State<LandingPage> {
  int categoriesSelected = 0;
  late Future<List<Product>> productListFuture;
  late Future<List<ProductCategory>> categoryListFuture;
  ProductPresenter productPresenter = ProductPresenter();
  ProductCategoryPresenter categoryPresenter = ProductCategoryPresenter();
  @override
  void initState() {
    super.initState();
    setState(() {
      productListFuture = productPresenter.getAll();
      categoryListFuture = categoryPresenter.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: productListFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          final productList = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Welcome,',
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Enjoy your shopping",
                      style: GoogleFonts.openSans(
                          fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomSearchBar(
                  onFocus: () {
                    debugPrint(widget.changePage.toString());
                    if (widget.changePage != null) widget.changePage!(1);
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                // Sale banner row
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: SaleBanner(
                          title: "50% Sale",
                          color: Colors.white,
                          image: AssetImage('assets/images/sale.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: SaleBanner(
                          title: "50% Sale",
                          color: Colors.white,
                          image: AssetImage('assets/images/sale.png'),
                        ),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                    future: categoryListFuture,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        debugPrint(snapshot.hasError.toString());
                        return const SizedBox.shrink();
                      }
                      var categoryList = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: categoryList
                                  .asMap()
                                  .map((i, e) => MapEntry(
                                        i,
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: CategoryButton(
                                            title: e.name,
                                            selected: (i == categoriesSelected),
                                            onClick: () => setState(() {
                                              categoriesSelected = i;
                                            }),
                                          ),
                                        ),
                                      ))
                                  .values
                                  .toList()),
                        ),
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "New Arrivals",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "View all",
                          style: TextStyle(fontSize: 10.0),
                        ))
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: newArriveProductList
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ProductCard(
                                    name: e['name'] as String,
                                    type: e['type'] as String,
                                    price: e['price'] as double,
                                    url: e['url'] as String),
                              ))
                          .toList()),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Popular",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "View all",
                          style: TextStyle(fontSize: 10.0),
                        ))
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: newArriveProductList
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ProductCard(
                                    name: e['name'] as String,
                                    type: e['type'] as String,
                                    price: e['price'] as double,
                                    url: e['url'] as String),
                              ))
                          .toList()),
                ),
                const Text("Discovery",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                GridView.count(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 100,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: <Widget>[
                    ...productList
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ProductCard(
                                  name: e.name,
                                  type: e.short_description,
                                  price: e.price,
                                  url: e.img_paths_url[0]),
                            ))
                        .toList()
                  ],
                )
              ],
            ),
          );
        });
  }
}

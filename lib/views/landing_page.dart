import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/type/type.dart';
import 'package:precious/data_sources/product_category/product_category.dart';
import 'package:precious/presenters/category_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/presenters/type_presenter.dart';
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

class _LandingPageState extends State<LandingPage> {
  int categoriesSelected = 0;
  late Future<List<Product>> productListFuture;
  late Future<List<Type>> typeListFuture;
  late Future<List<ProductCategory>> categoryListFuture;

  ProductPresenter productPresenter = ProductPresenter();
  TypePresenter typePresenter = TypePresenter();
  ProductCategoryPresenter categoryPresenter = ProductCategoryPresenter();

  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    productListFuture = productPresenter.getAll();
    categoryListFuture = categoryPresenter.getAll();
    typeListFuture = typePresenter
        .getAll()
        .then((value) => typePresenter.getProductByType(value));
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
            controller: _controller,
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
                FutureBuilder(
                  future: typeListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data == null) return const Text("Error");
                    final typeList = snapshot.data!;
                    debugPrint(typeList.toString());
                    List<Widget> widgetList = [];
                    typeList.map((type) {
                      return [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              type.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "View all",
                                  style: TextStyle(fontSize: 10.0),
                                ))
                          ],
                        ),
                        FutureBuilder(
                          future: typePresenter.getProductByType(type.id!),
                          builder: (context, typeSnapshot) {
                            if (typeSnapshot.connectionState ==
                                    ConnectionState.waiting ||
                                !typeSnapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final productTypeList = typeSnapshot.data!;
                            debugPrint(productTypeList.toString());
                            return Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: productTypeList
                                          .map((e) => Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: ProductCard(
                                                  product: e,
                                                ),
                                              ))
                                          .toList()),
                                ),
                              ],
                            );
                          },
                        )
                      ];
                    });
                    return Row(
                      children: [Column(children: widgetList)],
                    );
                  },
                ),

                const Text("Discovery",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
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
                                product: e,
                              ),
                            ))
                        .toList()
                  ],
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          );
        });
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/product_category/product_category.dart';
import 'package:precious/models/type/type.dart';
import 'package:precious/presenters/category_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/catagory_button.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';
import 'package:precious/resources/widgets/product_card.dart';
import 'package:precious/resources/widgets/sale_banner.dart';
import 'package:precious/views/search_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, this.changePage});
  static const name = '/landingPage';
  final Function? changePage;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int categoriesSelected = -1;
  //late Future<List<Product>> getMoreProductFuture;
  List<Type> typeList = [];
  List<Product> productList = [];
  late Future<List<ProductCategory>> categoryListFuture;
  Map<int, Future<List<Product>>> productByType = {};
  ProductPresenter productPresenter = ProductPresenter();
  ProductCategoryPresenter categoryPresenter = ProductCategoryPresenter();

  bool _loadMore = true;

  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    initialize();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      // Setup the listener.
      _controller.addListener(() {
        if (_controller.position.atEdge) {
          bool isTop = _controller.position.pixels == 0;
          if (!isTop) {
            getMoreProduct(true);
            setState(() {
              _loadMore = true;
            });
          }
        }
      });
    });
  }

  void initialize() {
    if (productList.isEmpty) {
      getMoreProduct(false);
    }
    categoriesSelected = -1;
    categoryListFuture = categoryPresenter.getAll();
  }

  Future<void> reload() async {
    initialize();
  }

  Future<void> getMoreProduct(bool more) async {
    if (!more) {
      productList.clear();
      ProductPresenter.productList.clear();
    }
    productPresenter
        .getAll(more: more, categoryId: categoriesSelected)
        .then((value) => setState(() {
              _loadMore = false;
              productList.addAll(value);
            }))
        .catchError((e) => onLoadError(e));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: reload,
      child: Scaffold(
        body: SingleChildScrollView(
          controller: _controller,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30.v,
              ),
              Row(
                children: [
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Enjoy your shopping",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Hero(
                tag: "search_bar",
                child: CustomSearchBar(
                  onFocus: () {
                    Navigator.of(context).pushNamed(SearchPage.name);
                  },
                ),
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
              SizedBox(height: 20.v),
              Text("Discovery",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer)),
              // ...typeList.map((type) {
              //   return Column(children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           type.name,
              //           style: const TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 17),
              //         ),
              //         TextButton(
              //             onPressed: () {},
              //             child: const Text(
              //               "View all",
              //               style: TextStyle(fontSize: 10.0),
              //             ))
              //       ],
              //     ),

              //     FutureBuilder(
              //         future: productByType[type.id],
              //         builder: (context, snapshot) {
              //           if (snapshot.hasError)
              //             return Text(snapshot.error.toString());
              //           if (!snapshot.hasData) {
              //             return const CircularProgressIndicator.adaptive();
              //           }
              //           final products = snapshot.data!;
              //           return Column(
              //             children: [
              //               SingleChildScrollView(
              //                 scrollDirection: Axis.horizontal,
              //                 child: Row(
              //                     children: products
              //                         .map((e) => Padding(
              //                               padding: const EdgeInsets.only(
              //                                   right: 8.0),
              //                               child: ProductCard(
              //                                 product: e,
              //                               ),
              //                             ))
              //                         .toList()),
              //               ),
              //             ],
              //           );
              //         })
              //     // : const SizedBox.shrink(),
              //   ]);
              // }),

              FutureBuilder(
                  future: categoryListFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      debugPrint(snapshot.hasError.toString());
                      return const SizedBox.shrink();
                    }
                    var categoryList = snapshot.data!;
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.v),
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
                                          selected:
                                              (categoriesSelected == e.id),
                                          onClick: () => setState(() {
                                            categoriesSelected = e.id!;
                                            _loadMore = true;
                                            getMoreProduct(false);
                                          }),
                                        ),
                                      ),
                                    ))
                                .values
                                .toList()),
                      ),
                    );
                  }),
              GridView.count(
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 5,
                mainAxisSpacing: 50,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: <Widget>[
                  ...productList.map((e) => ProductCard(
                        product: e,
                      )),
                ],
              ),
              // Load more
              if (_loadMore) ...[
                SizedBox(height: 20.v),
                SizedBox(
                    width: 48.h,
                    height: 48.v,
                    child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onBackground)),
              ],
              SizedBox(
                height: 90.v,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onLoadError(e) {
    String? msg;
    if (e is DioException) {
      msg = e.response?.statusMessage;
    } else if (e is Exception) {
      msg = e.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!
            .unexpected_error_msg(msg ?? 'UNKNOWN'))));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
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

const categoryList = [
  {
    "icon": Icons.add_shopping_cart_outlined,
    "title": 'New Arrivals',
    "quantity": 120,
  },
  {
    "icon": Icons.add_shopping_cart_outlined,
    "title": 'New Arrivals',
    "quantity": 120,
  },
  {
    "icon": Icons.add_shopping_cart_outlined,
    "title": 'New Arrivals',
    "quantity": 120,
  },
  {
    "icon": Icons.add_shopping_cart_outlined,
    "title": 'New Arrivals',
    "quantity": 120,
  },
  {
    "icon": Icons.add_shopping_cart_outlined,
    "title": 'New Arrivals',
    "quantity": 120,
  },
];

class _LandingPageState extends State<LandingPage> {
  int categoriesSelected = 0;
  @override
  Widget build(BuildContext context) {
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
                style: GoogleFonts.openSans(fontSize: 15, color: Colors.grey),
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
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: categoryList
                      .asMap()
                      .map((i, e) => MapEntry(
                            i,
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CategoryButton(
                                title: e['title'] as String,
                                selected: (i == categoriesSelected),
                              ),
                            ),
                          ))
                      .values
                      .toList()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "New Arrivals",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
          Text("New and Popular",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          GridView.count(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 5,
            mainAxisSpacing: 100,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: <Widget>[
              ...newArriveProductList
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ProductCard(
                            name: e['name'] as String,
                            type: e['type'] as String,
                            price: e['price'] as double,
                            url: e['url'] as String),
                      ))
                  .toList()
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:precious/resources/widgets/catagory_button.dart';
import 'package:precious/resources/widgets/product_card.dart';
import 'package:precious/resources/widgets/sale_banner.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

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
  bool categoriesSelected = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Utility row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          categoriesSelected = true;
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      icon: const Icon(Icons.list, color: Colors.white)),
                  IconButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      icon: const Icon(Icons.person, color: Colors.white)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Sale banner row
              const Row(
                children: [
                  SaleBanner(
                    title: "50% Sale",
                    color: Colors.white,
                    image: AssetImage('assets/images/sale.png'),
                  )
                ],
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
            ],
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 1000),
          right: categoriesSelected ? -10 : MediaQuery.of(context).size.width,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                  child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          categoriesSelected = false;
                        });
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    )
                  ],
                ),
                ...categoryList.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CatagoryButton(
                          icon: e['icon'] as IconData,
                          title: e['title'] as String,
                          quantity: e['quantity'] as int),
                    )),
              ])),
            ),
          ),
        ),
      ],
    );
  }
}

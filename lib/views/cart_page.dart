import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/cart_item.dart';

const cartList = [
  {
    "date": "11/03/2024",
    "items": [
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
    ]
  },
  {
    "date": "11/03/2024",
    "items": [
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
    ]
  },
  {
    "date": "11/03/2024",
    "items": [
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
      {
        "image": "assets/images/necklace.jpg",
        "quantity": 3.0,
        "name": "Necklace"
      },
    ]
  }
];

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var selected = List<List<bool>>.generate(
      cartList.length,
      (index) => List.generate(
          (cartList[index]['items'] as List).length, (index) => false));
  var selectedQuantity = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                      Text(
                        AppLocalizations.of(context)!.my_cart,
                        style: GoogleFonts.openSans(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          selected = List<List<bool>>.generate(
                              cartList.length,
                              (index) => List.generate(
                                  (cartList[index]['items'] as List).length,
                                  (index) => false));
                          selectedQuantity = 0;
                        });
                      },
                      icon: Icon(Icons.deselect))
                ],
              ),
              ...cartList
                  .asMap()
                  .map((key0, value) => MapEntry(
                      key0,
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(value["date"].toString()),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedQuantity += selected[key0].length;
                                      selected[key0] = List<bool>.generate(
                                          selected[key0].length,
                                          (index) => true);
                                    });
                                  },
                                  child: const Text(
                                    "select all",
                                    style: TextStyle(fontSize: 10),
                                  ))
                            ],
                          ),
                          ...(value['items'] as List<dynamic>)
                              .asMap()
                              .map(
                                (key1, item) => MapEntry(
                                    key1,
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: CartItem(
                                        backgroundImage:
                                            AssetImage(item['image']),
                                        name: item['name'],
                                        quantity: item['quantity'] as double,
                                        selected: selected[key0][key1],
                                        onTap: () {
                                          setState(() {
                                            if (selected[key0][key1]) {
                                              selectedQuantity -= 1;
                                            } else {
                                              selectedQuantity += 1;
                                            }
                                            selected[key0][key1] =
                                                !selected[key0][key1];
                                          });
                                        },
                                        maxQuantity: 10.0,
                                      ),
                                    )),
                              )
                              .values
                              .toList()
                        ],
                      )))
                  .values
                  .toList()
            ],
          ),
        ),
        Positioned(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: selectedQuantity > 0 ? 1.0 : 0.0,
            child: Container(
              height: 60,
              width: double.infinity,
              child: FittedBox(
                child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () {},
                    child: const Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ))
      ],
    );
  }
}

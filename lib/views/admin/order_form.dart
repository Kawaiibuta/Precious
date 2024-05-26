import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:precious/models/option/optionValue/option_value.dart';
import 'package:precious/data_sources/order_repository.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/models/user/user.dart';
import 'package:precious/data_sources/user_repository.dart';
import 'package:precious/models/variant/variant.dart';
import 'package:precious/presenters/order_form_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/utils/utils.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({Key? key}) : super(key: key);
  static const name = "order_form";
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> implements OrderFormContract {
  late OrderFormPresenter _presenter;
  var loading = false;
  @override
  void initState() {
    super.initState();
    _presenter = OrderFormPresenter(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Order",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (loading)
                const Center(child: CircularProgressIndicator())
              else if (_presenter.user == null)
                const Center(
                  child: Text("Ops, something wrong has happened"),
                )
              else
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  margin: EdgeInsets.symmetric(horizontal: 20.h),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          width: 50.h,
                                          height: 50.h,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle),
                                          clipBehavior: Clip.antiAlias,
                                          child: _presenter.user != null &&
                                                  _presenter.user!.avatarUrl !=
                                                      null
                                              ? SvgPicture.network(
                                                  _presenter.user!.avatarUrl!)
                                              : const Icon(Icons.person)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _presenter.user!.id.toString(),
                                          style: GoogleFonts.openSans(
                                              fontSize: 30.0.h,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: _handleChangeUser,
                                    icon: const Icon(Icons.person_add_alt_1),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Tuổi"),
                                    Text((_presenter.user!.age ?? "Unknown")
                                        .toString()),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Email"),
                                    Text((_presenter.user!.email ?? "Unknown")
                                        .toString()),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50.h,
                        width: double.infinity,
                        color: Colors.black,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Contact",
                            style: GoogleFonts.openSans(
                                fontSize: 20.h,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: 20.0.h),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    margin: EdgeInsets.symmetric(horizontal: 20.h),
                    padding: EdgeInsets.all(10.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Order detail",
                                style: GoogleFonts.openSans(
                                    fontSize: 20.0.h,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            ..._presenter.variants.keys.map((e) => OrderedItem(
                                  variant: e,
                                  onQuantityChange: (value) =>
                                      _presenter.variants[e] = value,
                                  onDelete: (Variant value) => setState(() {
                                    _presenter.variants.remove(value);
                                  }),
                                )),
                            IconButton(
                                onPressed: () {
                                  _handleShowAddProductDialog();
                                },
                                icon: const Icon(Icons.add))
                          ],
                        )
                      ],
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                padding: EdgeInsets.all(10.h),
                margin: EdgeInsets.all(20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Payment method",
                            style: GoogleFonts.openSans(
                                fontSize: 20.0.h, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    PaymentMethodItem(
                        label: "Cash",
                        icon: const Icon(Icons.money_sharp),
                        selectedMethod: _presenter.method,
                        method: PaymentMethod.cash,
                        onChange: (value) => setState(() {
                              _presenter.method = value;
                            })),
                    PaymentMethodItem(
                        label: "Momo",
                        icon: Image.asset("assets/images/momo.png",
                            width: 20.h, height: 20.h),
                        method: PaymentMethod.momo,
                        selectedMethod: _presenter.method,
                        onChange: (value) => setState(() {
                              _presenter.method = value;
                            })),
                    PaymentMethodItem(
                        label: "Cash on delivery",
                        icon: const Icon(Icons.delivery_dining_outlined),
                        method: PaymentMethod.onDelivery,
                        selectedMethod: _presenter.method,
                        onChange: (value) => setState(() {
                              _presenter.method = value;
                            }))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                padding: EdgeInsets.all(10.h),
                margin: EdgeInsets.all(20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Order information",
                            style: GoogleFonts.openSans(
                                fontSize: 20.0.h, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: TextFormField(
                        controller: _presenter.addressController,
                        maxLines: null,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          label: Text("Address"),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          hintText: 'The location of shipment',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: TextFormField(
                        controller: _presenter.phoneController,
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          label: Text("Phone number"),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          hintText: 'The location of shipment',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () => _presenter.add(),
                  child: Container(
                    height: 60.h,
                    margin: EdgeInsets.symmetric(horizontal: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.h),
                      color: Colors.black,
                    ),
                    child: Center(
                        child: Text("Process",
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 20.h))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _handleChangeUser() async {
    final userList = UserRepository.list.values.toList();
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const CustomSearchBar(),
              content: SizedBox(
                height: 200..h,
                child: ListView.builder(
                  itemCount: UserRepository.list.values.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _presenter.changeUser(userList[index]);
                        });
                        Navigator.of(context).pop(_presenter.user);
                      },
                      child: Column(
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40.h,
                                  height: 40.h,
                                  margin: EdgeInsets.only(right: 10.h),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  clipBehavior: Clip.antiAlias,
                                  child: userList[index].avatarUrl != null
                                      ? SvgPicture.network(
                                          userList[index].avatarUrl!)
                                      : const Icon(Icons.person),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Id: ${userList[index].id!}"),
                                    Text(
                                        "Email: ${userList[index].email ?? "Chưa xác định"}"),
                                  ],
                                )
                              ]),
                          const Divider(
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )).then((value) => (value ?? _presenter.user) as User);
    setState(() {});
  }

  @override
  onAddFail() {}

  @override
  onAddSuccess() {
    const snackBar = SnackBar(
      content: Text('The order has been placed.'),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  onEndAsyncFunction() {
    Get.back();
  }

  @override
  onInitFail() {
    Get.snackbar("Error", "Some error has happened.",
        backgroundColor: Colors.white);
    Get.back();
  }

  @override
  onInitSuccess() {
    setState(() {});
  }

  @override
  onResetFail() {
    Get.snackbar("Error", "Some error has happened.",
        backgroundColor: Colors.white);
    Get.back();
  }

  @override
  onResetSuccess() {
    setState(() {});
  }

  @override
  onStartAsyncFunction() {
    Get.dialog(const Center(child: CircularProgressIndicator()));
  }

  void _handleShowAddProductDialog() {
    Product? selectedProduct;
    List<OptionValue> optionList = [];
    int quantity = 1;
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20.0.h),
                        child: const Text("Product:"),
                      ),
                      Flexible(
                        child: DropdownSearch<Product>(
                          itemAsString: (Product u) => u.id!.toString(),
                          items: ProductRepository.list.values.toList(),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "Search product list here",
                            ),
                          ),
                          onChanged: (value) async {
                            if (value != null) {
                              final result = await ProductRepository.getOne(
                                  value.id!,
                                  detail: true);
                              setState(() {
                                selectedProduct = result;
                                if (selectedProduct != null) {
                                  optionList = result!.options
                                      .map((e) => e.values.first)
                                      .toList();
                                }
                                debugPrint(selectedProduct.toString());
                              });
                            }
                          },
                        ),
                      ),
                    ]),
                    if (selectedProduct != null)
                      OptionSelectWidget(product: selectedProduct!),
                    if (selectedProduct != null)
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.only(right: 30.0.h),
                          child: const Text("Quantity"),
                        ),
                        Flexible(
                            child: TextFormField(
                          initialValue: quantity.toString(),
                          onChanged: (value) => setState(() {
                            quantity = int.parse(value);
                          }),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(),
                        ))
                      ]),
                    if (selectedProduct != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextButton(
                          onPressed: () {
                            final variant =
                                getVariant(selectedProduct!, optionList);
                            Navigator.of(context)
                                .pop(<Variant, int>{variant: quantity}.entries);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          child: Text(
                            "Add product",
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )).then((value) => setState(() {
          if (_presenter.variants.containsKey(
              (value as Iterable<MapEntry<Variant, int>>).first.key)) {
            _presenter.variants.update(
                value.first.key, (element) => element + value.first.value);
          } else {
            _presenter.variants.addEntries(value);
          }
        }));
  }

  @override
  onMissingField() {
    Get.snackbar(
        "Fill the form", "Some fields are not filled or filled incorrectly.",
        backgroundColor: Colors.white);
  }
}

class PaymentMethodItem extends StatelessWidget {
  final String label;
  final Widget icon;
  final PaymentMethod method;
  final PaymentMethod selectedMethod;
  final Function(PaymentMethod value)? onChange;
  const PaymentMethodItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.method,
      this.onChange,
      required this.selectedMethod});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(label),
          )
        ],
      ),
      leading: Radio<PaymentMethod>(
        value: method,
        groupValue: selectedMethod,
        onChanged: (PaymentMethod? value) {
          if (onChange != null && value != null) onChange!(value);
        },
      ),
    );
  }
}

class OrderedItem extends StatefulWidget {
  const OrderedItem(
      {super.key,
      required this.variant,
      this.onQuantityChange,
      this.onDelete,
      this.onEdit});
  final Variant variant;
  final Function(int value)? onQuantityChange;
  final Function(Variant value)? onDelete;
  final Function(Variant value)? onEdit;
  @override
  _OrderedItemState createState() => _OrderedItemState();
}

class _OrderedItemState extends State<OrderedItem> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110.h,
          height: 100.h,
          margin: EdgeInsets.only(right: 10.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.h)),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: widget.variant.imgPathUrls[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${widget.variant.name}"),
              Text("Price: ${widget.variant.price}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Options: ${widget.variant.variantOptionValues!.map((e) => e.optionValue.value).join(", ")}"),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (widget.onDelete != null) {
                            widget.onDelete!(widget.variant);
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                        )),
                    Flexible(
                      child: CartStepperInt(
                        value: quantity,
                        size: 30,
                        style: CartStepperStyle(
                          activeForegroundColor: Colors.black,
                          activeBackgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: BoxShape.rectangle,
                          iconPlus: Icons.add,
                          iconMinus: Icons.remove,
                          border: Border.all(),
                          radius: const Radius.circular(10000),
                        ),
                        didChangeCount: (count) {
                          setState(() {
                            quantity = count;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OptionSelectWidget extends StatelessWidget {
  const OptionSelectWidget({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...product.options.map((e) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${e.name}: ",
                    style: GoogleFonts.openSans(
                        fontSize: 15.h,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                  DropdownMenu<OptionValue>(
                    initialSelection: e.values.first,
                    onSelected: (OptionValue? value) {
                      // This is called when the user selects an item.
                    },
                    dropdownMenuEntries:
                        e.values.map<DropdownMenuEntry<OptionValue>>((value) {
                      return DropdownMenuEntry<OptionValue>(
                          value: value, label: value.value);
                    }).toList(),
                  )
                ]),
          ))
    ]);
  }
}

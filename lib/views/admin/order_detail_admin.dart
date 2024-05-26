import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/models/order/order.dart';
import 'package:precious/data_sources/order_repository.dart';
import 'package:precious/presenters/order_detail_presenter.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailAdmin extends StatefulWidget {
  const OrderDetailAdmin({super.key, required this.order});
  final Order order;
  @override
  _OrderDetailAdminState createState() => _OrderDetailAdminState();
}

class _OrderDetailAdminState extends State<OrderDetailAdmin>
    implements OrderDetailContract {
  OrderDetailPresenter? _presenter;

  bool loading = true;
  bool error = false;
  @override
  void initState() {
    super.initState();
    _presenter = OrderDetailPresenter(widget.order, contract: this);
    _presenter!.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Order detail",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
      ),
      body: SafeArea(
        child: _presenter == null || loading || error
            ? Center(
                child: error
                    ? const Text("Some error has happened.")
                    : const CircularProgressIndicator())
            : Stack(
                children: [
                  Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                          margin: EdgeInsets.symmetric(horizontal: 20.h),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.attach_money,
                                          color: Colors.green.shade900,
                                          size: 50.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "+${_presenter!.order.totalPrice}",
                                            style: GoogleFonts.openSans(
                                                fontSize: 30.0.h,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Tình trạng"),
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.h),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            200),
                                                    color: getStatusColor(
                                                        _presenter!
                                                            .order.status)),
                                                child: Text(
                                                    _presenter!.order.status)),
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Thời gian"),
                                            Text(_presenter!.order.createAt
                                                .toString()),
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Mã đơn hàng"),
                                            Text((_presenter!.order.id)
                                                .toString()),
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Số lượng sản phầm"),
                                            Text(_presenter!.order.items
                                                .map((e) => e.quantity)
                                                .reduce((value, element) =>
                                                    value + element)
                                                .toString()),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              if (!_presenter!.order.isPaid)
                                Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  color: Colors.black,
                                  child: TextButton(
                                    onPressed: () => _handleCheckout(),
                                    child: Text(
                                      "Thanh toán",
                                      style: GoogleFonts.openSans(
                                          fontSize: 20.h,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0.h),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            margin: EdgeInsets.symmetric(horizontal: 20.h),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 50.h,
                                        height: 50.h,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        clipBehavior: Clip.antiAlias,
                                        child: _presenter!.user != null &&
                                                _presenter!.user!.avatar_url !=
                                                    null
                                            ? SvgPicture.network(
                                                _presenter!.user!.avatar_url!)
                                            : const Icon(Icons.person),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _presenter!.user!.id.toString(),
                                          style: GoogleFonts.openSans(
                                              fontSize: 30.0.h,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
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
                                        Text(
                                            (_presenter!.user!.age ?? "Unknown")
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
                                        Text((_presenter!.user!.email ??
                                                "Unknown")
                                            .toString()),
                                      ]),
                                ),
                                Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  color: Colors.black,
                                  child: TextButton(
                                    onPressed: () {
                                      _presenter!.contactUser();
                                    },
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
                            )),
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
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Row(
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
                                ),
                                FutureBuilder(
                                  future: buildOrderedItem(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: SizedBox(
                                              width: 20.h,
                                              height: 20.h,
                                              child:
                                                  const CircularProgressIndicator()));
                                    }
                                    if (snapshot.hasError) {
                                      debugPrint(snapshot.error.toString());
                                      return const Center(
                                        child: Text(
                                            "Opss, something wrong has happened"),
                                      );
                                    }
                                    return Column(
                                      children: snapshot.data!,
                                    );
                                  },
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                  if (_presenter!.order.status == "PENDING" ||
                      _presenter!.order.status == "PROCESSING")
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: OutlinedButton(
                          onPressed: () {
                            if (_presenter!.order.status == "PENDING") {
                              _presenter!.update(OrderStatus.PROCESSING);
                            } else {
                              _presenter!.update(OrderStatus.COMPLETED);
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0.h))),
                          ),
                          child: Text(
                            "${_presenter!.order.status == "PENDING" ? "Accept" : "Complete"} order",
                            style: GoogleFonts.openSans(
                                fontSize: 16.h,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                ],
              ),
      ),
    );
  }

  Future<List<Widget>> buildOrderedItem() async {
    final productPresenter = ProductPresenter();
    var result = <Widget>[];
    for (var item in _presenter!.order.items) {
      final product = await productPresenter.getOne(item.id!, detail: true);
      result.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100.h,
            height: 70.h,
            margin: EdgeInsets.only(right: 10.h),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.h)),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(imageUrl: product!.imgPathUrls[0]),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${product.name}"),
                Text("Variant: ${item.variantId}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.price.toString()),
                    Text("Quantity: ${item.quantity}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        child: Text(
                          "Kiểm tra kho hàng",
                          style: TextStyle(fontSize: 15.h),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ));
    }
    return result;
  }

  _handleCheckout() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Payment"),
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        OrderRepository.pay(
                                _presenter!.order.id!, PaymentMethod.cash)
                            .then((value) => launchUrl(Uri.parse(value)));
                      },
                      icon: Image.asset(
                        "assets/images/momo.png",
                        width: 50.h,
                        height: 50.h,
                      ),
                      label: Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: const Text("Pay through Momo."),
                      )),
                  TextButton.icon(
                      onPressed: () {
                        _presenter!.updateIsPaid(true);
                        Get.back();
                      },
                      icon: Image.asset(
                        "assets/images/payed_icon.png",
                        width: 50.h,
                        height: 50.h,
                      ),
                      label: Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: const Text("Already paid."),
                      ))
                ],
              ),
            ));
  }

  @override
  onEndAsyncFunction() {
    setState(() {
      loading = false;
    });
  }

  @override
  onInitFail() {
    setState(() {
      error = true;
    });
  }

  @override
  onInitSuccess() {}

  @override
  onStartAsyncFunction() {
    setState(() {
      loading = true;
    });
  }

  @override
  onUpdateFail() {
    Get.snackbar("ERROR", "An error has happened.");
  }

  @override
  onUpdateSuccess() {
    Get.snackbar("Done updating order", "Successfully update order.");
  }

  getStatusColor(String status) {
    if (status == "PENDING") return Colors.blueGrey.shade300;
    if (status == "PROCESSING") return Colors.yellow.shade400;
    if (status == "COMPLETED") return Colors.green.shade400;
    return Colors.red.shade300;
  }

  @override
  void onContactFail() {
    Get.snackbar("Error", "Cannot contact to the user");
  }
}

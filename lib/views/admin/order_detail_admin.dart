import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  late OrderDetailPresenter _presenter;

  bool loading = true;
  bool error = false;
  @override
  void initState() {
    super.initState();
    _presenter = OrderDetailPresenter(widget.order, contract: this);
    _presenter.init();
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
        child: loading || error
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
                                            "+${widget.order.totalPrice}",
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
                                                    color: widget
                                                                .order.status ==
                                                            "PENDING"
                                                        ? Colors.green.shade200
                                                        : Colors.red.shade200),
                                                child:
                                                    Text(widget.order.status)),
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Thời gian"),
                                            Text(widget.order.createAt
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
                                            Text((widget.order.id).toString()),
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Số lượng sản phầm"),
                                            Text(widget.order.items
                                                .map((e) => e.quantity)
                                                .reduce((value, element) =>
                                                    value + element)
                                                .toString()),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              if (!widget.order.isPaid)
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
                                        child: _presenter.user != null &&
                                                _presenter.user!.avatarUrl !=
                                                    null
                                            ? SvgPicture.network(
                                                _presenter.user!.avatarUrl!)
                                            : const Icon(Icons.person),
                                      ),
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
                                        Text((_presenter.user!.email ??
                                                "Unknown")
                                            .toString()),
                                      ]),
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
                  if (widget.order.status == OrderStatus.PENDING.toString() ||
                      widget.order.status == OrderStatus.PROCESSING.toString())
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: OutlinedButton(
                          onPressed: () {
                            _presenter.update(OrderStatus.PROCESSING);
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
                            "Accept order",
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
    for (var item in widget.order.items) {
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
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: const ImageIcon(AssetImage(
                          "assets/images/momo-primary-logo/MoMo Primary Logo/png/momo_icon_square_pinkbg_RGB.png")),
                      label: const Text("Thanh toán qua momo."))
                ],
              ),
            ));
    OrderRepository.pay(widget.order.id!, PaymentMethod.cash)
        .then((value) => launchUrl(Uri.parse(value)));
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
    // TODO: implement onUpdateFail
    throw UnimplementedError();
  }

  @override
  onUpdateSuccess() {
    // TODO: implement onUpdateSuccess
    throw UnimplementedError();
  }
}

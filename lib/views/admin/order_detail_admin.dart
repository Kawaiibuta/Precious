import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious/data_sources/order/order.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/resources/app_export.dart';

class OrderDetailAdmin extends StatefulWidget {
  const OrderDetailAdmin({super.key, required this.order});
  final Order order;
  @override
  _OrderDetailAdminState createState() => _OrderDetailAdminState();
}

class _OrderDetailAdminState extends State<OrderDetailAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Chi tiết đơn hàng",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
      ),
      body: Stack(
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                                BorderRadius.circular(200),
                                            color:
                                                widget.order.status == "PENDING"
                                                    ? Colors.green.shade200
                                                    : Colors.red.shade200),
                                        child: Text(widget.order.status)),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Thời gian"),
                                    Text(widget.order.createAt.toString()),
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
                                        .reduce(
                                            (value, element) => value + element)
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
                            "Liên hệ",
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
                    padding: EdgeInsets.all(10.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            children: [
                              Container(
                                width: 50.h,
                                height: 50.h,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                clipBehavior: Clip.antiAlias,
                                child: widget.order.user != null
                                    ? SvgPicture.network(
                                        widget.order.user!.avatar_url)
                                    : const Icon(Icons.person),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.order.user!.id.toString(),
                                  style: GoogleFonts.openSans(
                                      fontSize: 30.0.h,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Tuổi"),
                                Text(
                                    (widget.order.user!.age ?? "Không xác định")
                                        .toString()),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Email"),
                                Text((widget.order.user!.email ??
                                        "Không xác định")
                                    .toString()),
                              ]),
                        ),
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
                                  "Danh sách sản phẩm",
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
                                child:
                                    Text("Opss, something wrong has happened"),
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
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0.h))),
                ),
                child: Text(
                  "Xác nhận",
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
    );
  }

  Future<List<Widget>> buildOrderedItem() async {
    final productPresenter = ProductPresenter();
    var result = <Widget>[];
    for (var item in widget.order.items) {
      final product = await productPresenter.getOne(item.id, detail: true);
      result.add(Container(
        child: Row(
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
              child: CachedNetworkImage(imageUrl: product!.img_paths_url[0]),
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
                      Text(product.variants![item.variantId].price.toString()),
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
        ),
      ));
    }
    return result;
  }
}

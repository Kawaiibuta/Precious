import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:precious/data_sources/order/order.dart';
import 'package:precious/resources/app_export.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:precious/views/admin/order_detail_admin.dart';

class OrderCardAdmin extends StatefulWidget {
  const OrderCardAdmin(
      {super.key,
      this.backgroundColor = Colors.transparent,
      required this.order,
      this.icon = Icons.money});
  final Color backgroundColor;
  final Order order;
  final IconData icon;
  @override
  _OrderCardAdminState createState() => _OrderCardAdminState();
}

class _OrderCardAdminState extends State<OrderCardAdmin> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailAdmin(
                  order: widget.order,
                )));
      },
      child: Container(
        height: 100.h,
        padding: EdgeInsets.all(3.0.h),
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 40.v,
                    height: 40.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: widget.order.user != null
                        ? SvgPicture.network(widget.order.user!.avatar_url)
                        : Icon(Icons.person)),
                DefaultTextStyle(
                  style: GoogleFonts.openSans(color: Colors.black),
                  textAlign: TextAlign.left,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20.0.h, bottom: 15.0.h, left: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hoá đơn của khách hàng ${widget.order.userId} mã số ${widget.order.id!}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.h),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd – kk:mm')
                              .format(widget.order.createAt!),
                          style: TextStyle(fontSize: 12.h, color: Colors.grey),
                        ),
                        Text(
                          "Tình trạng: ${widget.order.status}",
                          style: TextStyle(fontSize: 12.h, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "${widget.order.totalPrice}",
                style: GoogleFonts.openSans(
                    fontSize: 18.h, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

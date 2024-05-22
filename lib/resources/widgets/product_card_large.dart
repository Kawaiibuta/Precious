import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/round_container_box.dart';

class ProductCardLarge extends StatelessWidget {
  final _numberFormat = NumberFormat.compact(locale: 'vi');

  final Product product;

  ProductCardLarge(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return RoundContainerBox(
        padding: EdgeInsets.all(8.h),
        hasShadow: true,
        shadowWidth: 1.h,
        child: Row(
          children: [
            SizedBox.square(
                dimension: 60.h,
                child:
                    Image.network(product.imgPathUrls[0], fit: BoxFit.cover)),
            SizedBox(width: 8.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  product.shortDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${_numberFormat.format(product.price)}đ',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            )
          ],
        ));
  }
}

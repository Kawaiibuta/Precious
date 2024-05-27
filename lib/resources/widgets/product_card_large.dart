import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/variant/variant.dart';
import 'package:precious/presenters/product_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/round_container_box.dart';

class ProductCardLarge extends StatelessWidget {
  final _numberFormat = NumberFormat.compact(locale: 'vi');

  final Variant variant;

  ProductCardLarge(this.variant, {super.key});

  @override
  Widget build(BuildContext context) {
    return RoundContainerBox(
        padding: EdgeInsets.all(16.h),
        hasShadow: true,
        shadowWidth: 1.h,
        child: Row(
          children: [
            SizedBox.square(
                dimension: 64.h,
                child:
                    Image.network(variant.imgPathUrls[0], fit: BoxFit.cover)),
            SizedBox(width: 16.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  variant.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  variant.variantOptionValues
                          ?.map((e) => e.optionValue)
                          .join(", ") ??
                      "",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                Text(
                  '${_numberFormat.format(variant.price)}đ',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            )
          ],
        ));
  }
}

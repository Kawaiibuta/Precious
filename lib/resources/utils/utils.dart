import 'package:precious/models/option/optionValue/option_value.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/variant/variant.dart';

class DataException implements Exception {
  String reason;
  DataException(this.reason);
}

Variant getVariant(Product product, List<OptionValue> optionList) {
  //Tìm trong danh sách varaint các đối tượng phụ hợp với optionList
  if (product.options.isEmpty) {
    throw DataException(
        "The product don't have options. Please try call API /api/variant/create_variant_for_product.");
  }
  if (product.variants.isEmpty) {
    throw DataException("The product don't have variants.");
  }

  final result = product.variants
      .where((variant) =>
          List.generate(product.options.length, (index) => index)
              .map((index) =>
                  variant.variantOptionValues![index].optionValue ==
                  optionList[index])
              .toList()
              .reduce((value, element) => value && element))
      .toList();
  if (result.isNotEmpty) {
    return result[0];
  } else {
    throw DataException("Cannot find the variant");
  }
}

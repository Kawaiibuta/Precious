import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_category.g.dart';
part 'product_category.freezed.dart';

@Freezed()
class ProductCategory with _$ProductCategory {
  factory ProductCategory({
    @Default(null) int? id,
    @Default("") String name,
  }) = _ProductCategory;
  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);
}

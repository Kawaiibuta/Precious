import 'package:precious/data_sources/category_repository.dart';
import 'package:precious/models/product_category/product_category.dart';

class ProductCategoryPresenter {
  static Map<int, ProductCategory> categoryList = {};

  Future<List<ProductCategory>> getAll() async {
    if (categoryList.values.isNotEmpty) return categoryList.values.toList();
    final result = await ProductCategoryRepository.getAll().then((value) {
      for (var element in value) {
        categoryList
            .addEntries(<int, ProductCategory>{element.id!: element}.entries);
      }
      return categoryList.values.toList();
    });
    result.insert(0, ProductCategory(id: -1, name: "All product"));
    return result;
  }

  Future<ProductCategory?> getOne(int id) async {
    if (categoryList.keys.contains(id)) return categoryList[id];
    final result = await ProductCategoryRepository.getOne(id);
    if (result != null) {
      categoryList
          .addEntries(<int, ProductCategory>{result.id!: result}.entries);
    }
    return result;
  }
}

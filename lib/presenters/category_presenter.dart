import 'package:precious/data_sources/category_reppsitory.dart';
import 'package:precious/models/product_category/product_category.dart';
import 'package:precious/presenters/base_presenter.dart';

class ProductCategoryPresenter implements Presenter {
  static Map<int, ProductCategory> categoryList = {};

  @override
  List<int> selected = [];
  @override
  Future<List<ProductCategory>> getAll(
      {bool more = false, bool reset = false}) async {
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

  @override
  Future<ProductCategory?> getOne(int id, {bool detail = false}) async {
    if (categoryList.keys.contains(id)) return categoryList[id];
    final result = await ProductCategoryRepository.getOne(id);
    if (result != null) {
      categoryList
          .addEntries(<int, ProductCategory>{result.id!: result}.entries);
    }
    return result;
  }

  @override
  delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}

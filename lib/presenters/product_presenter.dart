import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';

class ProductPresenter {
  static const Map<int, Product> productList = {};
  Future<List<Product>> getAll() async {
    if (productList.values.isNotEmpty) {
      return productList.values.toList();
    }
    final result = await ProductRepository.getAll().then((e) {
      for (var element in e) {
        productList.addEntries(<int, Product>{element.id!: element}.entries);
      }
      return e;
    });
    return result;
  }

  Future<Product?> getOne(int id) async {
    if (productList.keys.contains(id)) return productList[id]!;
    final result = await ProductRepository.getOne(id);
    return result;
  }
}

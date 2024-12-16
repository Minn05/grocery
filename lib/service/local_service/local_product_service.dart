import 'package:e_commerce/model/product.dart';
import 'package:hive/hive.dart';

class LocalProductService {
  late Box<Product> _popularProductBox;

  Future<void> init() async {
    _popularProductBox = await Hive.openBox<Product>('PopularProducts');
  }

  Future<void> assignAllPopularProducts(
      {required List<Product> popularProducts}) async {
    await _popularProductBox.clear();
    await _popularProductBox.addAll(popularProducts);
  }

  List<Product> getPopularProducts() => _popularProductBox.values.toList();
}

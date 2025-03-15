import 'package:flutter/widgets.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts {
    return _products.where((product) => product.isFavorite).toList();
  }

  void addProduct(final Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(final Product product) {
    _products.remove(product);
    notifyListeners();
  }
}

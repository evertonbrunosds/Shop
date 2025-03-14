import 'package:flutter/widgets.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = dummyProducts;
  bool _showFavoritesOnly = false;

  List<Product> get products =>
      _showFavoritesOnly
          ? _products.where((product) => product.isFavorite).toList()
          : [..._products];

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
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

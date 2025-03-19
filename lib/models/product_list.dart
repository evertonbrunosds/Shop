import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = dummyProducts;
  final _baseUrl = 'https://shop-cod3r-2-a90a3-default-rtdb.firebaseio.com';

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts {
    return _products.where((product) => product.isFavorite).toList();
  }

  void addProduct(final Product product) {
    final future = http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
      }),
    );
    future.then((response) {
      final id = jsonDecode(response.body)['name'];
      _products.add(
        Product(
          id: id,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        ),
      );
      notifyListeners();
    });
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void updateProduct(Product product) {
    int index = _products.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _products.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _products.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}

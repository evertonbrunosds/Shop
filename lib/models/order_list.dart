import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/cart.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utils/constants.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.ordersUrl}.json'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products':
            cart.items.values
                .map(
                  (cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productId,
                    'name': cartItem.name,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price,
                  },
                )
                .toList(),
      }),
    );
    // final id = jsonDecode(response.body)['id'];
    _items.insert(
      0,
      Order(
        id: 'id',
        total: cart.totalAmount,
        items: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}

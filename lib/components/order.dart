import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatelessWidget {
  final Order order;
  const OrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Total: R\$${order.total.toStringAsFixed(2)}'),
        subtitle: Text(
          'Data: ${DateFormat('dd/MM/yyyy hh:mm').format(order.date)}',
        ),
        trailing: IconButton(icon: Icon(Icons.expand_more), onPressed: () {}),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Total: R\$${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(
              'Data: ${DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date)}',
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => _expanded = !_expanded),
            ),
          ),
          if (_expanded)
            Container(
              height: widget.order.items.length * 25.0 + 25,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  final product = widget.order.items[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${product.quantity} x R\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  );
                },
                itemCount: widget.order.items.length,
              ),
            ),
        ],
      ),
    );
  }
}

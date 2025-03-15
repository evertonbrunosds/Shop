import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    ); // impossibilita a atualização generalizada do widget
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    ); // impossibilita a atualização generalizada do widget
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(product.name, textAlign: TextAlign.center),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product);
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            // possibilita a atualização específica do widget
            builder:
                (ctx, product, child) => IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: product.toggleFavorite,
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
        child: GestureDetector(
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(AppRoutes.productDetail, arguments: product);
          },
        ),
      ),
    );
  }
}

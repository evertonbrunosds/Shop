import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid_item.dart';
import 'package:shop/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoritesOnly;
  const ProductGrid({super.key, required this.showFavoritesOnly});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final loadedProducts =
        showFavoritesOnly ? provider.favoriteProducts : provider.products;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder:
          (ctx, i) => ChangeNotifierProvider.value(
            // para usar quando foi criado anteriormente
            value: loadedProducts[i],
            child: ProductGridItem(),
          ),
    );
  }
}

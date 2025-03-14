import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/product_list.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  value: FilterOptions.favorites,
                  child: Text('Somente Favoritos'),
                ),
                PopupMenuItem(value: FilterOptions.all, child: Text('Todos')),
              ];
            },
            onSelected:
                (selectedValue) =>
                    selectedValue == FilterOptions.favorites
                        ? provider.showFavoritesOnly()
                        : provider.showAll(),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ProductGrid(),
    );
  }
}

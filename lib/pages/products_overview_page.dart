import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badgee.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                _showFavoritesOnly = selectedValue == FilterOptions.favorites;
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.cart),
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) {
              return Badgee(value: cart.itemsCount.toString(), child: child!);
            },
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ProductGrid(showFavoritesOnly: _showFavoritesOnly),
      drawer: AppDrawer(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';

import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavoritesOnly;

  const ProductsGrid(this.showFavoritesOnly, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsProviderData = Provider.of<Products>(context);
    final products = showFavoritesOnly ? productsProviderData.favoriteItems : productsProviderData.items;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider<Product>.value(
        // see training: 199 @ 3:00
        value: products[index],
        // .value should be used when reusing existing Objects
        child: const ProductItem(),
      ),
    );
  }
}

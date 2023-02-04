import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products_provider.dart';

import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProviderData = Provider.of<ProductsProvider>(context);
    final products = productsProviderData.items;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider(
        create: (BuildContext context) => products[index],
        child: ProductItem(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screen/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary),
              onPressed: () {
                product.toggleFavoriteStatus();
              }),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart,
                  color: Theme.of(context).colorScheme.secondary),
              onPressed: () {}),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.favorite,
                  color: Theme.of(context).colorScheme.secondary),
              onPressed: () {}),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart,
                  color: Theme.of(context).colorScheme.secondary),
              onPressed: () {}),
        ),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

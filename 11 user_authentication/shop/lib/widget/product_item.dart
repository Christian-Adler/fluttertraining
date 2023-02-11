import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screen/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);
    // listen false to get the stable data only once
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            // listen here again to product to get changes on favorite - always and just re render the button
            builder: (ctx, product, _) => IconButton(
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).colorScheme.secondary),
                onPressed: () async {
                  try {
                    await product.toggleFavoriteStatus();
                  } catch (err) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
                  }
                }),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart, color: Theme.of(context).colorScheme.secondary),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              // Scaffold.of(context).openDrawer(); // open drawer ;)
              // Scaffold.of(context).showBodyScrim(true, 0.5); // Layer
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Added item to Cart',
                  ),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () => cart.removeSingleItem(product.id),
                  ),
                ),
              );
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
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

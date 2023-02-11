import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screen/edit_product_screen.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 96,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: product.id);
              },
              icon: const Icon(
                Icons.edit,
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false).deleteProduct(product.id);
                } catch (err) {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.delete,
              ),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}

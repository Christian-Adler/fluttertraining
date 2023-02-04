import 'package:flutter/material.dart';

import '../providers/cart.dart';

class CartListItem extends StatelessWidget {
  final CartItem cartItem;

  const CartListItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FittedBox(child: Text('${cartItem.price} €')),
            ),
          ),
          title: Text(cartItem.title),
          subtitle: Text('Total: ${cartItem.price * cartItem.quantity} €'),
          trailing: Text('${cartItem.quantity} x'),
        ),
      ),
    );
  }
}

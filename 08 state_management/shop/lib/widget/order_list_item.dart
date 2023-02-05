import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderListItem extends StatelessWidget {
  final OrderItem orderItem;

  const OrderListItem(this.orderItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('${orderItem.amount} €'),
          subtitle: Text(
            DateFormat('dd MM yyyy hh:mm').format(orderItem.dateTime),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.expand_more),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}

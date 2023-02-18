import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderListItem extends StatefulWidget {
  final OrderItem orderItem;

  const OrderListItem(this.orderItem, {Key? key}) : super(key: key);

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool _expanded = false;

  void _toggleExpand() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded ? min(widget.orderItem.products.length * 20 + 110, 200) : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          ListTile(
            title: Text('${widget.orderItem.amount} €'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.orderItem.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => _toggleExpand(),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: _expanded ? min(widget.orderItem.products.length * 20 + 10, 100) : 0,
            child: ListView.builder(
              itemBuilder: (context, index) {
                var cartItem = widget.orderItem.products[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartItem.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${cartItem.quantity} x ${cartItem.price} €',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                );
              },
              itemCount: widget.orderItem.products.length,
            ),
          ),
        ]),
      ),
    );
  }
}

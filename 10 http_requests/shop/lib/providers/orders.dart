import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/globals.dart';
import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({required this.id, required this.amount, required this.products, required this.dateTime});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https(Globals.backendURL, '/orders.json');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'productId': cp.productId,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList()
        },
      ),
    );

    var generatedId = jsonDecode(response.body)['name'];

    _orders.insert(0, OrderItem(id: generatedId, dateTime: timestamp, products: cartProducts, amount: total));

    notifyListeners();
  }
}

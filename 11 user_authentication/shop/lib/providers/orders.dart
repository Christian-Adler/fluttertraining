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
  final String? _authToken;
  final String? _userId;
  final List<OrderItem> _orders;

  Orders(this._authToken, this._userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.https(Globals.backendURL, '/orders/$_userId.json', {'auth': _authToken});
    final List<OrderItem> loadedOrders = [];
    final response = await http.get(url);
    var decodedBody = jsonDecode(response.body);
    if (decodedBody == null) return;

    var extracted = decodedBody as Map<String, dynamic>;
    extracted.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  productId: item['productId'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime'])));
    });

    _orders.clear();
    _orders.addAll(loadedOrders.reversed.toList());
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https(Globals.backendURL, '/orders/$_userId.json', {'auth': _authToken});
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

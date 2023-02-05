import 'package:flutter/widgets.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _updateItem(productId, 1);
    } else {
      _items.putIfAbsent(productId,
          () => CartItem(id: DateTime.now().toString(), productId: productId, title: title, quantity: 1, price: price));
    }

    notifyListeners();
  }

  void _updateItem(String productId, int value) {
    _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            productId: existingCartItem.productId,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity + value,
            price: existingCartItem.price));
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if ((_items[productId] as CartItem).quantity > 1) {
      _updateItem(productId, -1);
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
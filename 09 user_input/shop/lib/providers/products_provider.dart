import 'package:flutter/material.dart';

import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // Would be a global filter (not only in a widget)
  // var _showFavoritesOnly = false;
  //
  // void showOnlyFavorites(bool val) {
  //   _showFavoritesOnly = val;
  //   notifyListeners();
  // }

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((p) => p.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((p) => p.isFavorite).toList();
  }

  Product findById(String productId) {
    return _items.firstWhere((p) => p.id == productId);
  }

  void addProduct(Product product) {
    var newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final idx = _items.indexWhere((p) => p.id == product.id);
    if (idx >= 0) _items[idx] = product;
    notifyListeners();
  }

  void deleteProduct(String productId) {
    _items.removeWhere((p) => p.id == productId);
    notifyListeners();
  }
}

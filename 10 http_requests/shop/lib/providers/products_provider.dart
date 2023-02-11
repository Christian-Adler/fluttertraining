import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // with alias to scope all of http.dart
import 'package:shop/models/http_exception.dart';

import 'product.dart';

class ProductsProvider with ChangeNotifier {
  static const backendURL = 'flutter-http-563e6-default-rtdb.europe-west1.firebasedatabase.app';
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
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

  Future<void> fetchAndSetProducts() async {
    final url = Uri.https(backendURL, '/products.json');
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: prodData['isFavorite'],
        ));
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(backendURL, '/products.json');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        }),
      );

      var res = json.decode(response.body);
      // print(res);

      var newProduct = Product(
          id: res['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (err) {
      // print(err);
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    final idx = _items.indexWhere((p) => p.id == product.id);
    if (idx >= 0) {
      final url = Uri.https(backendURL, '/products/${product.id}.json');

      await http.patch(
        url,
        body: json.encode({
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl
        }),
      );

      _items[idx] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productId) async {
    final existingProductIdx = _items.indexWhere((p) => p.id == productId);
    Product? existingProduct = _items[existingProductIdx];
    _items.removeAt(existingProductIdx);
    notifyListeners();

    // optimistic updating with rollback on fail
    final url = Uri.https(backendURL, '/products/$productId.json');
    final response = await http.delete(url);

    // Bei post|patch wird autom. Exception geworfen - bei delete nicht
    if (response.statusCode >= 400) {
      _items.insert(existingProductIdx, existingProduct);
      notifyListeners();

      throw HttpException('Could not delete product');
    }

    existingProduct = null;
  }
}

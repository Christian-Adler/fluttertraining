import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // with alias to scope all of http.dart
import 'package:shop/models/globals.dart';
import 'package:shop/models/http_exception.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final String? authToken;
  final String? userId;
  final List<Product> _items;

  Products(this.authToken, this.userId, this._items);

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

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    if (userId == null) return;
    Map<String, dynamic> queryParameters = {
      'auth': authToken,
    };
    if (filterByUser) {
      queryParameters.addAll({'orderBy': '"creatorId"', 'equalTo': '"$userId"'});
    }
    var url =
        Uri.https(Globals.backendURL, '/products.json', queryParameters); // double quotes are required by firebase
    try {
      final response = await http.get(url);
      var decodedBody = jsonDecode(response.body);
      if (decodedBody == null) return;

      url = Uri.https(Globals.backendURL, '/userFavorites/$userId.json', {'auth': authToken});
      final responseFavorites = await http.get(url);
      final favoriteData = jsonDecode(responseFavorites.body);

      final extractedData = decodedBody as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });

      _items.clear();
      _items.addAll(loadedProducts);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(Globals.backendURL, '/products.json', {'auth': authToken});

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          'creatorId': userId,
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
      final url = Uri.https(Globals.backendURL, '/products/${product.id}.json', {'auth': authToken});

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
    final url = Uri.https(Globals.backendURL, '/products/$productId.json', {'auth': authToken});
    final response = await http.delete(url);

    // Bei post/get wird autom. Exception geworfen - bei delete nicht
    if (response.statusCode >= 400) {
      _items.insert(existingProductIdx, existingProduct);
      notifyListeners();

      throw HttpException('Could not delete product');
    }

    existingProduct = null;
  }
}

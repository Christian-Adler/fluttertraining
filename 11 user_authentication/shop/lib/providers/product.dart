import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/http_exception.dart';

import '../models/globals.dart'; // with alias to scope all of http.dart

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus(String? token) async {
    final oldValue = isFavorite;
    final url = Uri.https(Globals.backendURL, '/products/$id.json', {'auth': token});
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      // http wirft nur bei get/post eigene exception.
      // Daher bei patch selbst statusCode auswerten.
      // Aber trotzdem try catch wg. z.B. Netzwerkfehler.
      var response = await http.patch(
        url,
        body: json.encode({
          "isFavorite": !isFavorite,
        }),
      );

      if (response.statusCode >= 400) {
        throw HttpException('Update favorite failed!');
      }
    } catch (err) {
      isFavorite = oldValue;
      notifyListeners();
      rethrow;
    }
  }
}
